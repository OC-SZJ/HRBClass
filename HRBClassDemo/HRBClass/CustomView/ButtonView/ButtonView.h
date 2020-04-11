//
//  ButtonView.h
//  JadeShop
//
//  Created by mac on 2019/2/28.
//  Copyright © 2019年 SZJ.test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ButtonView : UIView

// 用啥传啥
// 必须设置frame

/*
 eg:
 
 
 ButtonView *buttonView = [ButtonView shareWithData:@[@"1",@"12",@"123",@"1235",@"12346",@"1231254676"] withSet:^(UIFont *__autoreleasing *_btnFont, UIColor *__autoreleasing *_buttonBackColor, UIColor *__autoreleasing *_buttonTitleColor, UIColor *__autoreleasing *_buttonBorderColor) {
     *_btnFont = [UIFont systemFontOfSize:15];
     *_buttonBackColor = [UIColor whiteColor];
     *_buttonTitleColor = [UIColor redColor];
     *_buttonBorderColor = [UIColor greenColor];
 } withCallBack:^(NSInteger index) {
 
 }];
 buttonView.frame = CGRectMake(0, 0, YYScreenWidth(), X);
 
 [self.view addSubview:buttonView];
 
 */

+ (instancetype)shareWithData:(NSArray <NSString *> *)data withSet:(void(^)(UIFont **_btnFont,UIColor **_buttonBackColor,UIColor **_buttonTitleColor,UIColor **_buttonBorderColor))set withCallBack:(void(^)(NSInteger index))callBack;

@end
