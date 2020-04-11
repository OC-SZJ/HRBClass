//
//  LCNetWorkTool.m
//  YuanXing
//
//  Created by mac on 2019/10/10.
//  Copyright © 2019 SZJ. All rights reserved.
//

#import "LCNetWorkTool.h"
#import "MHNetEncryptionTool.h"
#import "CrazyRequestSerialization.h"
#import "SVProgressHUD.h"
#import "LCAPI.h"
#import "LCNetWorkTool+Tool.h"
#import "LOGView.h"




#define kLCNetWorkTool [LCNetWorkTool share]

static LCNetWorkTool *_tool;

@implementation LCNetWorkTool

+ (instancetype)share{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _tool = [LCNetWorkTool new];
    });
    return _tool;
}

#pragma mark --- 网络数据请求 ---

#pragma mark --- get ---

+ (void)getWithUrlStr:(NSString *)urlStr  reqSuccess:(RequestSuccess)reqSuccess reqFail:(RequestFail)reqFail{
    [LCNetWorkTool reqWithUrlStr:urlStr isPost:NO HUD:YES parameters:@{} secret:YES reqSuccess:reqSuccess reqFail:reqFail];
}
+ (void)getWithUrlStr:(NSString *)urlStr parameters:(NSDictionary *)parameters  reqSuccess:(RequestSuccess)reqSuccess reqFail:(RequestFail)reqFail{
    [LCNetWorkTool reqWithUrlStr:urlStr isPost:NO HUD:YES parameters:parameters secret:YES reqSuccess:reqSuccess reqFail:reqFail];
}
+ (void)getWithUrlStr:(NSString *)urlStr parameters:(NSDictionary *)parameters secret:(BOOL)secret reqSuccess:(RequestSuccess)reqSuccess reqFail:(RequestFail)reqFail{
    [LCNetWorkTool reqWithUrlStr:urlStr isPost:NO HUD:YES parameters:parameters secret:secret reqSuccess:reqSuccess reqFail:reqFail];
}

+ (void)getWithUrlStr:(NSString *)urlStr HUD:(BOOL)HUD parameters:(NSDictionary *)parameters secret:(BOOL)secret reqSuccess:(RequestSuccess)reqSuccess reqFail:(RequestFail)reqFail{
    [LCNetWorkTool reqWithUrlStr:urlStr isPost:NO HUD:HUD parameters:parameters secret:secret reqSuccess:reqSuccess reqFail:reqFail];
}

#pragma mark --- post ---
+ (void)post:(NSString *)urlStr parameters:(NSDictionary *)parameters reqSuccess:(RequestSuccess)reqSuccess reqFail:(RequestFail)reqFail{
    [LCNetWorkTool reqWithUrlStr:urlStr isPost:YES HUD:YES parameters:parameters secret:NO reqSuccess:reqSuccess reqFail:reqFail];
}
+ (void)postWithUrlStr:(NSString *)urlStr  reqSuccess:(RequestSuccess)reqSuccess reqFail:(RequestFail)reqFail{
    [LCNetWorkTool reqWithUrlStr:urlStr isPost:YES HUD:YES parameters:@{} secret:YES reqSuccess:reqSuccess reqFail:reqFail];
}
+ (void)postWithUrlStr:(NSString *)urlStr parameters:(NSDictionary *)parameters  reqSuccess:(RequestSuccess)reqSuccess reqFail:(RequestFail)reqFail{
    [LCNetWorkTool reqWithUrlStr:urlStr isPost:YES HUD:YES parameters:parameters secret:YES reqSuccess:reqSuccess reqFail:reqFail];
}
+ (void)postWithUrlStr:(NSString *)urlStr parameters:(NSDictionary *)parameters secret:(BOOL)secret reqSuccess:(RequestSuccess)reqSuccess reqFail:(RequestFail)reqFail{
    [LCNetWorkTool reqWithUrlStr:urlStr isPost:YES HUD:YES parameters:parameters secret:secret reqSuccess:reqSuccess reqFail:reqFail];
}

+ (void)postWithUrlStr:(NSString *)urlStr HUD:(BOOL)HUD parameters:(NSDictionary *)parameters secret:(BOOL)secret reqSuccess:(RequestSuccess)reqSuccess reqFail:(RequestFail)reqFail{
    [LCNetWorkTool reqWithUrlStr:urlStr isPost:YES HUD:HUD parameters:parameters secret:secret reqSuccess:reqSuccess reqFail:reqFail];
}

#pragma mark --- 请求 ---
/*
 网络数据请求
 */
+ (void)reqWithUrlStr:(NSString *)urlStr isPost:(BOOL)isPost HUD:(BOOL)HUD parameters:(NSDictionary *)parameters secret:(BOOL)secret reqSuccess:(RequestSuccess)reqSuccess reqFail:(RequestFail)reqFail{
    
    if (HUD) [SVProgressHUD show];
    
    if (secret) parameters = @{LC_Security_RSAKey:[MHNetEncryptionTool RSAStringEncrypt:parameters]};
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:kLCNetWorkTool delegateQueue:nil];
    
    NSString *fullUrlStr = [NSString stringWithFormat:@"%@/%@",LC_ReqHeader,urlStr];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:fullUrlStr]];
    NSString *method = isPost ? @"POST" : @"GET";
    [request setHTTPMethod:method];
    [request addValue:@"" forHTTPHeaderField:@""];
    [request setTimeoutInterval:LC_Net_RequsetTimeOut];
    
    NSString *bodyStr = [LCNetWorkTool requestBody:parameters];
    bodyStr = [LCNetWorkTool HTMLfilter:bodyStr];
    if (isPost) {
        NSData *bodyData = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
        [request setHTTPBody:bodyData];
    }else{
        request.URL = [NSURL URLWithString:[NSString stringWithFormat:@"%@?%@",fullUrlStr,bodyStr]];
    }
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSDictionary *dic = [self detailRequestData:data response:response error:error secret:secret];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (dic) {
                reqSuccess(fullUrlStr,dic[@"dic"],dic[@"json"],parameters);
                if (kIsTest && ![[dic[@"dic"] allKeys] containsObject:@"code"]) {
                    LC_LOG(@"报错信息%@\n报错参数%@\n接口:%@",dic[@"dic"],parameters,fullUrlStr);
                    [LOGView showMessage:[NSString stringWithFormat:@"报错信息%@\n报错参数%@\n接口:%@",dic[@"dic"],parameters,fullUrlStr]];
                }
            }else{
                reqFail(fullUrlStr,error,parameters);
            }
            if (HUD) [SVProgressHUD dismiss];
        });
        
        
    }];
    [task resume];
}

#pragma mark --- 图片上传(表单) ---

+(void)upLoad:(NSString *)headUrl parameters:(NSDictionary *)parameters imageArr:(NSArray *)imageArr  nameArr:(NSArray*)nameArr fileNameArr:(NSArray *)fileNameArr block:(RequestSuccess)success fail:(RequestFail)fail{
    [self upLoad:headUrl HUD:YES parameters:parameters imageArr:imageArr scale:0.5f nameArr:nameArr fileNameArr:fileNameArr mimeType:@"image/jpeg" block:success fail:fail];
}
+(void)upLoad:(NSString *)headUrl parameters:(NSDictionary *)parameters imageArr:(NSArray *)imageArr  nameArr:(NSArray*)nameArr fileNameArr:(NSArray *)fileNameArr mimeType:(NSString *)mimeType block:(RequestSuccess)success fail:(RequestFail)fail{
    [self upLoad:headUrl HUD:YES parameters:parameters imageArr:imageArr scale:0.5f nameArr:nameArr fileNameArr:fileNameArr mimeType:mimeType block:success fail:fail];
}

+(void)upLoad:(NSString *)headUrl HUD:(BOOL)HUD parameters:(NSDictionary *)parameters imageArr:(NSArray *)imageArr  nameArr:(NSArray*)nameArr fileNameArr:(NSArray *)fileNameArr mimeType:(NSString *)mimeType block:(RequestSuccess)success fail:(RequestFail)fail{
    [self upLoad:headUrl HUD:HUD parameters:parameters imageArr:imageArr scale:0.5f nameArr:nameArr fileNameArr:fileNameArr mimeType:mimeType block:success fail:fail];
}
/*
 表单上传
 */
+(void)upLoad:(NSString *)headUrl HUD:(BOOL)HUD parameters:(NSDictionary *)parameters imageArr:(NSArray *)imageArr scale:(float)scale  nameArr:(NSArray*)nameArr fileNameArr:(NSArray *)fileNameArr mimeType:(NSString *)mimeType block:(RequestSuccess)success fail:(RequestFail)fail
{
    
    if (HUD) [SVProgressHUD show];
    
    if (scale >1 || scale==0) scale = 0.5;
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSString *fullUrlStr = [NSString stringWithFormat:@"%@/%@",LC_ReqHeader,headUrl];
    NSMutableURLRequest *request = [[CrazyHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:fullUrlStr parameters:parameters constructingBodyWithBlock:^(id<CrazyMultipartFormData> formData) {
        
        if (imageArr.count != nameArr.count && imageArr.count != fileNameArr.count) {
            NSLog(@"文件名数组和后台数组和图片数组 数量不统一 ！！！！！");
            return ;
        }
        
        for (int i = 0; i<imageArr.count; i++) {
            UIImage *image = imageArr[i];
            NSString *name = nameArr[i];
            NSString *fileName = fileNameArr[i];
            
            if([image isKindOfClass:[UIImage class]]){
                NSData *imageData= UIImageJPEGRepresentation(image, scale);
                [formData appendPartWithFileData:imageData name:name fileName:fileName mimeType:mimeType];
            }
        }
        
    } error:nil];
    
    
    NSURLSessionUploadTask *dataTask=[session uploadTaskWithRequest:request fromData:nil completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSDictionary *dic = [self detailRequestData:data response:response error:error secret:NO];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (dic) {
                success(fullUrlStr,dic[@"dic"],dic[@"json"],parameters);
            }else{
                fail(fullUrlStr,error,parameters);
            }
            if (HUD) [SVProgressHUD dismiss];
        });
    }];
    
    
    [dataTask resume];
}

#pragma mark --- 图片上传(base64) ---
+ (void)base64Upload:(NSString *)headUrl HUD:(BOOL)HUD imageDic:(NSDictionary *)imgBase64Dic parameters:(NSDictionary *)parameters block:(RequestSuccess)success fail:(RequestFail)fail{
    
    NSMutableDictionary *postDic = [[NSMutableDictionary alloc]init];
    for (int i = 0; i<imgBase64Dic.allKeys.count; i++) {
        
        NSString *key = imgBase64Dic.allKeys[i];
        NSString *base64 = imgBase64Dic[key];
        
        [postDic setObject:base64 forKey:key];
    }
    
    for (int i = 0; i<parameters.allKeys.count; i++) {
        
        NSString *key = parameters.allKeys[i];
        UIImage *value = parameters[key];
        
        [postDic setObject:value forKey:key];
    }
    
    [self postWithUrlStr:headUrl HUD:HUD parameters:postDic secret:NO reqSuccess:success reqFail:fail];
}

+ (NSDictionary *)detailRequestData:(NSData *)data response:(NSURLResponse *)response error:(NSError *)error secret:(BOOL)secret{
    if (error == nil) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];//转换数据格式
        NSString * json = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        if (secret) dic = [self stringToObject:[MHNetEncryptionTool RSAStringDecrypt:json]];
        if (!dic) dic = @{};
        return @{@"dic":dic,@"json":json};
    }
    return nil;
}

@end
