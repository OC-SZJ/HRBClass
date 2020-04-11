//
//  UITableView+Tool.h
//  ocCrazy
//
//  Created by mac on 2018/5/14.
//  Copyright © 2018年 dukai. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MJRefresh.h"

@interface UITableView (Tool)

- (void)cc_endReFresh:(NSArray *)array;

- (void)isGroup;

- (void)sectionHeader:(CGFloat)header footer:(CGFloat)footer;

- (void)registerNibReuseIdentifier:(Class)aclass;

-(void)setCellArrForResCell:(NSArray <NSString *> *)arr;

- (void)setHeaderFooterArr:(NSArray <NSString *> *)arr;

- (void)scrollToFooterView;
@end
