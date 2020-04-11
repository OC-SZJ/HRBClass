//
//  AppDelegate+Tool.h
//  AutoCare365
//
//  Created by SZJ on 2018/8/26.
//  Copyright © 2018年 SZJ. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseViewController.h"
@interface AppDelegate (Tool)

+(BaseViewController *)getCurrentVC;
- (void)setRootViewController:(__kindof UIViewController *)rootViewController;
+ (void)setRootViewController:(__kindof UIViewController *)rootViewController;
+ (void)addSubview:(__kindof UIView *)view;
+ (void)presentVC:(UIViewController *)vc;
@end
