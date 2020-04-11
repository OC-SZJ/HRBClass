//
//  BaseTableViewCell.h
//  ocCrazy
//
//  Created by mac on 2018/6/20.
//  Copyright © 2018年 dukai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewCell : UITableViewCell

@property (nonatomic,strong) BaseModel * model;

@property (nonatomic,strong) void(^cellEvent)(id key,id value,int intvalue);

@property (nonatomic,strong) NSIndexPath * indexPath;

+ (CGFloat)cellHeight:(BaseModel *)model;

@end
