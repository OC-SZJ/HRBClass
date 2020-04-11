//
//  NSString+cc_md5.m
//  ocCrazy
//
//  Created by mac on 2018/5/9.
//  Copyright © 2018年 dukai. All rights reserved.
//

#import "NSString+cc_md5.h"

#import <CommonCrypto/CommonDigest.h>

#import "PinYin4Objc.h"

@implementation NSString (cc_md5)

- (NSString *)htmlStrWithColor:(NSString *)color withFont:(NSString *)font{
    
   NSString  * cc_change = @"<font ";
   if (color && color.length != 0) {
      cc_change = [cc_change stringByAppendingFormat:@"color = '%@' ",color];
       if (!font || font.length == 0) {
           cc_change = [cc_change stringByAppendingString:@">"];
       }
   }
   if (font && font.length != 0) {
      cc_change = [cc_change stringByAppendingFormat:@"size = '%@pt'>",font];
   }
    cc_change = [cc_change stringByAppendingFormat:@"%@</font>",self];
    return cc_change;
}

- (NSString *)phoneHiden{
    if (self.length != 11) {
        return self;
    }
    return  [self stringByReplacingCharactersInRange:NSMakeRange(3,4) withString:@"****"];
}
- (NSString *)removeLastOneStr{

    if([self length] > 0){
        return  [self substringToIndex:([self length]-1)];//去掉最后一个字符串如", ."
    }else{
        return self;
    }
}
-(NSString *)pinYin{
    NSString *str = nil;

    NSString *first = [str substringToIndex:1];
    if ([first isEqualToString:@"长"] || [first isEqualToString:@"重"]) {
        return @"C";
    }
    NSString *pinyin = [PinyinHelper pinyin:self];
    NSString *nStr = [[pinyin substringToIndex:1] uppercaseString];
    return nStr;
}


//数字验证
-(BOOL)validateNumber{
    NSString *emailRegex = @"^[0-9]*$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
    
}
//手机验证
-(BOOL)isPhone{
    NSString *regex = @"1[0-9]{10}";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:self];
    return isMatch;
}

//邮箱验证
-(BOOL)validateEmail{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
    
}

//车牌号验证
- (BOOL)validateCarNo{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:self];
}
//用户名
- (BOOL)validateName
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:self];
    return B;
}
//密码
- (BOOL)isPassWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:self];
}
//昵称
- (BOOL)validateNickname
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:self];
}

-(BOOL)areaCode:(NSString *)code
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init] ;
    [dic setObject:@"北京" forKey:@"11"];
    [dic setObject:@"天津" forKey:@"12"];
    [dic setObject:@"河北" forKey:@"13"];
    [dic setObject:@"山西" forKey:@"14"];
    [dic setObject:@"内蒙古" forKey:@"15"];
    [dic setObject:@"辽宁" forKey:@"21"];
    [dic setObject:@"吉林" forKey:@"22"];
    [dic setObject:@"黑龙江" forKey:@"23"];
    [dic setObject:@"上海" forKey:@"31"];
    [dic setObject:@"江苏" forKey:@"32"];
    [dic setObject:@"浙江" forKey:@"33"];
    [dic setObject:@"安徽" forKey:@"34"];
    [dic setObject:@"福建" forKey:@"35"];
    [dic setObject:@"江西" forKey:@"36"];
    [dic setObject:@"山东" forKey:@"37"];
    [dic setObject:@"河南" forKey:@"41"];
    [dic setObject:@"湖北" forKey:@"42"];
    [dic setObject:@"湖南" forKey:@"43"];
    [dic setObject:@"广东" forKey:@"44"];
    [dic setObject:@"广西" forKey:@"45"];
    [dic setObject:@"海南" forKey:@"46"];
    [dic setObject:@"重庆" forKey:@"50"];
    [dic setObject:@"四川" forKey:@"51"];
    [dic setObject:@"贵州" forKey:@"52"];
    [dic setObject:@"云南" forKey:@"53"];
    [dic setObject:@"西藏" forKey:@"54"];
    [dic setObject:@"陕西" forKey:@"61"];
    [dic setObject:@"甘肃" forKey:@"62"];
    [dic setObject:@"青海" forKey:@"63"];
    [dic setObject:@"宁夏" forKey:@"64"];
    [dic setObject:@"新疆" forKey:@"65"];
    [dic setObject:@"台湾" forKey:@"71"];
    [dic setObject:@"香港" forKey:@"81"];
    [dic setObject:@"澳门" forKey:@"82"];
    [dic setObject:@"国外" forKey:@"91"];
    
    if ([dic objectForKey:code] == nil) {
        
        return NO;
    }
    return YES;
}

/**

获取url的所有参数

@param url 需要提取参数的url

@return NSDictionary

*/

-(NSDictionary *)paramerForURL{

    NSMutableDictionary *paramer = [[NSMutableDictionary alloc]init];

    //创建url组件类

    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:self];

    //遍历所有参数，添加入字典

    [urlComponents.queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

        [paramer setObject:obj.value forKey:obj.name];

    }];

    return paramer;

}

@end
