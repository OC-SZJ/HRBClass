//
//  UICollectionView+Tool.m
//  ocCrazy
//
//  Created by mac on 2018/5/21.
//  Copyright © 2018年 dukai. All rights reserved.
//

#import "UICollectionView+Tool.h"



@implementation UICollectionView (Tool)

- (void)cc_endReFresh:(NSArray *)array{
    [self.mj_header endRefreshing];
    if (array.count == 0) {
        [self.mj_footer endRefreshingWithNoMoreData];
    }else{
        [self.mj_footer endRefreshing];
    }
    [self reloadData];
}

- (void)setCellArrForResCell:(NSArray <NSString *> *)arr{
    [arr enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self registerNibReuseIdentifier:NSClassFromString(obj)];
    }];
}

- (void)setHeaderWithClass:(NSString *)header withFooter:(NSString *)footer{
    if (header && ![header isEqualToString:@""]) {
        [self registerNib:[UINib nibWithNibName:header bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:header];
    }
    if (footer && ![footer isEqualToString:@""]) {
        [self registerNib:[UINib nibWithNibName:footer bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footer];
    }
    
}

- (void)registerNibReuseIdentifier:(Class)class{
    NSString *classStr = NSStringFromClass(class);
    [self registerNib:[UINib nibWithNibName:classStr bundle:nil] forCellWithReuseIdentifier:classStr];
}
@end
