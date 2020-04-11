//
//  MMTimeManager.h
//  MarkManager
//
//  Created by mac on 2019/12/25.
//  Copyright © 2019 SZJ. All rights reserved.
//

#import <Foundation/Foundation.h>


#define GetCurrentTimeNotication [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getCurrentTimeNotication:) name:@"CurrentTimeNoticationKey" object:nil];

typedef NS_ENUM(NSInteger, TimeFormat) {
   
    /// xxxx
    TimeFormat_Y,
    /// xxxx-xx
    TimeFormat_YM,
    ///  xxxx-xx-xx
    TimeFormat_YMD,
     /// xxxx-xx-xx xx
    TimeFormat_YMD_H,
    ///xxxx-xx-xx xx:xx
    TimeFormat_YMD_HM,
    ///xxxx-xx-xx xx:xx:xx
    TimeFormat_YMD_HMS,
    ///xxxx年
    TimeFormat_CN_Y,
    ///xxxx年xx月
    TimeFormat_CN_YM,
    ///xxxx年xx月xx日
    TimeFormat_CN_YMD,
    ///xxxx年xx月xx日 xx时
    TimeFormat_CN_YMD_H,
    ///xxxx年xx月xx日 xx时xx分
    TimeFormat_CN_YMD_HM,
    ///xxxx年xx月xx日 xx时xx分xx秒
    TimeFormat_CN_YMD_HMS,
};

NS_ASSUME_NONNULL_BEGIN



@interface TimeManager : NSObject
/*
  获取当前 是几点
 
 */
+ (NSString *)getCurrentHour;

+(void)beginWork;

NSString * TimeformatFromSeconds(NSInteger seconds);
NSArray <NSString *> * TimeArrformatFromSeconds(NSInteger seconds);
NSString * TimeHZFormatFromSeconds(NSInteger seconds);
NSArray <NSString *> * TimeDayFormatFromSeconds(NSInteger seconds);
+ (NSString *)getTime:(NSString *)time withFormat:(TimeFormat)format;
+ (NSString *)getCurrentTimeWithFormat:(TimeFormat)format;
+ (NSString *)hoursBetweenFirstTime:(NSString *)firstTime withSecondTime:(NSString *)secondTime;
@end

NS_ASSUME_NONNULL_END
