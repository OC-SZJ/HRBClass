//
//  DateAlertView.h
//  JadeShop
//
//  Created by mac on 2019/2/18.
//  Copyright © 2019年 SZJ.test. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef NS_ENUM(NSInteger, DateAlertViewType) {
    DateAlertViewTypeDayTime = 0, // 时间+日期  eg// xx月xx日星期x xx:xx
    DateAlertViewTypeTime, //时间 eg// xx:xx
    DateAlertViewTypeDay, //日期 eg// xxxx年xx月xx日
    DateAlertViewTypeHour
};

@interface DateAlertView : UIView

+ (void)shareWithType:(DateAlertViewType)alertType withCallBack:(void(^)(NSString *date))callBack;


@end
