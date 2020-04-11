//
//  BaseParams.h
//  FrameWork
//
//  Created by SZJ on 2020/3/15.
//  Copyright © 2020 SZJ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseParams : NSObject
@property (nonatomic,strong) NSMutableDictionary * params;
@property (nonatomic,assign) Class modelClass;
@property (nonatomic,copy) NSString * api;
@property (nonatomic,copy) void(^result)(id data,id oj);
@end

NS_ASSUME_NONNULL_END
