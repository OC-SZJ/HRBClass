//
//  CC_BUG.h
//  AutoCare365
//
//  Created by mac on 2018/9/27.
//  Copyright © 2018年 SZJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CC_BUG : NSObject


+ (void)beginBug:(int(^)(NSString *uuid,NSString *dsymUUID,NSString *reason))callBack;

@end
