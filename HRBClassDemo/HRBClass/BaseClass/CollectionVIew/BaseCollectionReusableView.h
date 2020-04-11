//
//  BaseCollectionReusableView.h
//  ocCrazy
//
//  Created by mac on 2018/7/11.
//  Copyright © 2018年 dukai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseModel.h"

@interface BaseCollectionReusableView : UICollectionReusableView

@property (nonatomic,assign) NSInteger section;
@property (nonatomic,copy) void(^hfEvent)(id key, id value, int intValue);
@property (nonatomic,strong) __kindof BaseModel * model;

+ (CGSize)viewSize:(BaseModel *)model withSection:(NSInteger)section;

@end
