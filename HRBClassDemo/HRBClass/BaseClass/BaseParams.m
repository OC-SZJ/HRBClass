//
//  BaseParams.m
//  FrameWork
//
//  Created by SZJ on 2020/3/15.
//  Copyright © 2020 SZJ. All rights reserved.
//

#import "BaseParams.h"

@implementation BaseParams
{
    NSMutableDictionary *_params;
}
@dynamic params;
-(NSMutableDictionary *)params{
    if (!_params)_params = @{}.mutableCopy;
    return _params;
}
-(void)setParams:(NSMutableDictionary *)params{
    if (!_params)_params = @{}.mutableCopy;
    for (NSString *keys in params.allKeys) {
        _params[keys] = params[keys];
    }
}
@end
