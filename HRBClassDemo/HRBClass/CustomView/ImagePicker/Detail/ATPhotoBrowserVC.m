//
//  ATPhotoBrowserVC.m
//  ATPhotoBrowser
//
//  Created by mac on 2019/11/22.
//  Copyright © 2019 mac. All rights reserved.
//

#import "ATPhotoBrowserVC.h"
#import "AtPhotoCell.h"
#import <Photos/Photos.h>
#import "ImageModel.h"
@interface ATPhotoBrowserVC ()<UICollectionViewDelegate ,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectV;
@property (nonatomic, strong) PHCachingImageManager * imageManager ;
@property (nonatomic,strong) PHImageRequestOptions * requestOptions;
@end

@implementation ATPhotoBrowserVC

- (void)viewDidLoad {
    [super viewDidLoad];
     _imageManager = [[PHCachingImageManager alloc] init];
    _requestOptions = [[PHImageRequestOptions alloc] init];
     _requestOptions.synchronous = YES;
     _requestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
     _requestOptions.networkAccessAllowed = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    UICollectionViewFlowLayout *fl = [[UICollectionViewFlowLayout alloc]init];
   
    fl.minimumInteritemSpacing = 0;
    fl.minimumLineSpacing = 0;
    fl.itemSize  = self.view.frame.size;
    fl.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectV = [[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:fl];
    _collectV.backgroundView.backgroundColor = [UIColor whiteColor];
    _collectV.delegate = self;
    _collectV.dataSource = self;
    [_collectV registerClass:[AtPhotoCell class] forCellWithReuseIdentifier:@"atcell"];
    _collectV.pagingEnabled = YES;
     [self.view addSubview:_collectV];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark -dataSouce
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AtPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"atcell" forIndexPath:indexPath];
    ImageModel *model = self.imageArr[indexPath.item];
    cell.representedAssetIdentifier = model.asset.localIdentifier;
    
    [_imageManager requestImageForAsset:model.asset targetSize:CGSizeMake(YYScreenWidth(), YYScreenWidth() * model.asset.pixelHeight / model.asset.pixelWidth) contentMode:PHImageContentModeDefault options:_requestOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
               if ([cell.representedAssetIdentifier isEqualToString:model.asset.localIdentifier]) {
                    [cell setCellWithImage:result];
               }
    }];
  
    return cell;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageArr.count;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    [self.collectV reloadData];
}

@end
