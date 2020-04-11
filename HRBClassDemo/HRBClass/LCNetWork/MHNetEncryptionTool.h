//
//  MHNetEncryptionTool.h
//  JadeShop
//
//  Created by mac on 2019/7/11.
//  Copyright © 2019年 SZJ.test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Security/Security.h>
/*
    加密解密思路
 
    公钥 和 私钥 都是 Base64过的
 
    1.公钥字符串 反Base64
    2.公钥 利用  Keychain 转换成 SeckeyRef
    3.加密数据转码成 utf8 data
    4.利用 公钥（SeckeyRef）进行加密 （pkcs1）
    5.将加密后的data Base64
    6.Base64后的data utf8 转成 最终的加密字符串
 
    ↑↑↑↑↑↑↑↑↑↑↑↑↑  加密完成  ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑
 
    1.私钥字符串 反Base64
    2.私钥 利用  Keychain 转换成 SeckeyRef
    3.加密字符串 反Base64 得到data
    4.利用 私钥（SeckeyRef）进行解密 （pkcs1）
    5.解密后的data utf8 得到json
 
    ↑↑↑↑↑↑↑↑↑↑↑↑↑  解密完成  ↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑
 */



/*
 加密数据key 字段
 */
static NSString *LC_Security_RSAKey = @"param";

@interface MHNetEncryptionTool : NSObject

//加密字符串
+(NSString *)RSAStringEncrypt:(id)object;
//解密字符串
+(NSString *)RSAStringDecrypt:(NSString *)object;



@end
