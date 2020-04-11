//
//  LoginManager.m
//  mingjiangkeji
//
//  Created by SZJ on 2020/3/23.
//  Copyright © 2020 SZJ. All rights reserved.
//

#import "LoginManager.h"
#import "CCTabbarVC.h"
#import "AppDelegate+Tool.h"
#import "BaseNavigationController.h"

@implementation LoginModel

+(NSDictionary *)cc_customProPerty{
    return @{@"uid":@"id"};
}

@end


@implementation LoginManager

NSString * UID(){
    NSData *data = [NSUserDefaults.standardUserDefaults objectForKey:@"user_model"];
    LoginModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    if (!model.uid)return @"";
    printf("\n\n🇨🇳🇨🇳🇨🇳🇨🇳🇨🇳🇨🇳  当前登录的id < %s > 🇨🇳🇨🇳🇨🇳🇨🇳🇨🇳🇨🇳\n\n",model.uid.UTF8String);
    return model.uid;
}

void SaveAndLogIn(LoginModel *model){
   NSData *d = [NSKeyedArchiver archivedDataWithRootObject:model];
   [NSUserDefaults.standardUserDefaults setObject:d forKey:@"user_model"];
   BOOL success = NSUserDefaults.standardUserDefaults.synchronize;
    if (success) {
        [AppDelegate setRootViewController:CCTabbarVC.new];
    }
}

void RemoveAndLogOut(){
    NSData *d = NSData.data;
    [NSUserDefaults.standardUserDefaults setObject:d forKey:@"user_model"];
    BOOL success = NSUserDefaults.standardUserDefaults.synchronize;
     if (success) {
         [BaseNavigationController shareWithRootVC:UIViewController.new];
     }
}

UIViewController *MainViewController(){
    if (UID().length > 0) {
        return CCTabbarVC.new;
    }
    return [BaseNavigationController shareWithRootVC:UIViewController.new];
}
@end
