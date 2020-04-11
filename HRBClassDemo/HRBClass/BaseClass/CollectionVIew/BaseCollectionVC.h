//
//  BaseCollectionVC.h
//  ocCrazy
//
//  Created by mac on 2018/7/4.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseDataSource.h"
#import "BaseCollectionViewUI.h"
#import "BaseCollectionReusableView.h"

@class BaseModel;
@class BaseCollectionViewUI;

@interface BaseCollectionVC : BaseViewController

@property (nonatomic,weak) IBOutlet UICollectionView * collectionView;

@property (nonatomic,weak) IBOutlet UICollectionViewFlowLayout * flowLayout;
/*
  有刷新网络请求调用 参数自动添加page 不需要手动添加
 */
@property (nonatomic,copy) void(^autoRefrehPost)(BaseParams *prm,id oj);
/*
  有刷新网络请求调用 参数自动添加page,uid 不需要手动添加
 */
@property (nonatomic,copy) void(^autoRefrehUIDPost)(BaseParams *prm,id oj) ;

/*
  事件回调  包括 cell header footer
 */
@property (nonatomic,strong) void(^collectionViewEvent)(id key,id value,int intValue);
/*
  数据源 (可设置 header footer)
 */
@property (nonatomic,strong) BaseDataSource * dataSource;

/*
  collectionView界面的一些参数 具体查看 BaseCollectionViewUI 类
 */
@property (nonatomic,copy) void(^collectionViewUI)(BaseCollectionViewUI *collectionViewUI,NSIndexPath * indexPath,id oj);




- (void)needHeadRefresh;

- (void)repeatGetData;

@end
