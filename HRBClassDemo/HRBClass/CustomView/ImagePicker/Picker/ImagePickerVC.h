//
//  ImagePickerView.h
//  ocCrazy
//
//  Created by mac on 2018/4/25.
//  Copyright © 2018年 dukai. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LCImageChooseType) {
    LCImageChooseType_Video,
    LCImageChooseType_Image,
    LCImageChooseType_VideoImage,
};



@interface ImagePickerVC : UIViewController

+ (void)shareWithKey:(NSString *)key withImageMax:(NSInteger)imageMax withCallBack:(void(^)(NSArray *data))callBack withType:(LCImageChooseType)type;


@end
