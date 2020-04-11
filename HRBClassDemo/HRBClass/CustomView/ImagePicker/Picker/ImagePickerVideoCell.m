//
//  ImagePickerVideoCell.m
//  JadeShop
//
//  Created by mac on 2019/3/4.
//  Copyright © 2019年 SZJ.test. All rights reserved.
//

#import "ImagePickerVideoCell.h"
#import "ImagePickerSelectView.h"
#import "UIImage+Gradient.h"
@implementation ImagePickerVideoCell
{
    
    __weak IBOutlet ImagePickerSelectView *_selectView;
    
    __weak IBOutlet UIView *_mark;
    
    __weak IBOutlet UILabel *_time_l;
    
    __weak IBOutlet UIImageView *_timeBack_img;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
    _timeBack_img.image =  [[UIImage new] createImageWithSize:CGSizeMake( YYScreenWidth() / 4,23) gradientColors:@[[[UIColor blackColor] colorWithAlphaComponent:0],[[UIColor blackColor] colorWithAlphaComponent:0.5]] percentage:@[@0,@1] gradientType:GradientFromTopToBottom];
    
}

-(void)setModel:(ImageModel *)model{
    _model = model;
    
    _aImage.image = _model.thumImage;

    
    int trueTime = ceilf(_model.time);
    
    int a = trueTime % 60;
    
    _time_l.text = [NSString stringWithFormat:@"%02d:%02d", (int)(trueTime / 60), a];
    
    [_selectView setText:@(model.indexOfSelect).stringValue];
    
}


@end
