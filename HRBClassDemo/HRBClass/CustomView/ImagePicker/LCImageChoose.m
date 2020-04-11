//
//  CCImageChoose.m
//  JadeShop
//
//  Created by mac on 2019/3/6.
//  Copyright © 2019年 SZJ.test. All rights reserved.
//

#import "LCImageChoose.h"



static LCImageChoose *_imageChoose = nil;

@implementation LCImageChoose
{
    void(^_callBack)(NSArray *data);
    NSString *_key;
}

+ (instancetype)defaultObject{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _imageChoose = [[LCImageChoose alloc] init];
    });
    return _imageChoose;
}
+ (void)shareImageWithKey:(NSString *)key withImageMax:(NSInteger)imageMax withCallBack:(void(^)(NSArray *data))callBack{
    [self shareWithKey:key withImageMax:imageMax withCallBack:callBack withType:LCImageChooseType_Image];
}
+ (void)shareVideoWithKey:(NSString *)key withImageMax:(NSInteger)imageMax withCallBack:(void(^)(NSArray *data))callBack{
     [self shareWithKey:key withImageMax:imageMax withCallBack:callBack withType:LCImageChooseType_Video];
}
+ (void)shareNormalWithKey:(NSString *)key withImageMax:(NSInteger)imageMax withCallBack:(void(^)(NSArray *data))callBack{
     [self shareWithKey:key withImageMax:imageMax withCallBack:callBack withType:LCImageChooseType_VideoImage];
}

+ (void)shareWithKey:(NSString *)key withImageMax:(NSInteger)imageMax withCallBack:(void(^)(NSArray *data))callBack withType:(LCImageChooseType)type{
    
    LCImageChoose *object = [LCImageChoose defaultObject];
    object->_callBack = callBack;
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *photo = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [ImagePickerVC shareWithKey:key withImageMax:imageMax withCallBack:^(NSArray *data) {
            if (object->_callBack) {
                object->_callBack(data);
            }
        } withType:type];
    }];
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = object; //设置代理
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:imagePickerController animated:YES completion:nil];
    }];
    
    UIAlertAction *canle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
       
    }];
    
    [alertVC addAction:camera];
    [camera setValue:[UIColor colorWithHexString:@"#777777"] forKey:@"titleTextColor"];
    [alertVC addAction:photo];
    [photo setValue:[UIColor colorWithHexString:@"#777777"] forKey:@"titleTextColor"];
    [alertVC addAction:canle];
    [canle setValue:[UIColor colorWithHexString:@"#333333"] forKey:@"titleTextColor"];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^{}];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage]; //通过key值获取到图片
    if (_callBack) {
        _callBack(@[image]);
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}



@end
