//
//  MoveLockView.h
//  JadeShop
//
//  Created by mac on 2019/2/21.
//  Copyright © 2019年 SZJ.test. All rights reserved.
//

#import <UIKit/UIKit.h>


//滑动解锁

/*
 
 1   2   3
 
 4   5   6
 
 7   8   9
 
 */


@interface MoveLockView : UIView

+ (instancetype)shareWithCallBack:(void(^)(NSString * resultStr))callBack;

@end
