//
//  UIImage+UpLoad.h
//  mingjiangkeji
//
//  Created by SZJ on 2020/4/3.
//  Copyright © 2020 SZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (UpLoad)
/*
  上传图片
  重点: block(xx,xx,xx)
 */
@property (nonatomic,copy) void(^upload)(void(^result)(NSString * url));
@end

NS_ASSUME_NONNULL_END
