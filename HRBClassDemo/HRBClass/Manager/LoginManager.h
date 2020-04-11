//
//  LoginManager.h
//  mingjiangkeji
//
//  Created by SZJ on 2020/3/23.
//  Copyright © 2020 SZJ. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface LoginModel : BaseModel

@property (nonatomic,copy) NSString * code;

@property (nonatomic,copy) NSString * message;
/*
  用户id
 */
@property (nonatomic,copy) NSString * uid;
/*
  审核状态 1-审核中 2-审核通过 3-审核失败
 */
@property (nonatomic,copy) NSString * state;
/*
  1-跳首页 2-跳员工信息页
 */
@property (nonatomic,copy) NSString * type;
@end




@interface LoginManager : NSObject
NSString * UID(void);
void SaveAndLogIn(LoginModel *model);
UIViewController *MainViewController(void);
@end

NS_ASSUME_NONNULL_END
