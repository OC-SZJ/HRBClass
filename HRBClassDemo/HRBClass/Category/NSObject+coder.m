//
//  NSObject+coder.m
//  test
//
//  Created by mac on 2017/5/9.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "NSObject+coder.h"

@implementation NSObject (coder)

#define coder



-(void)HZ_encode:(NSCoder *)aCoder
{
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        NSString *key = [[NSString alloc]initWithUTF8String:name];
        [aCoder encodeObject:[self valueForKey:key] forKey:key];
    }
}

-(void)HZ_decode:(NSCoder *)aDecoder
{
    unsigned int count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        const char *name = ivar_getName(ivar);
        NSString *key = [[NSString alloc]initWithUTF8String:name];
        id value = [aDecoder decodeObjectForKey:key];
        [self setValue:value forKey:key];
    }
}

@end
