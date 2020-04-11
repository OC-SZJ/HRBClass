//
//  UIDevice+Tool.m
//  AutoCare365
//
//  Created by mac on 2018/9/8.
//  Copyright © 2018年 SZJ. All rights reserved.
//

#import "UIDevice+Tool.h"

@implementation UIDevice (Tool)
+ (void)switchNewOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    
    NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
    
    [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
    
    NSNumber *orientationTarget = [NSNumber numberWithInt:interfaceOrientation];
    
    [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
    
}
@end
