//
//  LCNetWorkTool+Tool.m
//  YuanXing
//
//  Created by mac on 2019/10/10.
//  Copyright © 2019 SZJ. All rights reserved.
//

#import "LCNetWorkTool+Tool.h"

@implementation LCNetWorkTool (Tool)


+(NSString *)HTMLfilter:(NSString *)urlStr{
    
    NSMutableString *outputStr = [NSMutableString stringWithString:urlStr];
    [outputStr replaceOccurrencesOfString:@"+"
                               withString:@"%2B"
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0, [outputStr length])];
    return outputStr;
}

+(NSDictionary *)stringToObject:(NSString *)JsonString{
    JsonString = [JsonString stringByReplacingOccurrencesOfString:@"\0" withString:@""];
    NSData *jsonData = [JsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    id objc = [NSJSONSerialization JSONObjectWithData:jsonData
                                              options:NSJSONReadingMutableContainers
                                                error:&err];
    return objc;
}

+(NSString *)requestBody:(NSDictionary *)parameters{
    
    NSMutableString * bodyStr = [[NSMutableString alloc]init];
    for (int i = 0 ; i<parameters.allKeys.count ; i++) {
        NSString *key = parameters.allKeys[i];
        
        if (parameters[key] == nil) {
            [bodyStr appendFormat:@"%@=%@",key,@""];
        }else{
            [bodyStr appendFormat:@"%@=%@",key,parameters[key]];
        }
        if (parameters.allKeys.count-1 > i) {
            [bodyStr appendString:@"&"];
        }
    }
    
    return bodyStr;
}

+(NSString *)requestURl:(NSString*)header parameters:(NSDictionary *)parameters{
    if (parameters.allKeys == 0 && parameters == nil) {
        return header;
    }else {
        NSMutableString *requstStr = [[NSMutableString alloc]initWithString:header];
        [requstStr appendString:@"?"];
        NSArray * keys = parameters.allKeys;
        for (int i = 0 ; i < keys.count; i++) {
            NSString *key  = keys[i];
            [requstStr appendFormat:@"%@=%@&",key,parameters[key]];
        }
        [requstStr deleteCharactersInRange:NSMakeRange(requstStr.length -1, 1)];
        
        return requstStr;
    }
}
//返回base64字符串  scale 默认0.5
+(NSString *)base64Str:(UIImage *)img scale:(float)scale{
    if (scale ==0 || scale > 1) {
        scale = 0.5;
    }
    
    NSData* imageData = UIImageJPEGRepresentation(img, scale);
    NSString *strBase64 = [imageData base64EncodedStringWithOptions:0];
    NSString *outputStr = [self HTMLfilter:strBase64];
    return outputStr;
}
@end
