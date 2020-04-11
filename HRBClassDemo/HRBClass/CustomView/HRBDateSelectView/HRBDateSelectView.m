//
//  HRBDateSelectView.m
//  mjkjYG
//
//  Created by SZJ on 2020/4/8.
//  Copyright © 2020 SZJ. All rights reserved.
//

#import "HRBDateSelectView.h"

@interface HRBDateSelectView()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,strong) NSDateFormatter * dateFormatter;

@property (weak, nonatomic) IBOutlet UIPickerView *pickeView;

@property (nonatomic,assign) HRBDateSelectType type;

@property (nonatomic,strong) NSDate * normalDate;

@property (nonatomic,strong) NSDate * currentDate;

@property (nonatomic,strong) NSMutableArray <NSNumber *> * selectArr;

@property (nonatomic,copy) NSString * dateFormatString;
@end

@implementation HRBDateSelectView

/*
 时间这块  获取当前时间的时候 就 转成正常时间了
 */
NSDate *HRBTrueDate(NSDate *date){
    // 获得系统时区
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    //得到源日期与世界标准时间的偏移量
    NSInteger interval = [zone secondsFromGMTForDate: date];
    //返回以当前NSDate对象为基准，偏移多少秒后得到的新NSDate对象
    NSDate *localeDate = [date dateByAddingTimeInterval: interval];
    return localeDate;
}

+ (HRBDateSelectView *(^)(HRBDateSelectType type))showForType{
    HRBDateSelectView *(^r)(HRBDateSelectType type) = ^(HRBDateSelectType type){
        HRBDateSelectView *selectView = [NSBundle.mainBundle loadNibNamed:HRBDateSelectView.className owner:nil options:nil].firstObject;
        selectView.type = type;
        [AppDelegate addSubview:selectView];
        return selectView;
    };
    return r;
}

-(HRBDateSelectView * _Nonnull (^)(NSString * _Nonnull))formatString{
    HRBDateSelectView * _Nonnull (^r)(NSString * _Nonnull) = ^(NSString *formatString){
        self.dateFormatString = formatString;
        return self;
    };
    return r;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.pickeView.delegate = self;
    self.pickeView.dataSource = self;
    self.normalDate = HRBTrueDate(NSDate.date);
    self.currentDate = HRBTrueDate(NSDate.date);
    self.selectArr = @[@0,@0,@0,@0,@0,@0].mutableCopy;
    [self begin];
}

- (void)begin{
    if (self.type == HRBDateSelectTypeEarly) {
        NSInteger month = [self getTimeDataForIndex:1] - 1;
        [self.pickeView selectRow:month inComponent:1 animated:YES];
        [self.selectArr replaceObjectAtIndex:1 withObject:@(month)];
        NSInteger day = [self getTimeDataForIndex:2] - 1;
        [self.pickeView selectRow:day inComponent:2 animated:YES];
        [self.selectArr replaceObjectAtIndex:2 withObject:@(day)];
    }
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if (self.type == HRBDateSelectTypeEarly) {
        return 3;
    }
    return 0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (self.type == HRBDateSelectTypeEarly) {
        if (component == 0) return self.normalDate.year;
        if (component == 1) return 12;
        if (component == 2) return [self days:self.currentDate.year month:self.currentDate.month];
    }
    return 0;
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
    genderLabel.font = [UIFont systemFontOfSize:13];
    genderLabel.textColor = [UIColor colorWithRed:158/255.0 green:158/255.0 blue:158/255.0 alpha:1];
    genderLabel.textAlignment = NSTextAlignmentCenter;
    if(self.selectArr[component].integerValue == row){
        genderLabel.attributedText
        = [self pickerView:pickerView attributedTitleForRow:row forComponent:component];
    }else{
        genderLabel.text = [self getTitleForRow:row forComponent:component];
    }
    
    return genderLabel;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    [self.selectArr replaceObjectAtIndex:component withObject:@(row)];
    [self detailDate:component withNum:row];
    [pickerView reloadAllComponents];
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    if (self.type == HRBDateSelectTypeEarly) {
        return YYScreenWidth() / 3;
    }
    return 0.f;
}



- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString *titleString = [self getTitleForRow:row forComponent:component];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:titleString];
    [attributedString setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor colorWithRed:33/255.0 green:140/255.0 blue:250/255.0 alpha:1]}];
    return attributedString;
}

- (NSString *)getTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *titleString = @"";
    if (self.type == HRBDateSelectTypeEarly){
        if (component == 0) titleString = [NSString stringWithFormat:@"%ld年", self.normalDate.year - row];
        if (component == 1) titleString = [NSString stringWithFormat:@"%ld月", row + 1];
        if (component == 2) titleString = [NSString stringWithFormat:@"%ld日", row + 1];
    }
    
    return titleString;
}

- (NSInteger)days:(NSInteger )year month:(NSInteger )month{
    NSArray <NSNumber *> *days = @[@0,@31,@28,@31,@30,@31,@30,@31,@31,@30,@31,@30,@31];
    if (month == 2) {
        if(((year % 400 == 0) || ((year % 100 != 0) && (year % 4 == 0))))
        {
            return 29;
        }
    }
    return days[month].integerValue;
}

- (void)detailDate:(NSInteger)type withNum:(NSInteger)num{
    NSArray <NSString *>*arr = [self getTimeDataArr];
    
    NSInteger year = arr[0].intValue;
    NSInteger month = arr[1].intValue;
    NSInteger day = arr[2].intValue;
    NSInteger hour = arr[3].intValue;
    NSInteger min = arr[4].intValue;
    NSInteger sec = arr[5].intValue;
    
    if (type == 0){
        if (self.type == HRBDateSelectTypeEarly) {
            NSInteger beginYear = self.normalDate.year;
            year = beginYear - num;
        }else{
            year = num;
        }
    }
    if (type == 1) month = num + 1;
    if (type == 2) day = num + 1;
    if (type == 3) hour = num;
    if (type == 4) min = num;
    if (type == 5) sec = num;
    
    NSInteger aDay = [self days:year month:month];
    
    if (self.currentDate.day > aDay) {
        day = aDay;
        [self.pickeView selectRow:day - 1 inComponent:2 animated:NO];
        
    }
    
    self.currentDate = [self.dateFormatter dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld- %ld-%ld-%ld",year,month,day,hour,min,sec]];
    
}
/*
  获取当前时间的第几个数据
 */
- (NSInteger)getTimeDataForIndex:(NSInteger)index{
    NSString *str = [self.dateFormatter stringFromDate:self.currentDate];
    NSArray <NSString *> *arr = [str componentsSeparatedByString:@"-"];
    return arr[index].integerValue;
}

/*
  获取当前选中时间字符串的数组
 */
- (NSArray *)getTimeDataArr{
    NSString *str = [self.dateFormatter stringFromDate:self.currentDate];
    NSArray <NSString *> *arr = [str componentsSeparatedByString:@"-"];
    return arr;
}




- (IBAction)cale:(UIButton *)sender {
    [self removeFromSuperview];
}

- (IBAction)sure:(UIButton *)sender {

    if (self.result) {
        NSDateFormatter *f = [[NSDateFormatter alloc] init];
        NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
        [f setTimeZone:timeZone];
        [f setDateFormat:self.dateFormatString];
        self.result([f stringFromDate:self.currentDate],self.currentDate);
    }
    
    [self removeFromSuperview];
}

-(NSDateFormatter *)dateFormatter{
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
        [_dateFormatter setTimeZone:timeZone];
        [_dateFormatter setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
    }
    return _dateFormatter;
}

@end
