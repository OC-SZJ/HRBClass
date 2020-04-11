//
//  BaseCollectionVC.m
//  ocCrazy
//
//  Created by mac on 2018/7/4.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "BaseCollectionVC.h"

#import "UICollectionView+Tool.h"
#import "BaseCollectionVC+Tool.h"
#import "BaseCollectionViewCell.h"

#import "LCLeftLayout.h"
@interface BaseCollectionVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSInteger _page;
}
@property (nonatomic,strong) NSArray <NSArray <NSString *> *> * classStrArr;
@property (nonatomic,strong) NSArray <NSString *> * headerAndFooterArr;
@property (nonatomic,assign) BOOL arff;
@end

@implementation BaseCollectionVC



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    if (![self.flowLayout isKindOfClass:LCLeftLayout.class]) {
        self.flowLayout.minimumLineSpacing = 0;
        self.flowLayout.minimumInteritemSpacing = 0;
        self.flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    [self repeatGetData];
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
            for (__kindof BaseModel *m in model.modelArr) {
                [weakSelf.dataSource.dataSource addObject:m];
            }
            [weakSelf.collectionView cc_endReFresh:model.modelArr];
            if (p.result) p.result(model,weakSelf);
        }faild:^{
            if (DEBUG) {
                printf("\n类: <%p %s:(%d) >\n方法: %s \n%s\n", weakSelf, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:@"报错信息%@\n报错参数%@\n接口:%@",dic,params,urlStr] UTF8String]);
            }
        }];
    } reqFail:^(NSString *urlStr, NSError *error, NSDictionary *params) {
        
    }];
    
}
- (void)repeatGetData{
    self.page = 1;
    [self getData];
}


- (void)needRefresh{
    LC_WEAK_SELF
    if (self.arff)return;
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf repeatGetData];
    }];
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakSelf.page++;
        [weakSelf getData];
    }];
    self.arff = YES;
}
- (void)needHeadRefresh{
    LC_WEAK_SELF
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf repeatGetData];
    }];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [self getCell:indexPath];
}

- (CGSize )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [self cellSize:indexPath];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return [self countSection];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self countItem:section];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [self selectAtIndex:indexPath];
    
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableview = nil;
    
   
    if (StrEQ(kind, UICollectionElementKindSectionHeader)){
        [self header:indexPath];
    }else{
        [self footer:indexPath];
    }
    
    return reusableview;
}

-(CGSize)collectionView: (UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection: (NSInteger)section{
    return [self headerSize:section];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return [self footerSize:section];
}

-(BaseDataSource *)dataSource{
    if (!_dataSource) {
        _dataSource = BaseDataSource.new;
    }
    return _dataSource;
}

@end
