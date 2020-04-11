//
//  MoveLockShowView.h
//  JadeShop
//
//  Created by mac on 2019/7/26.
//  Copyright © 2019 SZJ.test. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MoveLockShowView : UIView
+ (instancetype)creatWithCallBack:(void(^)(NSString * key))callBack;
@end

NS_ASSUME_NONNULL_END
