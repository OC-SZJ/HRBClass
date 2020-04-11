//
//  NSObject+coder.h
//  test
//
//  Created by mac on 2017/5/9.
//  Copyright © 2017年 mac. All rights reserved.
//


#define codera \
-(void)encodeWithCoder:(NSCoder *)aCoder{\
    [self HZ_encode:aCoder];\
}\
-(instancetype)initWithCoder:(NSCoder *)aDecoder{\
    self = [super init];\
    if (self) {\
        [self HZ_decode:aDecoder];\
    }\
    return self;\
}




#import <Foundation/Foundation.h>
#import <objc/runtime.h>
@interface NSObject (coder)
-(void)HZ_encode:(NSCoder *)aCoder;
-(void)HZ_decode:(NSCoder *)aDecoder;
@end
