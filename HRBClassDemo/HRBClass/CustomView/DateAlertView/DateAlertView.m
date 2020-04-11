//
//  DateAlertView.m
//  JadeShop
//
//  Created by mac on 2019/2/18.
//  Copyright © 2019年 SZJ.test. All rights reserved.
//

#import "DateAlertView.h"
#import "Tool.h"


NSString *NumToZn(NSInteger num){
    NSArray *arr = @[@"一",@"二",@"三",@"四",@"五",@"六",@"日"];
    return arr[num - 1];
}


@interface DateAlertView()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic,assign) DateAlertViewType alertType;
@end

@implementation DateAlertView
{
    __weak IBOutlet UIPickerView *_pickerView;
    __weak IBOutlet UIView *_pickerBack_v;
    
    NSDate *_date;
    void(^_callBack)(NSString *date);


    NSMutableArray <NSNumber *> * _selectIndexArr;
}

+ (void)shareWithType:(DateAlertViewType)alertType withCallBack:(void(^)(NSString *date))callBack{
    DateAlertView *view = [[NSBundle mainBundle] loadNibNamed:@"DateAlertView" owner:self options:nil].firstObject;
    view.frame = [UIScreen mainScreen].bounds;
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    view->_callBack = callBack;
    view.alertType = alertType;
}


-(void)awakeFromNib{
    [super awakeFromNib];
    _date = [NSDate date];
    _selectIndexArr = [NSMutableArray arrayWithArray:@[@0,@0,@0,@0,@0]];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    _pickerBack_v.layer.cornerRadius = 10;
}


-(void)setAlertType:(DateAlertViewType)alertType{
    _alertType = alertType;
    [_pickerView reloadAllComponents];
    if (_alertType == DateAlertViewTypeDay) {
        [self cc_selectRow:_date.year - 1 inComponent:0];
        [self cc_selectRow:_date.month - 1 inComponent:1];
        [self cc_selectRow:_date.day - 1 inComponent:2];
    }
    if (_alertType == DateAlertViewTypeHour) {
        [self cc_selectRow:_date.year - 1 inComponent:0];
        [self cc_selectRow:_date.month - 1 inComponent:1];
        [self cc_selectRow:_date.day - 1 inComponent:2];
        [self cc_selectRow:_date.hour inComponent:3];
        [self cc_selectRow:_date.minute inComponent:4];
    }
}

-(void)cc_selectRow:(NSInteger)row inComponent:(NSInteger)component{
     [_pickerView selectRow:row inComponent:component animated:YES];
     [_selectIndexArr replaceObjectAtIndex:component withObject:@(row)];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if (_alertType == DateAlertViewTypeDayTime) {
        return 4;
    }
    if (_alertType == DateAlertViewTypeHour) {
        return 5;
    }
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (_alertType == DateAlertViewTypeDayTime) {
        if (component == 0) return 10000;
        if (component == 1) return 24;
        if (component == 3) return 60;
        return 1;
    }else if (_alertType == DateAlertViewTypeTime){
        if (component == 0) return 24;
        if (component == 2) return 60;
        return 1;
    }else if (_alertType == DateAlertViewTypeHour){
       if (component == 0) return 10000;
        if (component == 1) return 12;
        if (component == 3) return 24;
        if (component == 4) return 60;
        return [self days:_date.year month:_date.month];
    }else{
        if (component == 0) return 10000;
        if (component == 1) return 12;
        return [self days:_date.year month:_date.month];
    }
    

}




- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{

    for(UIView *singleLine in pickerView.subviews)
    {
        if (singleLine.frame.size.height < 1)
        {
            singleLine.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
        }
        
    }
    

    UILabel *genderLabel = [UILabel new];
    
    if (_alertType == DateAlertViewTypeDayTime) {
        genderLabel.textAlignment = 2 - component;
    }else{
        genderLabel.textAlignment = NSTextAlignmentCenter;
    }
    genderLabel.font = [UIFont systemFontOfSize:13];
    genderLabel.textColor = [UIColor colorWithRed:158/255.0 green:158/255.0 blue:158/255.0 alpha:1];
    
    if(_selectIndexArr[component].integerValue == row){
        genderLabel.attributedText
            = [self pickerView:pickerView attributedTitleForRow:row forComponent:component];
    }else{
        genderLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    }
    
    return genderLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    [_selectIndexArr replaceObjectAtIndex:component withObject:@(row)];
    if (_alertType == DateAlertViewTypeDay) {
        [self detailDate:component withNum:row + 1];
    }
    if (_alertType == DateAlertViewTypeHour) {
        if (component == 3 || component == 4) {
           [self detailDate:component withNum:row];
        }else{
           [self detailDate:component withNum:row + 1];
        }
        
    }
    [pickerView reloadAllComponents];
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    float width = [UIScreen mainScreen].bounds.size.width * 0.7 - 10;
    if (_alertType == DateAlertViewTypeDayTime) {

        float widthArr[4] = {width / 2.0,width/6.0,width/12.0,width/6.0};
        return widthArr[component];
    }else if (_alertType == DateAlertViewTypeHour) {

        return width / 4;
    }else {
        return width / 3;
    }

}



- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString *titleString = [self getTitleForRow:row forComponent:component];

    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:titleString];
    [attributedString setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor colorWithRed:33/255.0 green:140/255.0 blue:250/255.0 alpha:1]}];
    return attributedString;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return [self getTitleForRow:row forComponent:component];
}


- (NSString *)getTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *titleString = @"";
    
    if (_alertType == DateAlertViewTypeDayTime) {
        if (component == 0){
            if (row == 0) {
                titleString = @"今天";
            }else{
                NSTimeInterval time = [_date timeIntervalSince1970];
                time += 86400 * row;
                NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:time];
                titleString = [NSString stringWithFormat:@"%ld月%ld日星期%@",newDate.month,newDate.day,NumToZn(newDate.weekday)];
            }
        }
        if (component == 1) titleString = [NSString stringWithFormat:@"%02ld", row];
        if (component == 2) titleString = @":";
        if (component == 3) titleString = [NSString stringWithFormat:@"%02ld", row];
    }else if (_alertType == DateAlertViewTypeTime){
        if (component == 0) titleString = [NSString stringWithFormat:@"%02ld", row];
        if (component == 1) titleString = @":";
        if (component == 2) titleString = [NSString stringWithFormat:@"%02ld", row];
    }else if (_alertType == DateAlertViewTypeHour){
       if (component == 0) titleString = [NSString stringWithFormat:@"%ld年", row + 1];
        if (component == 1) titleString = [NSString stringWithFormat:@"%ld月", row + 1];
        if (component == 2) titleString = [NSString stringWithFormat:@"%ld日", row + 1];
        if (component == 3) titleString = [NSString stringWithFormat:@"%ld时", row];
        if (component == 4) titleString = [NSString stringWithFormat:@"%ld分", row];
    }else{
        if (component == 0) titleString = [NSString stringWithFormat:@"%ld年", row + 1];
        if (component == 1) titleString = [NSString stringWithFormat:@"%ld月", row + 1];
        if (component == 2) titleString = [NSString stringWithFormat:@"%ld日", row + 1];
    }
    
    return titleString;
}



- (NSInteger)days:(NSInteger )year month:(NSInteger )month{
    
    NSInteger day=0;
    switch(month)
    {

        case 4:
        case 6:
        case 9:
        case 11:
            day=30;
            break;
        case 2:
        {
            if(((year % 400 == 0) || ((year % 100 != 0) && (year % 4 == 0))))
            {
                day=29;
                break;
            }
            else
            {
                day=28;
                break;
            }
        }
        default:
            day=31;
            break;
    }
    return day;
}

- (void)detailDate:(NSInteger)type withNum:(NSInteger)num{
    
    NSInteger day = _date.day;
    NSInteger year = _date.year;
    NSInteger month = _date.month;
    NSInteger hour = _date.hour;
    NSInteger min = _date.minute;
    if (type == 0) year = num;
    if (type == 1) month = num;
    if (type == 2) day = num;
    if (type == 3) hour = num;
    if (type == 4) min = num;
    
    NSInteger aDay = [self days:year month:month];
    
    if (_date.day > aDay) {
        day = aDay;
        [_pickerView selectRow:day - 1 inComponent:2 animated:NO];
        
    }
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    
    _date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld %ld:%ld",year,month,day,hour,min]];
    
}


- (IBAction)sure:(id)sender {
    NSString *resulsStr = @"";
//    for (int i = 0; i < 4; i++) {
//       resulsStr = [resulsStr stringByAppendingFormat:@"-%@",[self getTitleForRow:_selectIndexArr[i].integerValue forComponent:i]];
//    }
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    dateFormatter.locale = [NSLocale currentLocale];
    NSString *strDate = [dateFormatter stringFromDate:_date];
    
    NSArray <NSString *>*strArr_time = [strDate componentsSeparatedByString:@" "];
    NSArray <NSString *>*strArr_day = [strArr_time[0] componentsSeparatedByString:@"-"];
    NSArray <NSString *>*strArr_hourMinSec = [strArr_time[1] componentsSeparatedByString:@":"];
    if (_alertType == DateAlertViewTypeDayTime) {
        NSTimeInterval time = [_date timeIntervalSince1970];
        time += 86400 * _selectIndexArr[0].integerValue;
        NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:time];
        resulsStr = [NSString stringWithFormat:@"%ld-%02ld-%02ld %@:%@",newDate.year,newDate.month,newDate.day,[self getTitleForRow:_selectIndexArr[1].integerValue forComponent:1],[self getTitleForRow:_selectIndexArr[3].integerValue forComponent:3]];
        
    }else if (_alertType == DateAlertViewTypeTime){
        NSString *selectStr = [NSString stringWithFormat:@"%@:%@",[self getTitleForRow:_selectIndexArr[0].integerValue forComponent:0],[self getTitleForRow:_selectIndexArr[2].integerValue forComponent:2]];
       resulsStr = [NSString stringWithFormat:@"%@-%@-%@ %@",strArr_day[0],strArr_day[1],strArr_day[2],selectStr];
    }else if (_alertType == DateAlertViewTypeHour){
       resulsStr = [NSString stringWithFormat:@"%@-%@-%@ %@:%@",strArr_day[0],strArr_day[1],strArr_day[2],strArr_hourMinSec[0],strArr_hourMinSec[1]];
    }else{
        resulsStr = [NSString stringWithFormat:@"%@-%@-%@ 00:00",strArr_day[0],strArr_day[1],strArr_day[2]];
    }
    
    
    if (_callBack) {
        _callBack(resulsStr);
    }
    [self removeFromSuperview];
}


- (IBAction)cail:(UIButton *)sender {
    [self removeFromSuperview];
}


- (NSDate *)getNowDateFromatAnDate:(NSDate *)anyDate
{
    //设置源日期时区
    NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];//或GMT
    //设置转换后的目标日期时区
    NSTimeZone* destinationTimeZone = [NSTimeZone localTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:anyDate];
    //目标日期与本地时区的偏移量
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:anyDate];
    //得到时间偏移量的差值
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    //转为现在时间
    NSDate* destinationDateNow = [[NSDate alloc] initWithTimeInterval:interval sinceDate:anyDate];
    
    return destinationDateNow;
}

@end
