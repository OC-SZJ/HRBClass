//
//  BaseTableVC+Tool.m
//  Test
//
//  Created by mac on 2019/10/15.
//  Copyright © 2019 SZJ. All rights reserved.
//

#import "BaseTableVC+Tool.h"
#import "BaseTableViewHeaderFooterView.h"
@implementation BaseTableVC (Tool)

- (NSInteger)countSection{
    
    if (self.isMoreGroup || self.tableView.style == UITableViewStyleGrouped) {
        return self.dataSource.dataSource.count;
    }
    if (self.isSigleGroup) {
        return 1;
    }
    
    if (self.tableViewUI) {
        return [self getTableViewUI:nil].sectionCount;
    }
    
    return 0;
}

- (NSInteger)countRow:(NSInteger)section{
    
    if (self.isMoreGroup) {
        NSArray *arr = self.dataSource.dataSource[section];
        return arr.count;
    }
    
    if (self.tableView.style == UITableViewStyleGrouped) {
        return 1;
    }
    
    if (self.isSigleGroup) {
        return self.dataSource.dataSource.count;
    }
    
    if (self.tableViewUI) {
        return [self getTableViewUI:[NSIndexPath indexPathForRow:-1 inSection:section]].rowsCount;
    }
    
    return 0;
}

- (__kindof UITableViewCell *)getCell:(NSIndexPath *)indexPath{
    NSString *class = @"";
    
    BaseModel *model =  [self getModel:indexPath];
    
    if (self.isMoreGroup || self.isSigleGroup) {
        class = NSStringFromClass(model.cellClass);
    }else{
        class = GetClassStr([self getTableViewUI:indexPath].classArr,indexPath);
    }
    
    BaseTableViewCell *  cell = [self.tableView dequeueReusableCellWithIdentifier:class];
    if (!cell) {
        cell = [NSBundle.mainBundle loadNibNamed:class owner:nil options:nil].firstObject;
    }
    cell.indexPath = indexPath;
    cell.model = model;
    cell.cellEvent = self.tableViewEvent;
    return cell;
}

- (CGFloat)cellHeight:(NSIndexPath *)indexPath{
    BaseModel *model = [self getModel:indexPath];
    if (self.isMoreGroup || self.isSigleGroup) {
        return [[model cellClass] cellHeight:model];
    }
    
    NSString *class = GetClassStr([self getTableViewUI:indexPath].classArr,indexPath);
    Class cellClass = NSClassFromString(class);
    return [cellClass cellHeight:model];
}

- (BaseModel *)getModel:(NSIndexPath *)indexPath{
    if (self.isMoreGroup ) {
        NSArray *arr = self.dataSource.dataSource[indexPath.section];
        return arr[indexPath.row];
    }
    
    if (self.isSigleGroup) {
        return self.dataSource.dataSource[indexPath.row];
    }
    
    if (self.dataSource.dataSource.count != 0){
        if (self.tableView.style == UITableViewStylePlain){
            return self.dataSource.dataSource[indexPath.row];
        }
        if (self.tableView.style == UITableViewStyleGrouped)
        {
            return self.dataSource.dataSource[indexPath.section];
        }
    }
    return [self getTableViewUI:indexPath].model;
}

-(UIView *)header:(NSInteger)section{
    BaseTableViewHeaderFooterView *header = nil;
    if ([self.noHeaderArr containsObject:@(section)]) return header;
    
    if (self.tableViewUI && [self getTableViewUI:[NSIndexPath indexPathForRow:-1 inSection:section]].headerHeight) {
        header = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseTableViewHeaderFooterView"];
        if (!header) {
            header = [[NSBundle mainBundle] loadNibNamed:@"BaseTableViewHeaderFooterView" owner:nil options:nil].firstObject;
        }
        
    }else{
        if ( self.hfArr && self.hfArr.count >= 1) {
            if ([self.hfArr[0] isEqualToString:@""])return header;
            Class Header = NSClassFromString(self.hfArr[0]);
            
            id headerView = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:self.hfArr[0]];
            if (!headerView) {
                headerView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(Header) owner:nil options:nil].firstObject;
            }
            [headerView setSection:section];
            [headerView setHeaderFooterEvent:self.tableViewEvent];
            [headerView setModel:[self getHeaderModel:section]];
            header = headerView;
        }
    }
    return header;
}
-(CGFloat)headerHeight:(NSInteger)section{
    if ([self.noHeaderArr containsObject:@(section)]) return CGFLOAT_MIN;
    if (self.hfArr && self.hfArr.count >= 1) {
        Class Header = NSClassFromString(self.hfArr[0]);
        if (Header)return [Header viewHeight:[self getHeaderModel:section] withSection:section];
    }
    if (self.tableViewUI) {
        return [self getTableViewUI:[NSIndexPath indexPathForRow:-1 inSection:section]].headerHeight;
    }
    return CGFLOAT_MIN;
}
-(UIView *)footer:(NSInteger)section{
    BaseTableViewHeaderFooterView *footer = nil;
    if ([self.noFooterArr containsObject:@(section)]) return footer;
    if (self.tableViewUI &&[self getTableViewUI:[NSIndexPath indexPathForRow:-1 inSection:section]].footerHeight > 0) {
        footer = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:@"BaseTableViewHeaderFooterView"];
        if (!footer) {
            footer = [[NSBundle mainBundle] loadNibNamed:@"BaseTableViewHeaderFooterView" owner:nil options:nil].firstObject;
        }
    }else{
        if (self.hfArr && self.hfArr.count == 2) {
            if ([self.hfArr[1] isEqualToString:@""])return footer;
            Class Footer = NSClassFromString(self.hfArr[1]);
            id footerView = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:self.hfArr[1]];
            if (!footerView) {
                footerView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(Footer) owner:nil options:nil].firstObject;
            }
            [footerView setSection:section];
            [footerView setHeaderFooterEvent:self.tableViewEvent];
            [footerView setModel:[self getFooterModel:section]];
            footer = footerView;
        }
    }
    return footer;
}
-(CGFloat)footerHeight:(NSInteger)section{
    if ([self.noFooterArr containsObject:@(section)]) return CGFLOAT_MIN;
    if (self.hfArr && self.hfArr.count == 2) {
        if ([self.hfArr[1] isEqualToString:@""])return CGFLOAT_MIN;
        Class Footer = NSClassFromString(self.hfArr[1]);
        if (Footer)return [Footer viewHeight:[self getFooterModel:section] withSection:section];
    }
    if (self.tableViewUI) {
        return [self getTableViewUI:[NSIndexPath indexPathForRow:-1 inSection:section]].footerHeight;
    }
    
    return CGFLOAT_MIN;
}

-(void)selectAtIndex:(NSIndexPath *)indexPath{
    if (self.tableViewUI) [self getTableViewUI:indexPath].tableViewSelectAtIndex(indexPath, self);
    
}


- (NSArray <UIContextualAction *> *)leftSlideAction:(NSIndexPath *)indexPath{
    
    if (self.tableViewUI && [self getTableViewUI:indexPath].getActions && [self getTableViewUI:indexPath].getActions.count > 0) {
        NSMutableArray *a = @[].mutableCopy;
        for (TableViewLeftSlideAction *tlsa in [self getTableViewUI:indexPath].getActions) {
            UIContextualAction *action = [UIContextualAction contextualActionWithStyle:UIContextualActionStyleDestructive
                                                                                 title:tlsa.t_title
                                                                               handler:^(UIContextualAction * _Nonnull action, __kindof UIView * _Nonnull sourceView, void (^ _Nonnull completionHandler)(BOOL)) {
                if (tlsa.result) {
                    tlsa.t_result(indexPath);
                }
                
                completionHandler(YES);
            }];
            if (tlsa.backColor) {
                action.backgroundColor = tlsa.t_backColor;
            }
            if (tlsa.backImage) {
                action.image = tlsa.t_backImage;//若仅设置此属性，会被系统渲染
            }
            [a addObject:action];
        }
       
        return a;
    }
    return nil;
   
}
- (BOOL)isMoreGroup{
    return !self.tableViewUI && self.dataSource.dataSource.count > 0 && [self.dataSource.dataSource.firstObject isKindOfClass:NSArray.class];
}

- (BOOL)isSigleGroup{
    if (self.dataSource.dataSource.count > 0){
        if (!self.tableViewUI) {
            return YES;
        }
        if ([self getTableViewUI:nil].sectionCount == 0) {
            return YES;
        }
    }
    return NO;
}

- (BaseTableViewUI *)getTableViewUI:(NSIndexPath *)indexPath{
    BaseTableViewUI *UI = BaseTableViewUI.new;
    if (!indexPath) {
        indexPath = [NSIndexPath indexPathForRow:-1 inSection:-1];
    }
    self.tableViewUI(UI, indexPath, self);
    return UI;
}

-(NSArray *)noHeaderArr{
    NSArray *arr = @[];
    if (self.tableViewUI)arr = [self getTableViewUI:nil].noHeaderSections;
    if (self.dataSource.noHeader)arr = self.dataSource.noHeader.copy;
    return arr;
}

-(NSArray *)noFooterArr{
    NSArray *arr = @[];
    if (self.tableViewUI)arr = [self getTableViewUI:nil].noFooterSections;
    if (self.dataSource.noFooter)arr = self.dataSource.noFooter.copy;
    return arr;
}

-(NSArray *)hfArr{
    NSArray *arr;
    if (self.tableViewUI)arr = [self getTableViewUI:[NSIndexPath indexPathForRow:-1 inSection:-1]].viewClassForSectionFooterHeader;
    if (!arr){
        NSMutableArray *a = @[].mutableCopy;
        if (self.dataSource.headerClass.length > 0) {
            [a addObject:self.dataSource.headerClass];
        }
        if (self.dataSource.footerClass.length > 0) {
            if (a.count == 0)[a addObject:@""];
            [a addObject:self.dataSource.footerClass];
        }
        arr = a.copy;
    }
    return arr;
}



-(BaseModel *)getHeaderModel:(NSInteger)section{
    BaseModel *model = nil;
    if (self.tableViewUI)model = [self getTableViewUI:[NSIndexPath indexPathForRow:-1 inSection:section]].headerModel;
    
    if (self.dataSource.headerModels) {
        model = self.dataSource.headerModels[section];
    }
    
    return model;
}
-(BaseModel *)getFooterModel:(NSInteger)section{
    BaseModel *model = nil;
    if (self.tableViewUI)model = [self getTableViewUI:[NSIndexPath indexPathForRow:-1 inSection:section]].footerModel;
    if (self.dataSource.footerModels) {
        model = self.dataSource.footerModels[section];
    }
    
    return model;
}
@end
