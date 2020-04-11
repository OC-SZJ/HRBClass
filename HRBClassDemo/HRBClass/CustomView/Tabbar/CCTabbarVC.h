//
//  CCTabbarVC.h
//  AutoCare365
//
//  Created by mac on 2018/8/21.
//  Copyright © 2018年 SZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCTabbarVC : UITabBarController
/*
 单利
 */
+ (instancetype)share;
/*
 获取当前tabbar
 */
+ (CCTabbarVC *)getTab;
/*
 跳转 到第几个tabbar 然后那个回调的参数是  目标的根视图
 */
+ (void)setIndex:(NSInteger)index withAction:(void(^)(__kindof UIViewController *))action;
@end






