//
//  UIImageView+Tool.h
//  JadeShop
//
//  Created by mac on 2019/4/4.
//  Copyright © 2019年 SZJ.test. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIImageView (Tool)
UIImage *HRB_IMG(NSString * img);
/*
 本地图片 传名   网络图片传路径 自动识别
 */
-(void)hrb_img:(NSString *)name;
/*
  本地头像 传名   网络图片传路径 自动识别
*/
-(void)hrb_head:(NSString *)name;
@end
