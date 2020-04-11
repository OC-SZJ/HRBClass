//
//  BaseTableViewUI.m
//  FrameWork
//
//  Created by SZJ on 2020/3/15.
//  Copyright © 2020 SZJ. All rights reserved.
//

#import "BaseTableViewUI.h"

@implementation BaseTableViewUI

{
    NSMutableArray <TableViewLeftSlideAction *> * _leftSlideActions;
}

-(NSMutableArray<TableViewLeftSlideAction *> *)getActions{
    return _leftSlideActions;
}


-(void)makeLeftSlideActions:(void (^)(NSMutableArray<TableViewLeftSlideAction *> * _Nonnull))actions
{
    NSMutableArray *a = @[].mutableCopy;
    actions(a);
    _leftSlideActions = a;
}

@end

@implementation TableViewLeftSlideAction
{
    NSString *_title;
    UIColor *_color;
    UIImage *_image;
    void(^_result)(NSIndexPath *indexPath);
}
/*
 初始化
 */
+ (instancetype)action{
    return TableViewLeftSlideAction.new;
}

-(NSString *)t_title{
    return _title;
}
-(UIColor *)t_backColor{
    return _color;
}
-(void (^)(NSIndexPath *indexPath))t_result{
    return _result;
}
-(UIImage *)t_backImage{
    return _image;
}


/*
 设置标题
 */
- (TableViewLeftSlideAction *(^)(NSString *title))title{
    TableViewLeftSlideAction *(^a)(NSString *title) = ^(NSString *title){
        self->_title = title;
        return self;
    };
    return a;
}
/*
 设置背景颜色
 */
- (TableViewLeftSlideAction *(^)(UIColor *backColor))backColor{
    TableViewLeftSlideAction *(^a)(UIColor *backColor) = ^(UIColor *backColor){
        self->_color = backColor;
        return self;
    };
    return a;
}
/*
 设置背景图片
 */
- (TableViewLeftSlideAction *(^)(UIImage *backImage))backImage{
    TableViewLeftSlideAction *(^a)(UIImage *backImage) = ^(UIImage *backImage){
        self->_image = backImage;
        return self;
    };
    return a;
}
/*
 回调
 */
- (TableViewLeftSlideAction *(^)(void(^result)(NSIndexPath *indexPath)))result{
   TableViewLeftSlideAction *(^a)(void(^result)(NSIndexPath *indexPath)) = ^(void(^result)(NSIndexPath *indexPath)){
        self->_result = result;
        return self;
    };
    return a;
}

@end
