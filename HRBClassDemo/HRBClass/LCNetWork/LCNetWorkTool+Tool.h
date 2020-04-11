//
//  LCNetWorkTool+Tool.h
//  YuanXing
//
//  Created by mac on 2019/10/10.
//  Copyright © 2019 SZJ. All rights reserved.
//

#import "LCNetWorkTool.h"
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface LCNetWorkTool (Tool)
+(NSString *)HTMLfilter:(NSString *)urlStr;
+(NSString *)requestBody:(NSDictionary *)parameters;
+(NSString *)requestURl:(NSString*)header parameters:(NSDictionary *)parameters;
+(NSString *)base64Str:(UIImage *)img scale:(float)scale;
+(NSDictionary *)stringToObject:(NSString *)JsonString;
@end



NS_ASSUME_NONNULL_END
