//
//  BaseView.h
//  Test
//
//  Created by mac on 2019/10/25.
//  Copyright © 2019 SZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseView : UIView
-(void)handle;
/*
  网络请求实现 (其他请求,需手动调用)
  重点: block(xx,xx,xx)
  
 */
@property (nonatomic,copy) void(^otherPost)(Class modelClass,NSString *api,NSDictionary *params,void(^result)(id data, id oj)) ;
/*
  网络请求实现 (model对应唯一api,参数只有UID)
  重点: block(xx,xx,xx)
 */
@property (nonatomic,copy) void(^uidPost)(Class modelClass,void(^result)(id data, id oj));

/*
  网络请求实现 (model对应唯一api)
  重点: block(xx,xx,xx)
 */
@property (nonatomic,copy) void(^nilApiPost)(Class modelClass,NSDictionary *params,void(^result)(id data, id oj));

__kindof BaseView *LCLoadNib(NSString *nibName);


- (IBAction)remove;

@end

NS_ASSUME_NONNULL_END
