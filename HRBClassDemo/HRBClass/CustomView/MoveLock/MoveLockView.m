//
//  MoveLockView.m
//  JadeShop
//
//  Created by mac on 2019/2/21.
//  Copyright © 2019年 SZJ.test. All rights reserved.
//

#import "MoveLockView.h"
#import "Tool.h"
CGFloat DistanceBetweenPoints (CGPoint first, CGPoint second) {
    CGFloat deltaX = second.x - first.x;
    CGFloat deltaY = second.y - first.y;
    return sqrt(deltaX*deltaX + deltaY*deltaY );
};



@interface MoveLockView()

@property (nonatomic,strong) UIBezierPath * path;
@property (nonatomic,strong) CAShapeLayer * shapeLayer;

@end

@implementation MoveLockView
{
    void(^_callBack)(NSString * resultStr);
    NSMutableArray <NSNumber *>*_indexArr;
    NSMutableArray <NSValue *> *_pointArr;
}



+ (instancetype)shareWithCallBack:(void(^)(NSString * resultStr))callBack{
    MoveLockView *view = [[MoveLockView alloc] init];
    view->_callBack = callBack;
    view->_indexArr = [NSMutableArray array];
    view->_pointArr = [NSMutableArray array];
    view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
    return view;
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [touches.anyObject locationInView:self];
    NSInteger index = [self pointOfIndex:point];
    [_indexArr addObject:@(index)];
    CGPoint c_point = [self getCenterWithIndex:index];
    [_pointArr addObject:[NSValue valueWithCGPoint:c_point]];
 
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [touches.anyObject locationInView:self];
    NSInteger index = [self pointOfIndex:point];
    CGPoint c_point = [self getCenterWithIndex:index];
    NSNumber *num = @(index);
    if (![_indexArr containsObject:num] && DistanceBetweenPoints(point, c_point) <= 10) {
        [_indexArr addObject:@(index)];
        [_pointArr replaceObjectAtIndex:_pointArr.count - 1 withObject:[NSValue valueWithCGPoint:c_point]];
    }else{
        if (_indexArr.count == _pointArr.count) {
            [_pointArr addObject:[NSValue valueWithCGPoint:point]];
        }else{
            [_pointArr replaceObjectAtIndex:_pointArr.count - 1 withObject:[NSValue valueWithCGPoint:point]];
        }
    }
   
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_indexArr removeAllObjects];
    [_pointArr removeAllObjects];
}



- (NSInteger)pointOfIndex:(CGPoint)point{
    CGFloat x = self.width / 3;
    int x_index = point.x / x;
    int y_index = point.y / x;
    return x_index + (y_index) * 3 ;
}


- (CGPoint)getCenterWithIndex:(NSInteger)index{
    CGFloat x = self.width / 3;
    int y_index = (int)index / 3;
    int x_index = index % 3;
    CGPoint centerPoint = CGPointMake(((float)x_index + 0.5) * x, ((float)y_index + 0.5) * x);
    return centerPoint;
}





-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    [[UIColor blueColor] set];
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    bezierPath.lineWidth = 3;
    
    for (int i = 0; i < _pointArr.count; i++) {
        if (i==0) {
            [bezierPath moveToPoint:_pointArr[i].CGPointValue];
        }else{
            [bezierPath addLineToPoint:_pointArr[i].CGPointValue];
        }
    }
    
    NSLog(@"%@",_pointArr);
    [bezierPath stroke];
}




@end
