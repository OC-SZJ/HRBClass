//
//  BaseCollectionViewCell.m
//  ocCrazy
//
//  Created by mac on 2018/6/27.
//  Copyright © 2018年 dukai. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@implementation BaseCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
   
    [self.contentView frameSelf];
    
    
}

+ (CGSize)cellSize:(BaseModel *)model{return CGSizeZero;}

@end
