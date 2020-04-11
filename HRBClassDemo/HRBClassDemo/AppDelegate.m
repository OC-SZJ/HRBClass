//
//  AppDelegate.m
//  HRBClassDemo
//
//  Created by SZJ on 2020/4/6.
//  Copyright © 2020 SZJ. All rights reserved.
//

#import "AppDelegate.h"
#import "TestViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    TestViewController *vc = TestViewController.new;
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
    return YES;
}


@end
