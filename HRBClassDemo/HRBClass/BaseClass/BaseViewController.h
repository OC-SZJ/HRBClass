

#import <UIKit/UIKit.h>

#import "UITableView+Tool.h"
#import "BaseParams.h"
#import "LCNetWorkTool.h"

#import "MJRefresh.h"


@class BaseNavigationController;

@interface BaseViewController : UIViewController

/*
  导航栏是否隐藏
 */
@property (nonatomic,assign) BOOL hidNav;


/*
 隐藏导航栏的VC初始化
 */
+ (instancetype)hidNavNew;

/*
   可以刷新上一页的回调
 */
@property (nonatomic,copy) void(^refreshPopVC)(id data);

/*
  view 加载完 的回调
 */
@property (nonatomic,copy) void(^loadFinish)(id data);

/*
  分页时候用的page
 */
@property (nonatomic,assign) NSInteger page;
/*
  网络请求实现 (主请求,会自动调用)
  重点:block = ^{
 
  }
 */
@property (nonatomic,copy) void(^autoPost)(BaseParams *prm,id oj) ;
/*
  网络请求实现 (主请求,会自动调用,参数默认添加UID)
  重点:block = ^{
 
  }
 */
@property (nonatomic,copy) void(^autoUIDPost)(BaseParams *prm,id oj) ;
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
/*
  网络请求实现 (没有model 就想看看返回值 是成功还是失败)
  重点: block(xx,xx,xx)
 */
@property (nonatomic,copy) void(^resultPost)(NSString *api,NSDictionary *params,void(^result)(BOOL success, id oj));

/*
  执行 view 加载完 的回调
 */
- (void)doLoadFinish;
/*
  执行 view 加载完 的回调 并释放
 */
- (void)doLoadFinishWithRelease;
/*
  返回到第几页
 */
- (void)popToIndex:(NSInteger)index;

/*
  创建一个需要present的 导航栏
 */
+ (BaseNavigationController *)shareForPresent;

/*
  返回并刷新上一页
 */
- (void)popWithData:(id )data;
/*
   vc的起始方法
 */
- (void)handle:(__kindof BaseViewController *)oj;
/*
  返回键的方法  可以在xib中  直接设置
 */
- (IBAction)backUpRootView;
/*
 pushVC  的时候 方法
 */
- (void)pushVC:(BaseViewController *)vc;

/*
 添加 导航栏 右侧按钮
 */
- (void)addRightBarItemWithData:(id)data withEvent:(void(^)(id thisObject,UITabBarItem *item))event;
/*
 添加 导航栏 左侧按钮
 */
- (void)addLeftBarItemWithData:(id)data withSEL:(SEL)sel;


NSString *GetClassStr(NSArray <NSArray <NSString *> *> * arr , NSIndexPath *indexPath);

NSArray <NSString *> * CellArr(NSArray <NSArray <NSString *> *> * arr);

/*
  判断 两个字符串 是否相等
 */
BOOL StrEQ(NSString *key,NSString *keys);

/*
 设置那种  背景是渐变色的按钮的
 */
- (void)setButtonState:(UIButton *)button;
/*
  全局时间通知回调
 */
- (void)getCurrentTimeNotication:(NSNotification *)notication;
/*
  重新获取数据
 */
- (void)repeatGetData;
@end
