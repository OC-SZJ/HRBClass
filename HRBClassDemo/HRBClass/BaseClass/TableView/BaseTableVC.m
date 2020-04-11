//
//  BaseTableVC.m
//  ocCrazy
//
//  Created by mac on 2018/7/3.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaseTableVC.h"

#import "UITableView+Tool.h"
#import <objc/runtime.h>

#import "BaseTableVC+Tool.h"
#import "BaseModel.h"
#import "LCNetWorkTool.h"
typedef NS_ENUM(NSInteger, BaseTableVCError) {
    BaseTableVCErrorDelegate = 0,
    BaseTableVCErrorDataSource = 1,
    BaseTableVCErrorTableViewInterface,
};

@interface BaseTableVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,assign) BOOL arff;
@end

@implementation BaseTableVC



- (void)viewDidLoad {
    self.page = 1;
    [super viewDidLoad];
    
    if (!self.tableView.delegate ) [self DebugLog:BaseTableVCErrorDelegate];
    if (!self.tableView.dataSource) [self DebugLog:BaseTableVCErrorDataSource];
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    [self.tableView isGroup];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
}

- (void)needHeadRefresh{
    LC_WEAK_SELF
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf repeatGetData];
    }];
}

- (void)getData{
    LC_WEAK_SELF
    
    BaseParams *p = BaseParams.new;
    BOOL n = NO;
    if (self.autoPost) {
        n = YES;
        self.autoPost(p,self);
    }
    if (self.autoRefrehPost) {
        n = YES;
        self.autoRefrehPost(p,self);
        [self needRefresh];
        p.params[@"page"] = @(self.page);
    }
    if (self.autoUIDPost) {
        n = YES;
        self.autoUIDPost(p,self);
        p.params[@"id"] = UID();
    }
    if (self.autoRefrehUIDPost) {
        n = YES;
        self.autoRefrehUIDPost(p,self);
        [self needRefresh];
        p.params[@"page"] = @(self.page);
    }
    if (!n) return;
    if (!p.api)p.api = [p.modelClass api];
    [LCNetWorkTool post:p.api parameters:p.params reqSuccess:^(NSString *urlStr, NSDictionary *dic, NSString *json, NSDictionary *params) {
        [dic success:^{
            BaseModel *model =  [p.modelClass modelWithDictionary:dic];
            if (weakSelf.page == 1)[weakSelf.dataSource.dataSource removeAllObjects];
            if (model.modelArr) {
                for (__kindof BaseModel *m in model.modelArr) {
                    [weakSelf.dataSource.dataSource addObject:m];
                }
            }
            if (p.result) p.result(model,weakSelf);
            [weakSelf.tableView cc_endReFresh:model.modelArr];
        }faild:^{
            if (DEBUG) {
                printf("\n类: <%p %s:(%d) >\n方法: %s \n%s\n", weakSelf, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:@"报错信息%@\n报错参数%@\n接口:%@",dic,params,urlStr] UTF8String]);
            }
        }];
    } reqFail:^(NSString *urlStr, NSError *error, NSDictionary *params) {
        
    }];
    
}
- (void)needRefresh{
    if (self.arff)return;
    LC_WEAK_SELF
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf repeatGetData];
    }];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page++;
        [self getData];
    }];
    self.arff = YES;
}


- (void)repeatGetData{
    self.page = 1;
    [self getData];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self countSection];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self countRow:section];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self getCell:indexPath];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self cellHeight:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return [self footerHeight:section];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [self headerHeight:section];
}



-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [self footer:section];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [self header:section];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self selectAtIndex:indexPath];
}

- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath*)indexPath {
    return [self leftSlideAction:indexPath];
}

- ( UISwipeActionsConfiguration *)tableView:(UITableView *)tableView trailingSwipeActionsConfigurationForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *a = [self leftSlideAction:indexPath];
    if (a) {
        UISwipeActionsConfiguration *config = [UISwipeActionsConfiguration configurationWithActions:a];
        return config;
    }
    return nil;
}

-(BaseDataSource *)dataSource{
    if (!_dataSource) {
        _dataSource = BaseDataSource.new;
    }
    return _dataSource;
}

- (void)DebugLog:(BaseTableVCError)error{
    if (DEBUG) {
        switch (error) {
            case BaseTableVCErrorDelegate:
                NSLog(@"\n ⚠️⚠️⚠️ \n %@ 这个类的tableView 没有设置delegate",[self class]);
                break;
            case BaseTableVCErrorDataSource:
                NSLog(@"\n ⚠️⚠️⚠️ \n %@ 这个类的tableView 没有设置dataSource",[self class]);
                break;
            case BaseTableVCErrorTableViewInterface:
                NSLog(@"\n ⚠️⚠️⚠️ \n %@ 这个类的tableViewInterface 没有设置\n tableViewInterface  需要设置在[super viewDidLoad]前",[self class]);
                break;
            default:
                break;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
