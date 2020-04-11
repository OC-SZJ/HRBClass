//
//  BaseView.m
//  Test
//
//  Created by mac on 2019/10/25.
//  Copyright © 2019 SZJ. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

-(void)awakeFromNib{
    [super awakeFromNib];
    [self frameSelf];
    [self getOhter];
    [self handle];
}
-(void)handle{
}
- (void)getOhter{
    LC_WEAK_SELF
    self.otherPost = ^(__unsafe_unretained Class modelClass, NSString *api, NSDictionary *params, void (^result)(id data, id oj)) {
        if (api == nil) api = [modelClass api];
        
        [LCNetWorkTool postWithUrlStr:api parameters:params reqSuccess:^(NSString *urlStr, NSDictionary *dic, NSString *json, NSDictionary *params) {
            [dic success:^{
                BaseModel *model =  [modelClass modelWithDictionary:dic];
                if (result) result(model,weakSelf);
            }faild:^{
                if (DEBUG) {
                    printf("\n类: <%p %s:(%d) >\n方法: %s \n%s\n", weakSelf, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:@"报错信息%@\n报错参数%@\n接口:%@",dic,params,urlStr] UTF8String]);
                }
            }];
        } reqFail:^(NSString *urlStr, NSError *error, NSDictionary *params) {
            
        }];
    };
    self.uidPost = ^(__unsafe_unretained Class modelClass, void (^result)(id data, id oj)) {
        weakSelf.otherPost(modelClass, [modelClass api], @{@"uid":UID()}, result);
    };
    self.nilApiPost = ^(__unsafe_unretained Class modelClass, NSDictionary *params, void (^result)(id data, id oj)) {
        weakSelf.otherPost(modelClass, [modelClass api], params, result);
    };
}
__kindof BaseView *LCLoadNib(NSString *nibName){
    return [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil].firstObject;
}

- (IBAction)remove{
    [self removeFromSuperview];
}
@end
