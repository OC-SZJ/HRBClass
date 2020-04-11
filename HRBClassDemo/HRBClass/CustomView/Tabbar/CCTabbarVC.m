//
//  CCTabbarVC.m
//  AutoCare365
//
//  Created by mac on 2018/8/21.
//  Copyright © 2018年 SZJ. All rights reserved.
//

#import "CCTabbarVC.h"
#import "BaseNavigationController.h"



CCTabbarVC *_tabbr = nil;

@interface CCTabbarVC ()<UITabBarControllerDelegate>

@property (nonatomic,strong) UIView * test;

@end



@implementation CCTabbarVC

+ (instancetype)share{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _tabbr = [[CCTabbarVC alloc] init];
    });
    return _tabbr;
}

+ (CCTabbarVC *)getTab{
    return (CCTabbarVC *)[UIApplication sharedApplication].keyWindow.rootViewController;
}

+ (void)setIndex:(NSInteger)index withAction:(void(^)(__kindof UIViewController *))action{
    
    BaseNavigationController *nav = CCTabbarVC.getTab.viewControllers[index];
    if (action) action(nav.viewControllers[0]);
    CCTabbarVC.getTab.selectedIndex = index;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configChildControllers];
    LC_WEAK_SELF
    self.delegate = weakSelf;
}



- (void)configChildControllers {
    NSArray *vcArr = @[];
    NSArray *titleArr = @[];
    NSArray *imgArr = @[];
    NSArray *selectImgArr = @[];
    
    
    for (NSInteger index = 0; index < vcArr.count; index ++) {
        
        Class VcClass = NSClassFromString(vcArr[index]);
        UIViewController *viewController = [[VcClass alloc]init];
        viewController.tabBarItem = [[UITabBarItem alloc] initWithTitle:titleArr[index] image:[[UIImage imageNamed:imgArr[index]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]selectedImage:[[UIImage imageNamed:selectImgArr[index]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        BaseNavigationController *nVc = [[BaseNavigationController alloc] initWithRootViewController:viewController];
        [self addChildViewController:nVc];
        
    }
    
}

/*
  点击事件拦截
 */
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController NS_AVAILABLE_IOS(3_0) {
    
    BaseNavigationController *navCtrl = (BaseNavigationController *)viewController;
    
    UIViewController *rootCtrl = navCtrl.topViewController;
    
//    if(![rootCtrl isKindOfClass:HomeViewController.class]) {
//
//    }
    
    return YES;

}


@end


