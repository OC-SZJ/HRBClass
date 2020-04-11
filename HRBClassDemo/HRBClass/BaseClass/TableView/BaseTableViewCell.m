//
//  BaseTableViewCell.m
//  ocCrazy
//
//  Created by mac on 2018/6/20.
//  Copyright © 2018年 dukai. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
  
    [self frameSelf];
    
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


+ (CGFloat)cellHeight:(BaseModel *)model{ return UITableViewAutomaticDimension; }

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
