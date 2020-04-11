//
//  UICollectionView+Tool.h
//  ocCrazy
//
//  Created by mac on 2018/5/21.
//  Copyright © 2018年 dukai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJRefresh.h"
@interface UICollectionView (Tool)

- (void)cc_endReFresh:(NSArray *)array;

-(void)setCellArrForResCell:(NSArray <NSString *> *)arr;

- (void)setHeaderWithClass:(NSString *)header withFooter:(NSString *)footer;

@end
