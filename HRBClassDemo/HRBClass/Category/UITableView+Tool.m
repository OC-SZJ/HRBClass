//
//  UITableView+Tool.m
//  ocCrazy
//
//  Created by mac on 2018/5/14.
//  Copyright © 2018年 dukai. All rights reserved.
//

#import "UITableView+Tool.h"

@implementation UITableView (Tool)

- (void)cc_endReFresh:(NSArray *)array{
    [self.mj_header endRefreshing];
    if ([array isKindOfClass:NSArray.class]) {
        if (array.count == 0) {
            [self.mj_footer endRefreshingWithNoMoreData];
        }else{
            [self.mj_footer endRefreshing];
        }
    }else{
        [self.mj_footer endRefreshingWithNoMoreData];
    }
    [self reloadData];
}

- (void)isGroup{
    if (self.style == UITableViewStyleGrouped) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGFLOAT_MIN, CGFLOAT_MIN)];
        if (self.tableHeaderView.subviews.count == 0)self.tableFooterView = view;
        if (self.tableFooterView.subviews.count == 0)self.tableHeaderView = view;
    }
}

-(void)setCellArrForResCell:(NSArray <NSString *> *)arr{
    [arr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self registerNibReuseIdentifier:NSClassFromString(obj)];
    }];
}

- (void)setHeaderFooterArr:(NSArray <NSString *> *)arr{
    if (arr.count == 0 || !arr) return;
    if (arr.count > 1) {

        [self registerNib:[UINib nibWithNibName:arr[1] bundle:nil] forHeaderFooterViewReuseIdentifier:arr[1]];
    }
    if (arr[0] != nil && ![arr[0] isEqualToString:@""]) {
          [self registerNib:[UINib nibWithNibName:arr[0] bundle:nil] forHeaderFooterViewReuseIdentifier:arr[0]];
    }

}

- (void)sectionHeader:(CGFloat)header footer:(CGFloat)footer{
    self.sectionFooterHeight = footer;
    self.sectionHeaderHeight = header;
}

- (void)registerNibReuseIdentifier:(Class)aclass{
    NSString *classStr = NSStringFromClass(aclass);
    [self registerNib:[UINib nibWithNibName:classStr bundle:nil] forCellReuseIdentifier:classStr];
}

- (void)scrollToFooterView {

    NSUInteger num = [self numberOfRowsInSection:0];
    if (num > 0) {
        
        CGRect footerRect = [self convertRect:self.tableFooterView.frame fromView:self];
        if (footerRect.origin.y + footerRect.size.height < self.bounds.size.height) {
            return ;
        }
        
        [UIView animateWithDuration:0.25 animations:^{
            [self scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:
                                                    [self numberOfRowsInSection:0]-1 inSection:0]
                                  atScrollPosition:UITableViewScrollPositionTop animated:NO];
        } completion:^(BOOL finished) {
            if (CGRectGetMinY(self.tableFooterView.frame) > self.bounds.size.height + self.contentOffset.y) {
                
                CGRect footerRect = [self convertRect:self.tableFooterView.frame fromView:self];
                dispatch_async(dispatch_get_main_queue(), ^{
                    CGPoint newContentOffset = CGPointMake(0, footerRect.origin.y - self.bounds.size.height + 25);
                    if (newContentOffset.y + self.bounds.size.height > self.contentSize.height) {
                        newContentOffset.y = self.contentSize.height - self.bounds.size.height;
                    }
                    [self setContentOffset:newContentOffset animated:YES];
                });
            }
        }];
        
    }
}

@end
