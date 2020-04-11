//
//  PickerSelectView.h
//  mingjiangkeji
//
//  Created by SZJ on 2020/3/29.
//  Copyright © 2020 SZJ. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, PickerResultComponentsJoined) {/*
      选中结果 直接拼接
     */
    PickerResultComponentsJoined_Null = -1,
    /*
      选中结果 以 逗号 拼接
     */
    PickerResultComponentsJoined_DouHao = 0,
    /*
     选中结果 以 横线 拼接
    */
    PickerResultComponentsJoined_HengGang = 1,
    /*
        选中结果 以 顿号 拼接
     */
    PickerResultComponentsJoined_DunHao = 2,
};

@interface PickerSelectView : BaseView
/*
  选择完成之后的回调
 */
@property (nonatomic,copy) void(^finish)(UITextField *textField);

/*
  这个类里面的方法不需要直接调用
 */
/*
  多列
 */
+ (instancetype)showForData:(NSArray <NSArray <NSString *>*> *)data withType:(PickerResultComponentsJoined)type;
/*
 单列
 */
+ (instancetype)showSigleData:(NSArray <NSString *>*)data;

@end


@interface NSArray(picker)

/*
  多列展示 选中结果以 , 拼接
 */
-(PickerSelectView * (^)(UITextField * _Nonnull,NSString * _Nonnull))pickerShow;
/*
  多列展示 选中结果以 、 拼接
 */
-(PickerSelectView * (^)(UITextField * _Nonnull,NSString * _Nonnull))pickerShow_DunHao;
/*
  多列展示 选中结果以 - 拼接
 */
-(PickerSelectView * (^)(UITextField * _Nonnull,NSString * _Nonnull))pickerShow_HengGang;
/*
  多列展示 选中结果直接拼接
 */
-(PickerSelectView * (^)(UITextField * _Nonnull,NSString * _Nonnull))pickerShow_Null;
/*
 单列展示
 */
-(PickerSelectView * (^)(UITextField * _Nonnull,NSString * _Nonnull))pickerSigleShow;


@end

@interface UITextField(picker)
/*
 选中结果
 */
@property (nonatomic,strong) NSArray <NSNumber *> * selectIndex;
@end
NS_ASSUME_NONNULL_END
