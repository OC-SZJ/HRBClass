//
//  CCSelectView.m
//  ocCrazy
//
//  Created by mac on 2018/7/4.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "CCSelectView.h"
#import "Tool.h"

static const float WK = 15.f;
static const float lineHeight = 2.f;


@implementation CCSelectView
{
    UIColor *_normalTitleColor;
    UIColor *_selectTitleColor;
    UIFont *_normalTItleFont;
    UIFont *_selectTitleFont;
    BOOL *_canMove;
    UIScrollView *_scrollView;
    NSArray <NSString *>*_titleArr;
    
    UIButton * _lastSelect_btn;
    
    
    UIView *_line_v;
}
+(instancetype)shareForTitles:(NSArray<NSString *>*)titles withFrame:(CGRect)frame withSetBlock:(void(^)(UIColor **titleColor,UIColor **selectColor,UIFont **normalFont,UIFont **selectFont,bool *canMove))setBlock{
    CCSelectView *selectView = [[CCSelectView alloc] init];
    selectView.frame = frame;
   
    UIColor *_normalTitleColor;
    UIColor *_selectTitleColor;
    UIFont *_normalTItleFont;
    UIFont *_selectTitleFont;
    BOOL _canMove;
    if (setBlock) {
        setBlock(&_normalTitleColor,&_selectTitleColor,&_normalTItleFont,&_selectTitleFont,&_canMove);
    }
    if (_normalTitleColor) selectView->_normalTitleColor = _normalTitleColor;
    if (_selectTitleColor) selectView->_selectTitleColor = _selectTitleColor;
    if (_normalTItleFont) selectView->_normalTItleFont = _normalTItleFont;
    if (_selectTitleFont) selectView->_selectTitleFont = _selectTitleFont;
    
    if (titles){
        selectView->_titleArr = titles;
    }
    [selectView begin];
    return selectView;
}

-(void)setTitles:(NSArray<NSString *> *)titles{
    _titleArr = titles;
    [self newBegin];
}

-(void)setIndex:(NSInteger)index{
    UIButton *button = _scrollView ? [_scrollView viewWithTag:1000 + index] : [self viewWithTag:1000 + index];
    [self clip:button];
}

- (void)newBegin{
    [self removeAllSubviews];
    [self begin];
}

- (void)begin{
    if (_canMove) [self creatScrollView];
    if (!_titleArr) return;
    
    CGFloat allWidth = 0.f;
    for (int i = 0 ; i < _titleArr.count; i++) {
        NSString *title = _titleArr[i];
        CGFloat width = _canMove ? self.width / _titleArr.count  : [_titleArr[i] widthForFont:_normalTItleFont];
        UIButton *button = [UIButton buttonWithType:0];
        button.frame = CGRectMake(allWidth + WK, 0, width + WK, self.height - lineHeight);
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:_normalTitleColor forState:UIControlStateNormal];
        button.titleLabel.font = _normalTItleFont;
        button.tag = 1000 + i;
        [button addTarget:self action:@selector(clip:) forControlEvents:UIControlEventTouchUpInside];
        allWidth += (width + 2 * WK);
      
        if (0 == i) {
            [button setTitleColor:_selectTitleColor forState:UIControlStateNormal];
            button.titleLabel.font = _selectTitleFont;
            _lastSelect_btn = button;
            [self creatLineView:width];
        }
        if (_scrollView) {
            [_scrollView addSubview:button];
            [_scrollView addSubview:_line_v];
        }else{
            [self addSubview:button];
            [self addSubview:_line_v];
        }
    }
    if (_scrollView) {
        _scrollView.contentSize = CGSizeMake(allWidth, 0);
    }
}

-(void)clip:(UIButton *)button{
    
    NSInteger tag = button.tag - 1000;
    
    BOOL needReturn = NO;
    if (self.clipCallBack) {
        needReturn = self.clipCallBack(tag);
    }
    if (needReturn) return;
    
    [UIView animateWithDuration:0.5 animations:^{
        [self changeToNormal:_lastSelect_btn];
        [self changeToSelect:button];
        _line_v.centerX = button.centerX;
    } completion:^(BOOL finished) {
        if (finished) {
            if (self.finishCallBack) {
                _lastSelect_btn = button;
                self.finishCallBack(tag, _titleArr[tag]);
            }
            
        }
    }];
    
    if (self.callBack) {
        self.callBack(tag, _titleArr[tag]);
    }
    
}
- (void)creatScrollView{
    if (_scrollView) {
        [_scrollView removeAllSubviews];
        [_scrollView removeFromSuperview];
        _scrollView = nil;
    }
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    [self addSubview:_scrollView];
}

- (void)creatLineView:(CGFloat)width{
    [_line_v removeFromSuperview];
    _line_v = [[UIView alloc] initWithFrame:CGRectMake(WK, self.height - lineHeight, width - 2 * WK, lineHeight)];
}

- (void)changeToSelect:(UIButton *)button{
    [button setTitleColor:_normalTitleColor forState:UIControlStateNormal];
    button.titleLabel.font = _normalTItleFont;
    
}

-(void)changeToNormal:(UIButton *)button{
    [button setTitleColor:_selectTitleColor forState:UIControlStateNormal];
    button.titleLabel.font = _selectTitleFont;
}

@end



