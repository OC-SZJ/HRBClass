//
//  BaseTableViewHeaderFooterView.h
//  JadeShop
//
//  Created by SZJ on 2018/10/13.
//  Copyright © 2018年 SZJ.test. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BaseModel.h"
#import "BaseTableVC.h"


@interface BaseTableViewHeaderFooterView : UITableViewHeaderFooterView

@property (nonatomic,assign) NSInteger section;

@property (nonatomic,strong) void(^headerFooterEvent)(id key,id value,int intValue);

@property (nonatomic,strong) __kindof BaseModel * model;

+ (CGFloat)viewHeight:(BaseModel *)model withSection:(NSInteger)section;

@end
