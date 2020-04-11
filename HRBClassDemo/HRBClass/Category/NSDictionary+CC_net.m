//
//  NSDictionary+CC_net.m
//  ocCrazy
//
//  Created by mac on 2018/8/6.
//  Copyright © 2018年 dukai. All rights reserved.
//

#import "NSDictionary+CC_net.h"
#import "LCAPI.h"
#import "Tool.h"
#define CC_SUCCESS [self[@"code"] integerValue] == 200

@implementation NSDictionary (CC_net)

- (void)success:(void(^)())success faild:(void(^)())faild{
    if (CC_SUCCESS) {
        if (success) success();
    }else{
        [CCToast setMessage:self[@"message"]];
        if (faild) faild();
    }
}

- (void)success:(void(^)())success{
    [self success:success faild:nil];
}

#ifdef DEBUG
//打印到控制台时会调用该方法
- (NSString *)descriptionWithLocale:(id)locale{
    return self.debugDescription;
}
//有些时候不走上面的方法，而是走这个方法
- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level{
    return self.debugDescription;
}
//用po打印调试信息时会调用该方法
- (NSString *)debugDescription{
   NSMutableString *string = [NSMutableString string];
    
    // 开头有个{
    [string appendString:@"{\n"];
    
    // 遍历所有的键值对
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [string appendFormat:@"\t%@", key];
        [string appendString:@" : "];
        [string appendFormat:@"%@,\n", obj];
    }];
    
    // 结尾有个}
    [string appendString:@"}"];
    
    // 查找最后一个逗号
    NSRange range = [string rangeOfString:@"," options:NSBackwardsSearch];
    if (range.location != NSNotFound)
        [string deleteCharactersInRange:range];
    
    return string;
}
#endif
@end
