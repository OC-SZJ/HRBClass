//
//  BaseCollectionViewCell.h
//  ocCrazy
//
//  Created by mac on 2018/6/27.
//  Copyright © 2018年 dukai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseModel.h"


@interface BaseCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) NSIndexPath * indexPath;

@property (nonatomic,copy) void(^cellEvent)(id key,id data,int intValue);

@property (nonatomic,strong) BaseModel * model;

+ (CGSize)cellSize:(BaseModel *)model;
@end
