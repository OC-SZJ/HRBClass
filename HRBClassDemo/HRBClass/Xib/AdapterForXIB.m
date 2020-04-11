//
//  AdapterForXIB.m
//  CustomProject
//
//  Created by mac on 2017/11/29.
//  Copyright © 2017年 SZJ. All rights reserved.
//

#import "AdapterForXIB.h"
#import <objc/runtime.h>

IB_DESIGNABLE


static int _textMax = 0;

static int _leftWidth = 0;



float TrueFontFloat(float font){
    float trueFont = font;
    if (YYScreenWidth() == 320) {
        trueFont = font - 1;
    }
    if (YYScreenWidth() == 414) {
        trueFont = font + 1;
    }
    return trueFont;
}

UIFont * TrueFont(float font){
    return [UIFont systemFontOfSize:TrueFontFloat(font)];
}

@implementation AdapterForXIB

+ (BOOL)CC_isX
{
    
    BOOL isPhoneX = NO;
    if (@available(iOS 11.0, *)) {
        isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;
    }
    return isPhoneX;
}

+ (CGFloat)cc_FrameForX:(CGFloat)f{

    if ([AdapterForXIB CC_isX]) {

        return f + 34;
    }
    return f;
}
+ (CGFloat)cc_FrameForNavX:(CGFloat)f{
    

    if ([AdapterForXIB CC_isX]) {
        return f + 24;
    }
    return f;
    
}

@end

@implementation UILabel (highlight)
+ (void)load{
    [super load];
    Method method1 = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method method2 = class_getInstanceMethod([self class], @selector(adapterInitWithCoder:));
    
    method_exchangeImplementations(method1, method2);
    
    Method method3 = class_getInstanceMethod([self class], @selector(adapterSetText:));
    Method method4 = class_getInstanceMethod([self class], @selector(setText:));
    
    method_exchangeImplementations(method3, method4);
}

- (instancetype)adapterInitWithCoder:(NSCoder *)aDecoder{
    [self adapterInitWithCoder:aDecoder];
    if (self) {
        UIFont *font = self.font;

        if ([font.fontName isEqualToString:@".SFUIText"]) {
            self.font = TrueFont(font.pointSize);
        }else
        if ([font.fontName isEqualToString:@".SFUIText-Italic"] || [font.fontName isEqualToString:@".SFUIDisplay-Italic"]) {
            self.font = [UIFont italicSystemFontOfSize:TrueFontFloat(font.pointSize)];
        }else
        if ([font.fontName isEqualToString:@".SFUIText-Bold"] || [font.fontName isEqualToString:@".SFUIDisplay-Bold"] || [font.fontName isEqualToString:@".SFUI-Bold"]) {
            self.font = [UIFont boldSystemFontOfSize:TrueFontFloat(font.pointSize)];
        }else
        if ([font.fontName isEqualToString:@"FZXS12--GB1-0"]) {
            self.font = [UIFont fontWithName:@"FZXS12--GB1-0" size:TrueFontFloat(font.pointSize)];
        }else{
            if ([self.text isEqualToString:@"0"]) {
                NSLog(@"----%@",font.fontName);
            }
            self.font = TrueFont(font.pointSize);
        }
    }
    return self;
}




-(void)adapterSetText:(NSString *)text{
    if (text == nil ||
        text == NULL) {
        text = @"";
    }
    [self adapterSetText:text];
}

-(int)leftWidth{
    return [objc_getAssociatedObject(self, &_leftWidth) intValue];
}

-(void)setLeftWidth:(int)leftWidth{
    objc_setAssociatedObject(self, &_leftWidth, [NSNumber numberWithInt:leftWidth], OBJC_ASSOCIATION_RETAIN);
}


-(void)setInternationStr:(NSString *)internationStr{
    self.text = NSLocalizedString(internationStr,nil);
}

-(NSString *)internationStr{
    return self.text;
}


@end

@implementation UIButton (titleSize)
+ (void)load{
    [super load];
    Method method1 = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method method2 = class_getInstanceMethod([self class], @selector(adapterInitWithCoder:));
    
    method_exchangeImplementations(method1, method2);
}

- (instancetype)adapterInitWithCoder:(NSCoder *)aDecoder{
    [self adapterInitWithCoder:aDecoder];
    if (self) {
        UIFont *font = self.titleLabel.font;

        if ([font.fontName isEqualToString:@".SFUIText"]) {
            self.titleLabel.font = TrueFont(font.pointSize);
        }else
        if ([font.fontName isEqualToString:@".SFUIText-Italic"] || [font.fontName isEqualToString:@".SFUIDisplay-Italic"]) {
            self.titleLabel.font = [UIFont italicSystemFontOfSize:TrueFontFloat(font.pointSize)];
        }else
        if ([font.fontName isEqualToString:@".SFUIText-Bold"] || [font.fontName isEqualToString:@".SFUIDisplay-Bold"] || [font.fontName isEqualToString:@".SFUI-Bold"]) {
            self.titleLabel.font = [UIFont boldSystemFontOfSize:TrueFontFloat(font.pointSize)];
        }else
        if ([font.fontName isEqualToString:@"FZXS12--GB1-0"]) {
            self.titleLabel.font = [UIFont fontWithName:@"FZXS12--GB1-0" size:TrueFontFloat(font.pointSize)];
        }else{
           
            self.titleLabel.font = TrueFont(font.pointSize);
        }
    }
    return self;
}



@end

@implementation UIView (IB)


-(void)setCornerRadiusNum:(CGFloat)cornerRadiusNum{
    if (cornerRadiusNum) {
        self.layer.cornerRadius = cornerRadiusNum;
    }
}
-(void)setBorderW:(CGFloat)borderW{
    if (borderW) {
        self.layer.borderWidth = borderW;
    }
}
-(void)setBorderC:(UIColor *)borderC{
    if (borderC) {
        self.layer.borderColor = borderC.CGColor;
    }
}

-(void)setSetShawdow:(BOOL)setShawdow{
    if (setShawdow) {
        self.layer.shadowColor = [UIColor blackColor].CGColor;
 
        self.layer.shadowOpacity = 0.2f;

        self.layer.shadowRadius = 3.0f;
   
        self.layer.shadowOffset = CGSizeMake(0,1);
    }
}



-(CGFloat)cornerRadiusNum{
    return self.layer.cornerRadius;
}
-(CGFloat)borderW{
    return self.layer.borderWidth;
}
-(UIColor *)borderC{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

-(BOOL)setShawdow{
    return NO;
}

-(CGFloat)bottomForWindow{
    CGRect frame = [self convertRect:self.frame toView:nil];
    return frame.size.height + frame.origin.y;
}

@end



@implementation UITextField (titleSize)


- (instancetype)adapterInitWithCoder:(NSCoder *)aDecoder{
    [self adapterInitWithCoder:aDecoder];
    if (self) {
        self.font = TrueFont(self.font.pointSize);
    }
    return self;
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

-(void)setTextMax:(NSInteger)textMax{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:nil];
    objc_setAssociatedObject(self, &_textMax, [NSNumber numberWithInteger:textMax], OBJC_ASSOCIATION_RETAIN);
}

-(NSInteger)textMax{
    
    return ((NSNumber *)objc_getAssociatedObject(self, &_textMax)).integerValue;
}



+ (void)load {
    [super load];
    
    Method method1 = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method method2 = class_getInstanceMethod([self class], @selector(adapterInitWithCoder:));
    
    method_exchangeImplementations(method1, method2);
    
}

-(void)textChange{
    NSInteger kMaxLength = [self textMax];
    if (!kMaxLength) return;
    NSString *toBeString = self.text;
    //    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage]; // 键盘输入模式 ios7弃用
    NSString *lang  = [[UIApplication sharedApplication] textInputMode].primaryLanguage;
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [self markedTextRange];
        //获取高亮部分
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > kMaxLength) {
                self.text = [toBeString substringToIndex:kMaxLength];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length > kMaxLength) {
            self.text = [toBeString substringToIndex:kMaxLength];
        }
    }
}

- (void)setPlaceHolderColor:(UIColor *)color{
    [self setValue:color forKeyPath:@"_placeholderLabel.textColor"];
}

@end

@implementation UITextView (titleSize)

+ (void)load{
    [super load];
    Method method1 = class_getInstanceMethod([self class], @selector(initWithCoder:));
    Method method2 = class_getInstanceMethod([self class], @selector(adapterInitWithCoder:));
    
    method_exchangeImplementations(method1, method2);
}

- (instancetype)adapterInitWithCoder:(NSCoder *)aDecoder{
    [self adapterInitWithCoder:aDecoder];
    if (self) {
        self.font = TrueFont(self.font.pointSize);
    }
    return self;
}
@end



@implementation UINib (custom)

+ (UINib *)nibStr:(Class)aclass{
    UINib *nib = [UINib nibWithNibName:NSStringFromClass(aclass) bundle:nil];
    return nib;
}

@end

