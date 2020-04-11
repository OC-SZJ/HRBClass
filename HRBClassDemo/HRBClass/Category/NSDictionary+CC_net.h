//
//  NSDictionary+CC_net.h
//  ocCrazy
//
//  Created by mac on 2018/8/6.
//  Copyright © 2018年 dukai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (CC_net)

- (void)success:(void(^)(void))success faild:(void(^)(void))faild;

- (void)success:(void(^)(void))success;
@end
