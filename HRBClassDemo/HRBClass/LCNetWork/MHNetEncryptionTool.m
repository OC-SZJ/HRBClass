//
//  MHNetEncryptionTool.m
//  JadeShop
//
//  Created by mac on 2019/7/11.
//  Copyright © 2019年 SZJ.test. All rights reserved.
//

#import "MHNetEncryptionTool.h"




/*
   加密公钥
 */
static NSString *pubkey =
@"MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEArdWfW1MAFLlfNEzxFVCWtHbH818HVpzUgA4UfhGODLsxPE7HtA+Ik4Z8/fm2EtjqKCM/Bjf6AsX9KeFiosXivJ1AR6dLgoRmO/UBEn/uokbmyMlJk0aVcIH/DDQ4z0byC37f8JX+IvASmc1PJpQErh1B0IVwdyYFQ9XQUAHmXM2T2eFBdOisgHk0P+YxRQ++obEUjOyzXdDM+baEYppDwmXBU4SAeLWMSgNavShwMfo4HPhKm6NrSKsvcBIbzwiSdhrn04M1PXXt9ETx5LgJyvNCJg71CbqvbkGSloE4hj08IdXxc+9wR363SySIUwBCyWg75C0RND0fOFOC0g/vcwIDAQAB";



/*
 加密私钥
 */
static NSString *privkey =
@"MIIEpQIBAAKCAQEArdWfW1MAFLlfNEzxFVCWtHbH818HVpzUgA4UfhGODLsxPE7HtA+Ik4Z8/fm2EtjqKCM/Bjf6AsX9KeFiosXivJ1AR6dLgoRmO/UBEn/uokbmyMlJk0aVcIH/DDQ4z0byC37f8JX+IvASmc1PJpQErh1B0IVwdyYFQ9XQUAHmXM2T2eFBdOisgHk0P+YxRQ++obEUjOyzXdDM+baEYppDwmXBU4SAeLWMSgNavShwMfo4HPhKm6NrSKsvcBIbzwiSdhrn04M1PXXt9ETx5LgJyvNCJg71CbqvbkGSloE4hj08IdXxc+9wR363SySIUwBCyWg75C0RND0fOFOC0g/vcwIDAQABAoIBAQCC3gHcRL4Y2/06aHpOq57pOUsKgw4JPIQV64Ot7RVdrEdCuaRKgC83sNXEdguGYNrXYMF/swB6ugb/UnhpRkSN7myIBQApv/cfSDGIddt3O51ep3rGbyrtyk/yJhZmpWhvExMQEjuCne3C7/eYeXKUid4UV4D1kiAAk6UBtoxwa+4tDd7xIxRyUiPhE4B6x3LJ2G6i0dQNwLRQe0VFsy3xnwL5Y7vJ3DN4oOfXFLHbLg6pbQiuS12KnoTkU2ujRLv/oBbd2LLXnOZSVP65jYEJLrUOp6fTqfYpi6cAZ7XXXcLmU/MoQqwSY30TyZF67W89kfhwNSNL2UX1UndtmIXRAoGBANW6dYw2AFV2pT/IGHJxQGHoWq/zUiuSpqRMi1xY6lhxoveTQOJQ5XrC1OSvLPxCTOopA1RYxQD5JGcNhpgTDjll/Y/8/DRjf8G+wLPu53SVKYzlAdmQbjC/j5uI9/mIG3y1krro5ZQvR9Be7wD8SVuTmN8EK1Yvegf5cc1HSnfdAoGBANA3PzsBUU882b6XtP9k4upbvMYcI3SmROQGGDqzpVYK98rxPeTL68Tq9UzN9hfhBkf3xv/6WfAzLNWCCev+Dys0D7xdOmzI/Euys+ERvTnYDNvh0Gr1NL3swMKoN8g/urrd5ADMKFYglLdrMaa89/VMKBmQ+YZL2ss1FU06aLePAoGAVZH8xDFOuujwynOTjiZXr5t2y6Fw0a86dueKmGOlF9oPdG4JeVMIPblJwXF9YlYtM0dOZPPRlE0rzPK2Y6aleEekWITieRspKGn1/1R0aNHbu+RodDIGXBAmMBCLr+VVk/2ijKD4Yfb4Gq4XpN5dhIO4nfmuXChQBGdTr+uOHiUCgYEAihG4iiYLhuGw+iObUCfUGNgQS8Zo9Hc1A4fPFU3++xl2y0pBYrCefQvY8b85ywfapGp3uVKHxTIKLuJ2NdlYsatqK9weW/jC5GdxxHOA6RSNIlmRXPuQp8iQ4gOuScmIx1VQVf8LWGFufFpGqGxyeGSxypJKBHXUdh+TKozq150CgYEAsG2p/UG1Of2/0FK1CYL08B1s8JL2NIlP04ImZYVKakQBAzmapqdtCbqft53zQga0WEOEg9HRy1+xOZhlGCki1vj0nP8SxkFONiqlqdQjnMcOqVEyPTmZQmMu+vqXL3DJiSBIgzDqftW2QoB63ABMF33OCDAVe3+plBAIZ9d4uuk=";

static  SecKeyRef _public_key=nil;
static  SecKeyRef _private_key=nil;

@implementation MHNetEncryptionTool

static NSData *Base64_decode(NSString *str){
    NSData *data = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return data;
}

/*
 利用 Keychain 把字符串转换成 SecKeyRef

 */
SecKeyRef GetPublicKey(){
    
    if(_public_key == nil){
        /*
         decode 公钥
         */
        NSData *data = Base64_decode(pubkey);
        
        /*
          存储公钥的tag
         */
        NSString *tag = @"RSA_PUBLIC_KEY";
        NSData *d_tag = [NSData dataWithBytes:[tag UTF8String] length:[tag length]];
        
        /*
         移除旧的 公钥 数据
         */
        NSMutableDictionary *publicKey = [[NSMutableDictionary alloc] init];
        [publicKey setObject:(__bridge id) kSecClassKey forKey:(__bridge id)kSecClass]; // 密钥类
        [publicKey setObject:(__bridge id) kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType]; //RSA条目
        [publicKey setObject:d_tag forKey:(__bridge id)kSecAttrApplicationTag]; //属性
        SecItemDelete((__bridge CFDictionaryRef)publicKey);
        
        /*
         将新的 数据 添加到 Keychain
         */
        [publicKey setObject:data forKey:(__bridge id)kSecValueData]; //设置数据
        [publicKey setObject:(__bridge id) kSecAttrKeyClassPublic forKey:(__bridge id)kSecAttrKeyClass];//公钥类
        [publicKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecReturnPersistentRef];//布尔值，是否返回对某一项的持久引用。

        OSStatus status = SecItemAdd((__bridge CFDictionaryRef)publicKey, nil);//添加

        if (status == errSecSuccess) {
        [publicKey removeObjectForKey:(__bridge id)kSecValueData];
        [publicKey removeObjectForKey:(__bridge id)kSecReturnPersistentRef];
        [publicKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecReturnRef]; //返回实例(SecKeychainItemRef, SecKeyRef, SecCertificateRef, SecIdentityRef, or CFDataRef)
            
            
        // Now fetch the SecKeyRef version of the key
        SecKeyRef keyRef = nil;
        status = SecItemCopyMatching((__bridge CFDictionaryRef)publicKey, (CFTypeRef *)&keyRef);
        if(status == errSecSuccess){
            _public_key = keyRef;
        }else{
            return nil;
        }
        }else{
            NSLog(@"公钥转码失败，添加到Keychain步骤失败");
            return nil;
        }
        
       
        
    }
    return _public_key;
}
/*
 利用 Keychain 把字符串转换成 SecKeyRef
 */

SecKeyRef GetPrivateKey(){
    if(_private_key == nil){
        // This is a base64 encoded key. so, decode it.
        NSData *data = Base64_decode(privkey);
        
        if(!data){ return nil; }
        //a tag to read/write keychain storage
        NSString *tag = @"RSA_PRIVATE_KEY";
        NSData *d_tag = [NSData dataWithBytes:[tag UTF8String] length:[tag length]];
        
        // Delete any old lingering key with the same tag
        NSMutableDictionary *privateKey = [[NSMutableDictionary alloc] init];
        [privateKey setObject:(__bridge id) kSecClassKey forKey:(__bridge id)kSecClass];
        [privateKey setObject:(__bridge id) kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
        [privateKey setObject:d_tag forKey:(__bridge id)kSecAttrApplicationTag];
        SecItemDelete((__bridge CFDictionaryRef)privateKey);
        
        // Add persistent version of the key to system keychain
        [privateKey setObject:data forKey:(__bridge id)kSecValueData];
        [privateKey setObject:(__bridge id) kSecAttrKeyClassPrivate forKey:(__bridge id)kSecAttrKeyClass];
        [privateKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecReturnPersistentRef];
        
        CFTypeRef persistKey = nil;
        OSStatus status = SecItemAdd((__bridge CFDictionaryRef)privateKey, &persistKey);
        if (persistKey != nil){ CFRelease(persistKey); }
        if ((status != noErr) && (status != errSecDuplicateItem)) { return nil; }
        
        [privateKey removeObjectForKey:(__bridge id)kSecValueData];
        [privateKey removeObjectForKey:(__bridge id)kSecReturnPersistentRef];
        [privateKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecReturnRef];
        [privateKey setObject:(__bridge id) kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
        
        // Now fetch the SecKeyRef version of the key
        SecKeyRef keyRef = nil;
        status = SecItemCopyMatching((__bridge CFDictionaryRef)privateKey, (CFTypeRef *)&keyRef);
        if(status != noErr){
            return nil;
        }
        _private_key = keyRef;
    }
    return _private_key;
}

/*
 字符串加密
 */
+(NSString *)RSAStringEncrypt:(id)object{
    /*
     加密字符串转换成 data
     */
    
    NSData *strData;
    
    if ([object isKindOfClass:[NSDictionary class]]) {
        ;
        strData = [[MHNetEncryptionTool jsonStringEncoded:object] dataUsingEncoding:NSUTF8StringEncoding];
    }else{
        strData = [(NSString *)object dataUsingEncoding:NSUTF8StringEncoding];
    }
    

    /*
      字符串转换成 keyRef
     */
    SecKeyRef pub = GetPublicKey();
    /*
     输入时，ciphertext参数中提供的缓冲区大小。返回时，实际放置在缓冲区中的数据量
     */
    size_t block_size = SecKeyGetBlockSize(pub) * sizeof(uint8_t);
    /*
     加密返回的数据
     */
    void *encData = malloc(block_size);
    
    OSStatus status = SecKeyEncrypt(pub,kSecPaddingPKCS1,[strData bytes],strData.length, encData,&block_size);
    
    if (status != 0) {
        NSLog(@"加密失败. Error Code: %d", status);
    }
    
    NSData *resultData = [[NSData dataWithBytes:encData length:block_size] base64EncodedDataWithOptions:0];
    
    return [MHNetEncryptionTool utf8String:resultData];
}
//解析字符串
+(NSString *)RSAStringDecrypt:(NSString *)text{
    /*
     加密字符串 解除base64转换成 data
     */
    NSData *strData =  Base64_decode(text);
    /*
     字符串转换成 keyRef
     */
    SecKeyRef private = GetPrivateKey();
    /*
     输入时，ciphertext参数中提供的缓冲区大小。返回时，实际放置在缓冲区中的数据量
     */
    size_t block_size = SecKeyGetBlockSize(private) * sizeof(uint8_t);
    /*
     解密返回的数据
     */
    void *decData = malloc(block_size);
    
    

    
    OSStatus status = SecKeyDecrypt(private, kSecPaddingPKCS1, [strData bytes], strData.length, decData, &block_size);
    
    if (status != errSecSuccess) {
        NSLog(@"解密失败. Error Code: %d", status);
    }
    
    NSData *dec = [NSData dataWithBytes:decData length:block_size];
    
    return [MHNetEncryptionTool utf8String:dec];
}


+ (NSString *)jsonStringEncoded:(NSDictionary *)dic{
    if ([NSJSONSerialization isValidJSONObject:dic]) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:&error];
        NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        if (!error) return json;
    }
    return nil;
}
+ (NSString *)utf8String:(NSData *)data{
    if (data.length > 0) {
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    return @"";
}
@end
