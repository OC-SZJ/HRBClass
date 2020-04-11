//
//  BaseCollectionVC+Tool.m
//  FrameWork
//
//  Created by SZJ on 2020/3/16.
//  Copyright © 2020 SZJ. All rights reserved.
//

#import "BaseCollectionVC+Tool.h"

#import "BaseCollectionViewCell.h"
@implementation BaseCollectionVC (Tool)

- (NSInteger)countSection{
    
    if (self.isMoreGroup) {
        return self.dataSource.dataSource.count;
    }
    if (self.collectionViewUI) {
        BaseCollectionViewUI *ui = [self getCollectionViewUI:nil];
        if (ui.sectionCount != 0) {
            return ui.sectionCount;
        }
    }
    return 1;
}

- (NSInteger)countItem:(NSInteger)section{
    
    if (self.isMoreGroup) {
        NSArray *arr = self.dataSource.dataSource[section];
        return arr.count;
    }
   
    if (self.collectionViewUI) {
        BaseCollectionViewUI *ui = [self getCollectionViewUI:[NSIndexPath indexPathForRow:-1 inSection:section]];
        if (ui.itemsCount != 0) {
            return ui.itemsCount;
        }else{
            return self.dataSource.dataSource.count;
        }
    }
    return 0;
}

- (__kindof UICollectionViewCell *)getCell:(NSIndexPath *)indexPath{
    NSString *class = @"";
    
    BaseModel *model =  [self getModel:indexPath];
    
    if (self.isMoreGroup) {
        class = NSStringFromClass(model.cellClass);
    }else{
        class = GetClassStr([self getCollectionViewUI:indexPath].classArr,indexPath);
        if (!class)class = NSStringFromClass(model.cellClass);
    }
    [self.collectionView registerNib:[UINib nibStr:NSClassFromString(class)] forCellWithReuseIdentifier:class];
    BaseCollectionViewCell *  cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:class forIndexPath:indexPath];
    if (!cell) {
        cell = [NSBundle.mainBundle loadNibNamed:class owner:nil options:nil].firstObject;
    }
    cell.indexPath = indexPath;
    cell.model = model;
    cell.cellEvent = self.collectionViewEvent;
    return cell;
}

- (CGSize)cellSize:(NSIndexPath *)indexPath{
    BaseModel *model = [self getModel:indexPath];
    if (self.isMoreGroup) {
        return [[model cellClass] cellSize:model];
    }
    NSString *class = GetClassStr([self getCollectionViewUI:indexPath].classArr,indexPath);
    if (!class) {
        return [[model cellClass] cellSize:model];
    }
    Class cellClass = NSClassFromString(class);
    return [cellClass cellSize:model];
}

- (BaseModel *)getModel:(NSIndexPath *)indexPath{
    if (self.isMoreGroup) {
        NSArray *arr = self.dataSource.dataSource[indexPath.section];
        return arr[indexPath.item];
    }
    
    if (self.dataSource.dataSource.count != 0){
        return self.dataSource.dataSource[indexPath.item];
    }
    return [self getCollectionViewUI:indexPath].model;
}

-(UIView *)header:(NSIndexPath *)indexPath{
    BaseCollectionReusableView *header = nil;
    if ([self.noHeaderArr containsObject:@(indexPath.section)]) return header;
    
    if ([self getCollectionViewUI:indexPath].headerSize.height > 0) {
        header = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"BaseCollectionReusableView" forIndexPath:indexPath];
        if (!header) {
            header = [[NSBundle mainBundle] loadNibNamed:@"BaseCollectionReusableView" owner:nil options:nil].firstObject;
        }
        
    }else{
        if ( self.hfArr && self.hfArr.count >= 1) {
            if ([self.hfArr[0] isEqualToString:@""])return header;
            Class Header = NSClassFromString(self.hfArr[0]);
            
            id headerView = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:self.hfArr[0] forIndexPath:indexPath];
            if (!headerView) {
                headerView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(Header) owner:nil options:nil].firstObject;
            }
            [headerView setSection:indexPath.section];
            [headerView setHfEvent:self.collectionViewEvent];
            [headerView setModel:[self getHeaderModel:indexPath.section]];
            header = headerView;
        }
    }
    return header;
}
-(CGSize)headerSize:(NSInteger)section{
    if ([self.noHeaderArr containsObject:@(section)]) return CGSizeZero;
    if (self.hfArr && self.hfArr.count >= 1) {
        Class Header = NSClassFromString(self.hfArr[0]);
        if (Header)return [Header viewSize:[self getHeaderModel:section] withSection:section];
    }
    return [self getCollectionViewUI:[NSIndexPath indexPathForRow:-1 inSection:section]].headerSize;
}
-(UIView *)footer:(NSIndexPath *)indexPath{
    BaseCollectionReusableView *footer = nil;
    if ([self.noFooterArr containsObject:@(indexPath.section)]) return footer;
    if ([self getCollectionViewUI:[NSIndexPath indexPathForRow:-1 inSection:indexPath.section]].footerSize.height > 0) {
        footer = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"BaseCollectionReusableView" forIndexPath:indexPath];
        if (!footer) {
            footer = [[NSBundle mainBundle] loadNibNamed:@"BaseTableViewHeaderFooterView" owner:nil options:nil].firstObject;
        }
    }else{
        if (self.hfArr && self.hfArr.count == 2) {
            if ([self.hfArr[1] isEqualToString:@""])return footer;
            Class Footer = NSClassFromString(self.hfArr[1]);
            id footerView = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:self.hfArr[1] forIndexPath:indexPath];
            if (!footerView) {
                footerView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(Footer) owner:nil options:nil].firstObject;
            }
            [footerView setSection:indexPath.section];
            [footerView setHfEvent:self.collectionViewEvent];
            [footerView setModel:[self getFooterModel:indexPath.section]];
            footer = footerView;
        }
    }
    return footer;
}
-(CGSize)footerSize:(NSInteger)section{
    if ([self.noFooterArr containsObject:@(section)]) return CGSizeZero;
    if (self.hfArr && self.hfArr.count == 2) {
        if ([self.hfArr[1] isEqualToString:@""])return CGSizeZero;
        Class Footer = NSClassFromString(self.hfArr[1]);
        if (Footer)return [Footer viewSize:[self getHeaderModel:section] withSection:section];
    }
    return [self getCollectionViewUI:[NSIndexPath indexPathForRow:-1 inSection:section]].footerSize;
}

-(void)selectAtIndex:(NSIndexPath *)indexPath{
    if ([self getCollectionViewUI:indexPath].collectionViewSelectAtIndexPath) {
        [self getCollectionViewUI:indexPath].collectionViewSelectAtIndexPath(indexPath, self);
    }
    
}
- (BOOL)isMoreGroup{
    return !self.collectionViewUI && self.dataSource.dataSource.count > 0 && [self.dataSource.dataSource.firstObject isKindOfClass:NSArray.class];
}

- (BaseCollectionViewUI *)getCollectionViewUI:(NSIndexPath *)indexPath{
    BaseCollectionViewUI *UI = BaseCollectionViewUI.new;
    if (!indexPath) {
        indexPath = [NSIndexPath indexPathForRow:-1 inSection:-1];
    }
    if (self.collectionViewUI) {
        self.collectionViewUI(UI, indexPath, self);
    }
    return UI;
}

-(NSArray *)noHeaderArr{
    NSArray *arr = @[];
    arr = [self getCollectionViewUI:nil].noHeaderSections;
    if (self.dataSource.noHeader)arr = self.dataSource.noHeader.copy;
    return arr;
}

-(NSArray *)noFooterArr{
    NSArray *arr = @[];
    arr = [self getCollectionViewUI:nil].noFooterSections;
    if (self.dataSource.noFooter)arr = self.dataSource.noFooter.copy;
    return arr;
}

-(NSArray *)hfArr{
    NSArray *arr = [self getCollectionViewUI:[NSIndexPath indexPathForRow:-1 inSection:-1]].viewClassForSectionFooterHeader;
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
    BaseModel *model = [self getCollectionViewUI:[NSIndexPath indexPathForRow:-1 inSection:section]].headerModel;
    
    if (self.dataSource.headerModels) {
       model = self.dataSource.headerModels[section];
    }
    
    return model;
}
-(BaseModel *)getFooterModel:(NSInteger)section{
    BaseModel *model = [self getCollectionViewUI:[NSIndexPath indexPathForRow:-1 inSection:section]].footerModel;
    
    if (self.dataSource.footerModels) {
        model = self.dataSource.footerModels[section];
    }
    
    return model;
}
@end
