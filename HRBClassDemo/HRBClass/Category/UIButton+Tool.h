//
//  UIButton+Tool.h
//  JadeShop
//
//  Created by mac on 2019/7/5.
//  Copyright © 2019年 SZJ.test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Tool)

@property  NSString * title;
@property  UIColor * titleColor;
- (void)timeAction60WithFinish:(void(^)(void))finish;
- (void)timeAction:(int)time finish:(void(^)(void))finish;
@end
