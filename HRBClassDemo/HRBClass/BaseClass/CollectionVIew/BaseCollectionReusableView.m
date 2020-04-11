//
//  BaseCollectionReusableView.m
//  ocCrazy
//
//  Created by mac on 2018/7/11.
//  Copyright © 2018年 dukai. All rights reserved.
//

#import "BaseCollectionReusableView.h"

@implementation BaseCollectionReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
  
    [self frameSelf];
    
}

+ (CGSize)viewSize:(BaseModel *)model withSection:(NSInteger)section{return CGSizeZero;}

@end
