//
//  HRBDateSelectView.h
//  mjkjYG
//
//  Created by SZJ on 2020/4/8.
//  Copyright © 2020 SZJ. All rights reserved.
//

#import <UIKit/UIKit.h>


/*
   格式  yyyy-MM-dd-HH-mm-ss
 */


typedef NS_ENUM(NSInteger, HRBDateSelectType) {
    /*
      选择今日之前的日期   eg: xxxx年 xx月 xx日
     */
    HRBDateSelectTypeEarly = 0
};

typedef NS_ENUM(NSInteger, HRBDateTime) {
    /*
      获取日期的年
     */
    HRBDateTimeYear = 0,
    HRBDateTimeMonth ,
    HRBDateTimeDay ,
    HRBDateTimeHour ,
    HRBDateTimeMin ,
    HRBDateTimeSec
};

NS_ASSUME_NONNULL_BEGIN




@interface HRBDateSelectView : UIView
+ (HRBDateSelectView *(^)(HRBDateSelectType type))showForType;
- (HRBDateSelectView *(^)(NSString * format))formatString;

@property (nonatomic,copy)void(^result)(NSString *time,NSDate *date);
@end

NS_ASSUME_NONNULL_END
