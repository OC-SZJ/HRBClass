//
//  NSString+cc_md5.h
//  ocCrazy
//
//  Created by mac on 2018/5/9.
//  Copyright © 2018年 dukai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (cc_md5)
- (NSString *)htmlStrWithColor:(NSString *)color withFont:(NSString *)font;
-(NSString *)pinYin;
-(BOOL)isPhone;
-(BOOL)isPassWord;
-(BOOL)validateNumber;
-(BOOL)validateEmail;
-(BOOL)validateCarNo;
-(BOOL)validateName;
-(BOOL)validateNickname;
-(BOOL)areaCode:(NSString *)code;
-(NSString *)removeLastOneStr;
-(NSDictionary *)paramerForURL;
- (NSString *)phoneHiden;
@end
