//
//  AppDelegate+Tool.m
//  AutoCare365
//
//  Created by SZJ on 2018/8/26.
//  Copyright © 2018年 SZJ. All rights reserved.
//

#import "AppDelegate+Tool.h"
#import "IQKeyboardManager.h"
#import "SVProgressHUD.h"
#import "CC_BUG.h"
#import "Tool.h"


BaseViewController * _currentVC;

@implementation AppDelegate (Tool)

+(void)load{
    [super load];
    Method method1 = class_getInstanceMethod([self class], @selector(application:didFinishLaunchingWithOptions:));
    Method method2 = class_getInstanceMethod([self class], @selector(_application:didFinishLaunchingWithOptions:));
    
    method_exchangeImplementations(method1, method2);
}

- (BOOL)_application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    
    
    
    self.window = [[UIWindow alloc] initWithFrame:YYScreenBounds()];
    YYScreenWidth();
    YYScreenHeight();
    
    [IQKeyboardManager sharedManager].enable = YES;
    
    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside = YES;
    
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    
    [TimeManager beginWork];
    
    [self setTabbarCon];
    [self setNavCon];
    [self setTableVew];
    
    
    [CC_BUG beginBug:^(NSString *uuid, NSString *dsymUUID, NSString *reason) {
        
        return 1;
    }];
    
    
    
    
#if defined(__IPHONE_13_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0
    if(@available(iOS 13.0,*)){
        self.window.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
    }
#endif
    
    
    
    
    
    [self addNotice];
    
    
    
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    
    
    return [self _application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void)setRootViewController:(__kindof UIViewController *)rootViewController{
    self.window.rootViewController = rootViewController;
    [self.window makeKeyAndVisible];
}

+ (void)setRootViewController:(__kindof UIViewController *)rootViewController{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    delegate.window.rootViewController = rootViewController;
    [delegate.window makeKeyAndVisible];
}


-(void)setTabbarCon{
    //
    [[UITabBarItem appearance] setTitleTextAttributes:  [NSDictionary dictionaryWithObjectsAndKeys:LC_RGB(153, 153, 153),NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:   [NSDictionary dictionaryWithObjectsAndKeys:LC_HEX(@"#4582ff"),NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
//    [UITabBar appearance].tintColor = UIColor.whiteColor;
    [UITabBar appearance].opaque = NO;
    
}

-(void)setNavCon{
    
    //    [[UINavigationBar appearance] setShadowImage:[UIImage new]];
    //    [[UINavigationBar appearance] setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:UIColor.whiteColor,NSFontAttributeName:TrueFont(18)}];
    [[UINavigationBar appearance] setTranslucent:NO];
    [UINavigationBar appearance].backgroundColor = LC_COLOR(@"蓝色");
    [UINavigationBar appearance].barTintColor = LC_COLOR(@"蓝色");
    
}

- (void)setTableVew{
    if (@available(iOS 11.0, *)) {
        [UITableView appearance].estimatedRowHeight = 0;
        [UITableView appearance].estimatedSectionFooterHeight = 0;
        [UITableView appearance].estimatedSectionHeaderHeight = 0;
        [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
}


- (void)addNotice{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(recriveCurrentVC:) name:LC_CURRENTVC object:nil];
}



- (void)recriveCurrentVC:(NSNotification *)notifi{
    UIViewController *vc = notifi.object;
    [self setCurretVC:vc];
}

+(BaseViewController *)getCurrentVC{
    return objc_getAssociatedObject([UIApplication sharedApplication].delegate, @"currentVC");
}

-(void)setCurretVC:(UIViewController *)curretVC{
    objc_setAssociatedObject(self, @"currentVC", curretVC, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)addSubview:(__kindof UIView *)view{
    if (CGPointEqualToPoint(view.frame.origin, CGPointZero)) {
        view.frame = YYScreenBounds();
    }
    [[UIApplication sharedApplication].keyWindow addSubview:view];
}



+ (void)presentVC:(UIViewController *)vc{
    [[UIApplication sharedApplication].keyWindow.rootViewController p:vc];
}

@end
