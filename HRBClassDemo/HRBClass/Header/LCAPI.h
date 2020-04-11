//
//  API.h
//  AutoCare365
//
//  Created by SZJ on 2018/9/2.
//  Copyright © 2018年 SZJ. All rights reserved.
//

#ifndef LCAPI_h
#define LCAPI_h


/*
测试服务器  1  正式服务器 0
 */

#define kIsTest 1

#if kIsTest
/*
   测试环境
 */
#define LC_ReqHeader @"http://app227.app.longcai.net/employee/"
#define LC_ImageHeader @"http://app227.app.longcai.net/"

#else
/*
   正式环境
 */
#define LC_ReqHeader @"http://app227.app.longcai.net/employee/"
#define LC_ImageHeader @"http://app227.app.longcai.net/"

#endif

/*
 登录
 @header:
 无
 @params:
 1    type    1-验证码登录 2-账密登录    是    [string]
 2    mobile    手机号    是    [string]
 3    code    验证码    是    [string]
 4    password    密码    是    [string]
 @return
 详见 LoginModel 类
 */
static NSString *_lc_login_index = @"login/index";
#endif /* LCAPI_h */

