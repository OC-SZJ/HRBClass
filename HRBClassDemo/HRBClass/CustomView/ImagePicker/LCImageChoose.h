//
//  CCImageChoose.h
//  JadeShop
//
//  Created by mac on 2019/3/6.
//  Copyright © 2019年 SZJ.test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImagePickerVC.h"


@interface LCImageChoose : NSObject<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
+ (void)shareImageWithKey:(NSString *)key withImageMax:(NSInteger)imageMax withCallBack:(void(^)(NSArray *data))callBack;
+ (void)shareVideoWithKey:(NSString *)key withImageMax:(NSInteger)imageMax withCallBack:(void(^)(NSArray *data))callBack;
+ (void)shareNormalWithKey:(NSString *)key withImageMax:(NSInteger)imageMax withCallBack:(void(^)(NSArray *data))callBack;


@end
