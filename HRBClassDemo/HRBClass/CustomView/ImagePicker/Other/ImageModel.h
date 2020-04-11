//
//  ImageModel.h
//  JadeShop
//
//  Created by mac on 2019/3/4.
//  Copyright © 2019年 SZJ.test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
#import <pthread.h>
@interface ImageModel : NSObject


@property (nonatomic,assign) float time;

@property (nonatomic,strong) UIImage * thumImage;

@property (nonatomic,strong) NSString * videoUrl;

@property (nonatomic,assign) BOOL  isVideo;

@property (nonatomic,assign) NSInteger indexOfSelect;

@property (nonatomic,strong) UIImage * normalImage;

@property (nonatomic,strong) PHAsset * asset;



@end
