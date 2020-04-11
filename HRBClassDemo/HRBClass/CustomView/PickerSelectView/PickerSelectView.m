//
//  PickerSelectView.m
//  mingjiangkeji
//
//  Created by SZJ on 2020/3/29.
//  Copyright © 2020 SZJ. All rights reserved.
//

#import "PickerSelectView.h"
#import <objc/runtime.h>


@interface PickerSelectView()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (nonatomic,strong) NSArray <NSArray <NSString *>*> * dataSource;
@property (nonatomic,strong) NSArray <NSString *> * sigleDataSource;
@property (nonatomic,strong) NSMutableArray <NSNumber *>* selectArr;
@property (nonatomic,assign) PickerResultComponentsJoined type;
@property (nonatomic,strong) UITextField * textField;
@property (weak, nonatomic) IBOutlet UILabel *title_label;
@end

@implementation PickerSelectView

+ (instancetype)showForData:(NSArray <NSArray <NSString *>*> *)data withType:(PickerResultComponentsJoined)type{
    PickerSelectView *view= LCLoadNib(PickerSelectView.className);
    view.dataSource = data;
    view.type = type;
    [AppDelegate addSubview:view];
    return view;
}
+ (instancetype)showSigleData:(NSArray<NSString *> *)data{
    PickerSelectView *view= LCLoadNib(PickerSelectView.className);
    view.sigleDataSource = data;
    [AppDelegate addSubview:view];
    return view;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if (self.sigleDataSource) {
        return 1;
    }
    return self.dataSource.count;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (self.sigleDataSource) {
        return self.sigleDataSource.count;
    }
    return self.dataSource[component].count;
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
    
    genderLabel.font = TrueFont(16);
    genderLabel.textAlignment = NSTextAlignmentCenter;
    if (_selectArr[component].intValue == row) {
        genderLabel.textColor = LC_COLOR(@"lc_488cfb");
    }else{
        genderLabel.textColor = LC_COLOR(@"lc_333333");
    }
    if (self.sigleDataSource) {
        genderLabel.text = self.sigleDataSource[row];
    }else{
        genderLabel.text = self.dataSource[component][row];
    }
    
    
    return genderLabel;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    [_selectArr replaceObjectAtIndex:component withObject:@(row)];
    [pickerView reloadAllComponents];
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 44;
}
-(void)setDataSource:(NSArray<NSArray<NSString *> *> *)dataSource{
    _dataSource = dataSource;
    _selectArr = @[].mutableCopy;
    for (NSArray *_ in dataSource) {
        [_selectArr addObject:@0];
    }
    [self.pickerView reloadAllComponents];
}
-(void)setSigleDataSource:(NSArray<NSString *> *)sigleDataSource{
    _sigleDataSource = sigleDataSource;
    _selectArr = @[@0].mutableCopy;
    [self.pickerView reloadAllComponents];
}

- (IBAction)remove:(UIButton *)sender {
    [self removeFromSuperview];
}
- (IBAction)sure:(UIButton *)sender {
    if (self.textField) {
        if (self.dataSource) {
            NSMutableArray <NSString *>*a = @[].mutableCopy;
            for (NSArray *arr in _dataSource) {
                NSInteger index = [_dataSource indexOfObject:arr];
                [a addObject:arr[_selectArr[index].intValue]];
            }
            if (self.type == PickerResultComponentsJoined_Null) {
                self.textField.text = [a componentsJoinedByString:@""];
            }
            if (self.type == PickerResultComponentsJoined_DouHao) {
                self.textField.text = [a componentsJoinedByString:@","];
            }
            if (self.type == PickerResultComponentsJoined_DunHao) {
                self.textField.text = [a componentsJoinedByString:@"、"];
            }
            if (self.type == PickerResultComponentsJoined_HengGang) {
                self.textField.text = [a componentsJoinedByString:@"-"];
            }
        }else{
            self.textField.text = self.sigleDataSource[self.selectArr.firstObject.intValue];
        }
        self.textField.selectIndex = self.selectArr;
        if (self.finish) {
            self.finish(self.textField);
        }
        
    }
    [self removeFromSuperview];
}

-(void)setTextField:(UITextField *)textField{
    _textField = textField;
    for (NSNumber *numer in textField.selectIndex) {
        NSInteger index = [textField.selectIndex indexOfObject:numer];
        if (index < self.selectArr.count) {
            [self.selectArr replaceObjectAtIndex:index withObject:numer];
            [self.pickerView selectRow:numer.integerValue inComponent:index animated:NO];
        }
    }
}

@end


@implementation NSArray(picker)

-(PickerSelectView * (^)(UITextField * _Nonnull,NSString * _Nonnull))pickerShow{
    PickerSelectView * (^a)(UITextField * _Nonnull,NSString * _Nonnull) = ^(UITextField *textField,NSString *title){
        PickerSelectView *select = [PickerSelectView showForData:self withType:PickerResultComponentsJoined_DouHao];
        select.textField = textField;
        select.title_label.text = title;
        return select;
    };
    return a;
}
-(PickerSelectView * (^)(UITextField * _Nonnull,NSString * _Nonnull))pickerShow_DunHao{
    PickerSelectView * (^a)(UITextField * _Nonnull,NSString * _Nonnull) = ^(UITextField *textField,NSString *title){
        PickerSelectView *select = [PickerSelectView showForData:self withType:PickerResultComponentsJoined_DunHao];
        select.textField = textField;
        select.title_label.text = title;
        return select;
    };
    return a;
}
-(PickerSelectView * (^)(UITextField * _Nonnull,NSString * _Nonnull))pickerShow_HengGang{
   PickerSelectView * (^a)(UITextField * _Nonnull,NSString * _Nonnull) = ^(UITextField *textField,NSString *title){
        PickerSelectView *select = [PickerSelectView showForData:self withType:PickerResultComponentsJoined_HengGang];
        select.textField = textField;
       select.title_label.text = title;
        return select;
    };
    return a;
}
-(PickerSelectView * (^)(UITextField * _Nonnull,NSString * _Nonnull))pickerShow_Null{
    PickerSelectView * (^a)(UITextField * _Nonnull,NSString * _Nonnull) = ^(UITextField *textField,NSString *title){
        PickerSelectView *select = [PickerSelectView showForData:self withType:PickerResultComponentsJoined_Null];
        select.textField = textField;
        select.title_label.text = title;
        return select;
    };
    return a;
}
-(PickerSelectView * (^)(UITextField * _Nonnull,NSString * _Nonnull))pickerSigleShow{
    PickerSelectView * (^a)(UITextField * _Nonnull,NSString * _Nonnull) = ^(UITextField *textField,NSString *title){
        PickerSelectView *select = [PickerSelectView showSigleData:self];
        select.textField = textField;
        select.title_label.text = title;
        return select;
    };
    return a;
}

@end

@implementation UITextField(picker)

NSString * _selectArr = @"selectArr";
-(void)setSelectIndex:(NSArray<NSNumber *> *)selectIndex{
    objc_setAssociatedObject(self, &_selectArr, selectIndex, OBJC_ASSOCIATION_RETAIN);
}
-(NSArray<NSNumber *> *)selectIndex{
    NSArray *a = objc_getAssociatedObject(self, &_selectArr);
    if (!a) {
        return @[];
    }
    return a;
}

@end
