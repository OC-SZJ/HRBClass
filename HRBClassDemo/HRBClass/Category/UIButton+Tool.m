//
//  UIButton+Tool.m
//  JadeShop
//
//  Created by mac on 2019/7/5.
//  Copyright © 2019年 SZJ.test. All rights reserved.
//

#import "UIButton+Tool.h"

@implementation UIButton (Tool)
- (void)timeAction60WithFinish:(void(^)(void))finish{
    [self timeAction:61 finish:finish];
}

- (void)timeAction:(int)time finish:(void(^)(void))finish{
    if (time == 0){
        if (finish) {
            finish();
        }
        return;
    }
    if (time == 61) {
        [self changeTime:time];
    }
    __weak typeof(self) _self = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        __strong typeof(_self) self = _self;
        if (!self) return;
        [self timeAction:[self changeTime:time] finish:finish];
    });
}

- (CGFloat)changeTime:(int)time{
    time--;
    [self setTitle:time ? [NSString stringWithFormat:@"%dS",time] : @"发送验证码" forState:UIControlStateNormal];
    [self setUserInteractionEnabled:(time == 0)];
    return time;
}

-(NSString *)title{
    return self.titleLabel.text;
}

-(void)setTitle:(NSString *)title{
    [self setTitle:title forState:UIControlStateNormal];
}

- (void)setTitleColor:(UIColor *)titleColor{
    [self setTitleColor:titleColor forState:UIControlStateNormal];
}
-(UIColor *)titleColor{
    return self.titleLabel.textColor;
}
@end
