//
//  AdapterForNoAutoLayout.m
//  Test
//
//  Created by mac on 2019/10/25.
//  Copyright © 2019 SZJ. All rights reserved.
//

#import "AdapterForNoAutoLayout.h"
#import <objc/runtime.h>
@implementation AdapterForNoAutoLayout

@end

@implementation UIView(f)

BOOL _alreadyGood;




-(BOOL)alreadyGood{
    return [objc_getAssociatedObject(self, &_alreadyGood) boolValue];
}



-(void)setAlreadyGood:(BOOL)alreadyGood{
    objc_setAssociatedObject(self, &_alreadyGood, @(alreadyGood), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)frameSelf{
    if (self.constraints.count == 0) {
        if (!self.alreadyGood && self.superview) {
            
            self.frame = CGRectMake(W(self.mj_x), W(self.mj_y), W(self.width),self.height == 1 ? 1 : W(self.height));
            self.alreadyGood = YES;
            
        }
        
        for (UIView *subView in self.subviews) {
            if (subView.alreadyGood) continue;
            [subView frameSelf];
        }
    }else
    {
        if (!self.alreadyGood) {
            for (UIView *subView in self.subviews) {
                if (subView.alreadyGood) continue;
                [subView frameSelf];
            }
        }
        self.alreadyGood = YES;
    }
}


@end
