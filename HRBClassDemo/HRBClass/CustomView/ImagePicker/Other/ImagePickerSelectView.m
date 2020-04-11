//
//  ImagePickerSelectView.m
//  JadeShop
//
//  Created by mac on 2019/3/4.
//  Copyright © 2019年 SZJ.test. All rights reserved.
//

#import "ImagePickerSelectView.h"

@implementation ImagePickerSelectView
{
    UIImageView *_imageView;
    UILabel *_label;
    
    CALayer * _animalLayer;
    void(^_finish)(void);
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [self creatSubView];
}

-(void)setText:(NSString *)text{
    _label.text = text;
    _label.hidden = text.integerValue == 0;
    
}

-(void)creatSubView{
    
    CGFloat width = self.width;
    
    _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Choose.png"]];
    _imageView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
    _imageView.frame = CGRectMake(0, 0, width, width);
    _imageView.layer.cornerRadius = width / 2;
    [self addSubview:_imageView];
    
    _animalLayer = [CALayer layer];
    _animalLayer.backgroundColor = [UIColor clearColor].CGColor;
    _animalLayer.frame = CGRectMake(-1, -1, width + 2, width + 2);
    _animalLayer.cornerRadius = width / 2 + 1;
    [self.layer addSublayer:_animalLayer];
  
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, width)];
    _label.textColor = [UIColor whiteColor];
    _label.font = [UIFont systemFontOfSize:11];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.layer.cornerRadius = width / 2;
    _label.clipsToBounds = YES;
    _label.backgroundColor = [UIColor colorWithHexString:@"#19AE1A"];
    [self addSubview:_label];
    
   
    
    
}
-(BOOL)isSelect{
   return  _label.text.integerValue != 0;
    
}

- (void)scaleAnimation:(void(^)(void))finish{
    
    _animalLayer.backgroundColor = [UIColor colorWithHexString:@"#19AE1A"].CGColor;
    
    CAKeyframeAnimation *xScaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    xScaleAnimation.values = @[@1,@0.9];
    xScaleAnimation.speed = 2;
    xScaleAnimation.duration = 0.5f;
    xScaleAnimation.delegate = self;
    xScaleAnimation.removedOnCompletion = NO;
    xScaleAnimation.autoreverses = YES;
    xScaleAnimation.fillMode = kCAFillModeForwards;
    xScaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [_animalLayer addAnimation:xScaleAnimation forKey:@"groupAnimation"];
    _finish = finish;
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    _animalLayer.backgroundColor = [UIColor clearColor].CGColor;
    if (_finish) {
        _finish();
    }
    _finish = nil;
}


@end
