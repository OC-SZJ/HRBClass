

#import <Foundation/Foundation.h>

#import "NSObject+YYModel.h"

#import "NSObject+coder.h"


@interface BaseModel : NSObject<NSCoding>

/*
  这个model 是否选中 常用的属性
 */
@property (nonatomic,assign) BOOL lc_isSelect;
/*
  是不是 头视图 脚视图
 */
@property (nonatomic,assign) BOOL isFooterHeaderView;
/*
  model对应的
 */
+ (NSString *)api;

+ (NSArray <NSString *> *)apis;
/*
 这个model对应的cell类
 */
- (Class)cellClass;
/*
 model里面的数组映射
 */
- (NSArray <BaseModel *>*)modelArr;


@end


