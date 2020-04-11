//
//  MoveLockShowView.m
//  JadeShop
//
//  Created by mac on 2019/7/26.
//  Copyright © 2019 SZJ.test. All rights reserved.
//

#import "MoveLockShowView.h"
#import "MoveLockView.h"
@implementation MoveLockShowView

{
    MoveLockView *_lockView;
    void(^_callBack)(NSString * key);
}
+ (instancetype)creatWithCallBack:(void(^)(NSString * key))callBack{
    MoveLockShowView *showView = [[NSBundle mainBundle] loadNibNamed:@"MoveLockShowView" owner:nil options:nil].firstObject;
    showView->_callBack =  callBack;
    return showView;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    _lockView = [MoveLockView shareWithCallBack:_callBack];
    [self addSubview:_lockView];
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];

    _lockView.frame = self.bounds;
}


@end
