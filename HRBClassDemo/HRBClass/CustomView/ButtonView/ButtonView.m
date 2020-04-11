//
//  ButtonView.m
//  JadeShop
//
//  Created by mac on 2019/2/28.
//  Copyright © 2019年 SZJ.test. All rights reserved.
//

#import "ButtonView.h"
#import "Tool.h"
@implementation ButtonView
{
    NSArray <NSString *> *_strArr;
    UIFont *_btnFont;
    UIColor *_btnBackColor;
    UIColor *_btnTitleColor;
    UIColor *_btnBorderColor;
    void(^_callBack)(NSInteger index);
}


+ (instancetype)shareWithData:(NSArray <NSString *> *)data withSet:(void(^)(UIFont **_btnFont,UIColor **_buttonBackColor,UIColor **_buttonTitleColor,UIColor **_buttonBorderColor))set withCallBack:(void(^)(NSInteger index))callBack{
    ButtonView *buttonView = [[ButtonView alloc] init];
    UIFont *btnFont;
    UIColor *btnBackColor;
    UIColor *btnTitleColor;
    UIColor *btnBorderColor;
    set(&btnFont,&btnBackColor,&btnTitleColor,&btnBorderColor);
    if (btnFont != nil) {
        buttonView->_btnFont = btnFont;
    }else{
        buttonView->_btnFont = [UIFont systemFontOfSize:13];
    }
    if (btnBackColor != nil) {
        buttonView->_btnBackColor = btnBackColor;
    }else{
        buttonView->_btnBackColor = [UIColor whiteColor];
    }
    if (btnTitleColor != nil) {
        buttonView->_btnTitleColor = btnTitleColor;
    }else{
        buttonView->_btnTitleColor = [UIColor blackColor];
    }
    if (btnBorderColor != nil) {
        buttonView->_btnBorderColor = btnBorderColor;
    }else{
        buttonView->_btnBorderColor = [UIColor whiteColor];
    }
    buttonView->_callBack = callBack;
    buttonView->_strArr = data;
    return buttonView;
}


-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    if (self.subviews.count == 0) [self creatHotButtons];
}

-(void)creatHotButtons{
    
    float width = 20.f;
    int rows = 0;
    CGFloat top = 0;
    NSInteger index = 0;
    for (NSString *str in _strArr) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:str forState:UIControlStateNormal];
        [button setTitleColor:_btnTitleColor forState:UIControlStateNormal];
        button.backgroundColor = _btnBackColor;
        button.titleLabel.font = _btnFont;
        CGFloat x;
        CGFloat strWidth = [str widthForFont:_btnFont] + 20;
        width += strWidth + 15;
        if (width > self.width - 5) {
            width = strWidth + 15 + 20.f;
            rows++;
            x = 20.f;
        }else{
            x = width - strWidth - 15;
        }

        button.frame = CGRectMake(x, rows * 35 + 10 + top, strWidth, 25);
        button.layer.cornerRadius = 25 / 2;
        button.tag = index + 10010;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
//        button.borderC = _btnBorderColor;
//        button.borderW = 1;
        [self addSubview:button];
        index++;
        
        if (index == _strArr.count) {
            CGRect frame = self.frame;
            frame.size.height = button.bottom + 10;
            self.frame = frame;
        }
    }
}

- (void)buttonAction:(UIButton *)button{
    if (_callBack) {
        _callBack(button.tag - 10010);
    }
}

@end
