//
//  LCNetWorkTool.h
//  YuanXing
//
//  Created by mac on 2019/10/10.
//  Copyright © 2019 SZJ. All rights reserved.
//




#import <Foundation/Foundation.h>

/*
 请求成功回调
 */
typedef void(^RequestSuccess)(NSString *urlStr,NSDictionary *dic,NSString *json,NSDictionary *params);
/*
 请求失败回调
 */

typedef void(^RequestFail)(NSString *urlStr,NSError *error,NSDictionary *params);


/*
 请求超时时间
 */
const static float LC_Net_RequsetTimeOut = 10.f;

/*
 图片上传超时时间
 */
const static float LC_Net_UploadTimeOut = 200.f;


NS_ASSUME_NONNULL_BEGIN

@interface LCNetWorkTool : NSObject <NSURLSessionDelegate>
/// get 无参数 加密 有HUD
+ (void)getWithUrlStr:(NSString *)urlStr  reqSuccess:(RequestSuccess)reqSuccess reqFail:(RequestFail)reqFail;
/// get 有参数 加密 有HUD
+ (void)getWithUrlStr:(NSString *)urlStr parameters:(NSDictionary *)parameters  reqSuccess:(RequestSuccess)reqSuccess reqFail:(RequestFail)reqFail;
/// get 有参数 有HUD
+ (void)getWithUrlStr:(NSString *)urlStr parameters:(NSDictionary *)parameters secret:(BOOL)secret reqSuccess:(RequestSuccess)reqSuccess reqFail:(RequestFail)reqFail;
/// get
+ (void)getWithUrlStr:(NSString *)urlStr HUD:(BOOL)HUD parameters:(NSDictionary *)parameters secret:(BOOL)secret reqSuccess:(RequestSuccess)reqSuccess reqFail:(RequestFail)reqFail;

/// post 无参数 加密 有HUD
+ (void)postWithUrlStr:(NSString *)urlStr  reqSuccess:(RequestSuccess)reqSuccess reqFail:(RequestFail)reqFail;
/// post 有参数 加密 有HUD
+ (void)postWithUrlStr:(NSString *)urlStr parameters:(NSDictionary *)parameters  reqSuccess:(RequestSuccess)reqSuccess reqFail:(RequestFail)reqFail;
/// post 有参数 有HUD
+ (void)postWithUrlStr:(NSString *)urlStr parameters:(NSDictionary *)parameters secret:(BOOL)secret reqSuccess:(RequestSuccess)reqSuccess reqFail:(RequestFail)reqFail;
/// post
+ (void)postWithUrlStr:(NSString *)urlStr HUD:(BOOL)HUD parameters:(NSDictionary *)parameters secret:(BOOL)secret reqSuccess:(RequestSuccess)reqSuccess reqFail:(RequestFail)reqFail;
/// post 有参数 无加密 有HUD
+ (void)post:(NSString *)urlStr parameters:(NSDictionary *)parameters reqSuccess:(RequestSuccess)reqSuccess reqFail:(RequestFail)reqFail;

/// 表单上传 有HUD scale0.5 类型image/jpeg
+(void)upLoad:(NSString *)headUrl parameters:(NSDictionary *)parameters imageArr:(NSArray *)imageArr  nameArr:(NSArray*)nameArr fileNameArr:(NSArray *)fileNameArr block:(RequestSuccess)success fail:(RequestFail)fail;
/// 表单上传 有HUD scale0.5
+(void)upLoad:(NSString *)headUrl parameters:(NSDictionary *)parameters imageArr:(NSArray *)imageArr  nameArr:(NSArray*)nameArr fileNameArr:(NSArray *)fileNameArr mimeType:(NSString *)mimeType block:(RequestSuccess)success fail:(RequestFail)fail;
/// 表单上传  scale0.5
+(void)upLoad:(NSString *)headUrl HUD:(BOOL)HUD parameters:(NSDictionary *)parameters imageArr:(NSArray *)imageArr  nameArr:(NSArray*)nameArr fileNameArr:(NSArray *)fileNameArr mimeType:(NSString *)mimeType block:(RequestSuccess)success fail:(RequestFail)fail;
///表单上传
+(void)upLoad:(NSString *)headUrl HUD:(BOOL)HUD parameters:(NSDictionary *)parameters imageArr:(NSArray *)imageArr scale:(float)scale  nameArr:(NSArray*)nameArr fileNameArr:(NSArray *)fileNameArr mimeType:(NSString *)mimeType block:(RequestSuccess)success fail:(RequestFail)fail;

///base64
+ (void)base64Upload:(NSString *)headUrl HUD:(BOOL)HUD imageDic:(NSDictionary *)imgBase64Dic parameters:(NSDictionary *)parameters block:(RequestSuccess)success fail:(RequestFail)fail;
@end

NS_ASSUME_NONNULL_END
