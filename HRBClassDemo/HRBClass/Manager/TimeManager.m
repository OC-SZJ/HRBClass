//
//  MMTimeManager.m
//  MarkManager
//
//  Created by mac on 2019/12/25.
//  Copyright © 2019 SZJ. All rights reserved.
//

#import "TimeManager.h"

@interface TimeManager()
@property (nonatomic,strong) NSDateFormatter * dateFormatter;
@property (nonatomic,strong) NSDateFormatter * otherFormatter;
@property (nonatomic,assign) NSTimeInterval beginTime;
@end

@implementation TimeManager
{
    
    NSTimeInterval _beginTime;
    
}
/*
  把时间转换成时分秒
 */
NSString * TimeformatFromSeconds(NSInteger seconds)
{
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    return format_time;
}

/*
  把时间转换成时分秒数组
 */
NSArray <NSString *> * TimeArrformatFromSeconds(NSInteger seconds)
{
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    //format of time
    return @[str_hour,str_minute,str_second];
}
/*
  把时间转换成XX天xx时xx分xx秒
 */
NSString * TimeHZFormatFromSeconds(NSInteger seconds)
{
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",(seconds%86400)/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    //format of day
    NSString *str_day = [NSString stringWithFormat:@"%02ld",seconds/86400];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@天%@时%@分%@秒",str_day,str_hour,str_minute,str_second];
    return format_time;
}
/*
  把时间转换成 数组 (天时分秒)
 */
NSArray <NSString *> * TimeDayFormatFromSeconds(NSInteger seconds)
{
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",(seconds%86400)/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    //format of day
    NSString *str_day = [NSString stringWithFormat:@"%02ld",seconds/86400];
    //format of time
   return @[str_day,str_hour,str_minute,str_second];
}




static TimeManager *_manager = nil;
+(void)beginWork{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = TimeManager.new;
    });
}

+ (NSString *)getCurrentHour{
   NSString *str =  [_manager.otherFormatter stringFromDate:NSDate.date];
    NSString *hour = [str componentsSeparatedByString:@"-"][3];
    return hour;
}

+ (NSString *)getTime:(NSString *)time withFormat:(TimeFormat)format{
    NSDateFormatter *currentDateFormatter = [[NSDateFormatter alloc] init];
       NSString *formatString = @"";
       
       switch (format) {
           case TimeFormat_Y:
               formatString = @"yyyy";
               break;
           case TimeFormat_YM:
               formatString = @"yyyy-MM";
               break;
           case TimeFormat_YMD:
               formatString = @"yyyy-MM-dd";
               break;
           case TimeFormat_YMD_H:
               formatString = @"yyyy-MM-dd HH";
               break;
           case TimeFormat_YMD_HM:
               formatString = @"yyyy-MM-dd HH:mm";
               break;
           case TimeFormat_YMD_HMS:
               formatString = @"yyyy-MM-dd HH:mm:ss";
               break;
           case TimeFormat_CN_Y:
               formatString = @"yyyy年";
               break;
           case TimeFormat_CN_YM:
               formatString = @"yyyy年MM月";
               break;
           case TimeFormat_CN_YMD:
               formatString = @"yyyy年MM月dd日";
               break;
           case TimeFormat_CN_YMD_H:
               formatString = @"yyyy年MM月dd日 HH时";
               break;
           case TimeFormat_CN_YMD_HM:
               formatString = @"yyyy年MM月dd日 HH时mm分";
               break;
           case TimeFormat_CN_YMD_HMS:
               formatString = @"yyyy年MM月dd日 HH时mm分ss秒";
               break;
           default:
               break;
       }
       
       [currentDateFormatter setDateFormat:formatString];
        currentDateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
       
       return  [currentDateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:time.doubleValue]];
}

+ (NSString *)getCurrentTimeWithFormat:(TimeFormat)format{
    return [TimeManager getTime:@(NSDate.date.timeIntervalSince1970).stringValue withFormat:format];
}

+ (NSString *)hoursBetweenFirstTime:(NSString *)firstTime withSecondTime:(NSString *)secondTime{
    NSDateFormatter *currentDateFormatter = [[NSDateFormatter alloc] init];
    NSString *formatString = @"yyyy-MM-dd HH:mm";
    [currentDateFormatter setDateFormat:formatString];
    currentDateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
    NSTimeInterval first = [currentDateFormatter dateFromString:firstTime].timeIntervalSince1970;
    NSTimeInterval second = [currentDateFormatter dateFromString:secondTime].timeIntervalSince1970;
//    NSArray *a =  TimeArrformatFromSeconds(second - first);
    float f = (second - first) / 3600.f;
    return [NSString stringWithFormat:@"%.1f",f];
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        _beginTime = NSDate.date.timeIntervalSince1970;
        [self creatTimer];
    }
    return self;
}

- (void)creatTimer{
    LC_WEAK_SELF
    NSThread *thread = [[NSThread alloc] initWithBlock:^{
        NSRunLoop *runloop =  [NSRunLoop currentRunLoop];
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 block:^(NSTimer * _Nonnull timer) {
            __strong typeof(self)strongSelf = weakSelf;
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *currentTime = [strongSelf.dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:strongSelf.beginTime]];
                strongSelf.beginTime++;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"CurrentTimeNoticationKey" object:currentTime];
            });
        } repeats:YES];
        [runloop addTimer:timer forMode:NSDefaultRunLoopMode];
        [runloop run];
        LC_LOG(@"全局计时器开始运行");
    }];
    [thread start];
}

-(NSDateFormatter *)dateFormatter{
    if (!_dateFormatter) {
           _dateFormatter = [[NSDateFormatter alloc] init];
           [_dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
           _dateFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
       }
    return _dateFormatter;
}

-(NSDateFormatter *)otherFormatter{
    if (!_otherFormatter) {
              _otherFormatter = [[NSDateFormatter alloc] init];
              [_otherFormatter setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
              _otherFormatter.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
          }
       return _otherFormatter;
}

@end
