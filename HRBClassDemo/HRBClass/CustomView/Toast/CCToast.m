//
//  CCToast.m
//  JadeShop
//
//  Created by mac on 2019/2/28.
//  Copyright © 2019年 SZJ.test. All rights reserved.
//

#import "CCToast.h"


static CCToast *_toast = nil;

@interface CCToast()
@property (nonatomic,strong) UIView * backView;
@property (nonatomic,strong) UILabel * messageLabel;
@property (nonatomic,assign) NSInteger keyboardHeight;
@end


@implementation CCToast


+(instancetype)beginWork{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _toast = [[CCToast alloc] init];
    });
    return _toast;
}

/**
 *  键盘将要显示
 *
 *  @param notification 通知
 */
-(void)keyboardWillShow:(NSNotification *)notification
{
//这样就拿到了键盘的位置大小信息frame，然后根据frame进行高度处理之类的信息
    CGRect frame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    _keyboardHeight = frame.size.height;
}

/**
 *  键盘将要隐藏
 *
 *  @param notification 通知
 */
-(void)keyboardWillHidden:(NSNotification *)notification
{
    _keyboardHeight = 0.f;
}
+ (void)setMessage:(NSString *)message{
    CGSize size = [message sizeForFont:[UIFont systemFontOfSize:12] size:CGSizeMake(YYScreenWidth() - 60, CGFLOAT_MAX) mode:NSLineBreakByWordWrapping];
    CCToast *toast = [CCToast beginWork];
    
    toast.backView.frame = CGRectMake((YYScreenWidth() - size.width) / 2 - 10, X_TABBAR(YYScreenHeight() - size.height - 89 - toast.keyboardHeight), size.width + 20, size.height + 20);
    toast.messageLabel.frame = CGRectMake(10, 10, size.width, size.height);
    toast.messageLabel.text = message;
    
    if (!toast.backView.superview){
        [[UIApplication sharedApplication].keyWindow addSubview:toast.backView];
    }else{
        [NSObject cancelPreviousPerformRequestsWithTarget:toast selector:@selector(removeForSuperView) object:nil];
    }
    
    [toast performSelector:@selector(removeForSuperView) withObject:nil afterDelay:2];
}

+(NSString *)message{
    return @"";
}

-(void)removeForSuperView{
    [UIView animateWithDuration:0.5 animations:^{
        self.backView.alpha = 0;
    } completion:^(BOOL finished) {
        self.backView.alpha = 1;
        [self.backView removeFromSuperview];
    }];
    
}

-(instancetype)init{
    self = [super init];
    if (self) {
        self.backView = [[UIView alloc] init];
        self.backView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        self.backView.layer.cornerRadius = 5;
        self.messageLabel = [[UILabel alloc] init];
        self.messageLabel.textColor = [UIColor whiteColor];
        self.messageLabel.textAlignment = NSTextAlignmentCenter;
        self.messageLabel.font = [UIFont systemFontOfSize:12];
        [self.backView addSubview:self.messageLabel];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}


@end
