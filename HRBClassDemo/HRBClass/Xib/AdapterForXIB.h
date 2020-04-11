//
//  AdapterForXIB.h
//  CustomProject
//
//  Created by mac on 2017/11/29.
//  Copyright © 2017年 SZJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>




//XIB  适配文件 (以 375 667 为标准)

@interface AdapterForXIB : NSObject
+ (BOOL)CC_isX;
+ (CGFloat)cc_FrameForX:(CGFloat)f;
+ (CGFloat)cc_FrameForNavX:(CGFloat)f;
@end

UIFont * TrueFont(float font);
float TrueFontFloat(float font);



@interface UILabel (highlight)
@property (nonatomic,assign) IBInspectable int leftWidth;
@property (nonatomic,strong) IBInspectable NSString * internationStr;
@end



@interface UIButton (titleSize)
@end




@interface UIView (IB)
@property (nonatomic,assign) IBInspectable CGFloat cornerRadiusNum;
@property (nonatomic,strong) IBInspectable UIColor * borderC;
@property (nonatomic,assign) IBInspectable CGFloat borderW;
@property (nonatomic,assign) IBInspectable BOOL setShawdow;
@property (nonatomic,assign,readonly) CGFloat bottomForWindow;
@end


@interface UITextField (titleSize)
@property (nonatomic,assign) IBInspectable NSInteger textMax;
- (void)setPlaceHolderColor:(UIColor *)color;
@end




@interface UITextView (titleSize)
@end



@interface UINib (custom)
+ (UINib *)nibStr:(Class)aclass;
@end




