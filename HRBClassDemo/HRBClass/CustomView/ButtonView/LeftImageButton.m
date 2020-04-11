//
//  LeftImageButton.m
//  mingjiangkeji
//
//  Created by SZJ on 2020/3/29.
//  Copyright © 2020 SZJ. All rights reserved.
//

#import "LeftImageButton.h"

@implementation LeftImageButton


-(void)layoutSubviews
{
    [super layoutSubviews];
    CGRect titleF = self.titleLabel.frame;
    CGRect imageF = self.imageView.frame;
    titleF.origin.x = 0;
    self.titleLabel.frame = titleF;
    imageF.origin.x = CGRectGetMaxX(titleF);
    self.imageView.frame = imageF;

}
@end
