//
//  BaseTableVC.h
//  ocCrazy
//
//  Created by mac on 2018/7/3.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseDataSource.h"
#import "BaseTableViewUI.h"
@class BaseModel;


@interface BaseTableVC : BaseViewController
/*
  可直接在xib中设置
 */
@property (nonatomic,weak) IBOutlet UITableView * tableView;
/*
 tableView的回调  包括 cell headerView  footerView
 */
@property (nonatomic,strong) void(^tableViewEvent)(id key,id value,int intValue);
/*
  有刷新网络请求调用 参数自动添加page 不需要手动添加  自动添加上拉刷新 下拉加载
 */
@property (nonatomic,copy) void(^autoRefrehPost)(BaseParams *prm,id oj) ;
/*
  有刷新网络请求调用 参数自动添加page,uid 不需要手动添加 自动添加上拉刷新 下拉加载
 */
@property (nonatomic,copy) void(^autoRefrehUIDPost)(BaseParams *prm,id oj) ;
/*
  tableview界面的一些参数 具体查看 BaseTableViewUI 类
 */
@property (nonatomic,copy) void(^tableViewUI)(BaseTableViewUI *tableViewUI,NSIndexPath * indexPath,id oj);
/*
   数据源 (包含 头视图 和 脚视图)
 */
@property (nonatomic,strong) BaseDataSource * dataSource;
/*
  当前的数据源 是 临时数据
 */
@property (nonatomic,assign) BOOL fakeData;

/*
  只添加下拉刷新
 */
- (void)needHeadRefresh;
/*
  重新获取数据  页数归1
 */
- (void)repeatGetData;

@end
