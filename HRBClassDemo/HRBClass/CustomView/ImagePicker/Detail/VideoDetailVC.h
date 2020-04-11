//
//  VideoDetailVC.h
//  Test
//
//  Created by mac on 2019/11/22.
//  Copyright © 2019 SZJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface VideoDetailVC : UIViewController

@property (nonatomic,strong) ImageModel * model;

/*
 选中回调
 */
@property (nonatomic,copy) void(^isThis)(void);

@end

NS_ASSUME_NONNULL_END
