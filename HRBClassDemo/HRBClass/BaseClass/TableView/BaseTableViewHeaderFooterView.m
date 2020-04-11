//
//  BaseTableViewHeaderFooterView.m
//  JadeShop
//
//  Created by SZJ on 2018/10/13.
//  Copyright © 2018年 SZJ.test. All rights reserved.
//

#import "BaseTableViewHeaderFooterView.h"

@implementation BaseTableViewHeaderFooterView
-(void)awakeFromNib{
    [super awakeFromNib];
    [self frameSelf];
    
}
+ (CGFloat)viewHeight:(BaseModel *)model withSection:(NSInteger)section{return CGFLOAT_MIN;}

@end
