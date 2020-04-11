//
//  ImagePickerView.m
//  ocCrazy
//
//  Created by mac on 2018/4/25.
//  Copyright © 2018年 dukai. All rights reserved.
//

#import "ImagePickerVC.h"
#import "ImagePickerImgCell.h"
#import "ImagePickerVideoCell.h"

#import "ATPhotoBrowserVC.h"
#import "VideoDetailVC.h"
#import "Tool.h"

@interface ImagePickerVC ()<UICollectionViewDelegate,UICollectionViewDataSource>



@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (weak, nonatomic) IBOutlet UIButton *finishiBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *navHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomHeight;



@property (nonatomic,strong) NSMutableArray * dataSource;

@property (nonatomic,strong) NSString * key;

@property (nonatomic,assign) NSInteger imageMax;

@property (nonatomic,assign) NSInteger maxIndex;

@property (nonatomic,copy) void(^callBack)(NSArray *data);

@property (nonatomic,strong) PHCachingImageManager * imageManager;

@property (nonatomic,strong) PHImageRequestOptions * requestOptions;

@property (nonatomic,strong) PHVideoRequestOptions * videoOptions;

@property (nonatomic,strong) PHFetchResult<PHAsset *> * assets;

@property (nonatomic,assign) CGSize trueSize;

@property (nonatomic,assign) CGRect  previousPreheatRect;

@property (nonatomic,assign) LCImageChooseType type;


@property (nonatomic,strong) NSMutableArray * imageArr;
@end

@implementation ImagePickerVC

+ (void)shareWithKey:(NSString *)key withImageMax:(NSInteger)imageMax withCallBack:(void(^)(NSArray *data))callBack withType:(LCImageChooseType)type{
   
    ImagePickerVC *vc = [[ImagePickerVC alloc] init];
    vc.key = key;
    vc.imageMax = imageMax;
    vc.callBack = callBack;
    vc.type = type;
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:vc];
    nvc.modalPresentationStyle = 0;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nvc animated:YES completion:nil];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;

}





- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    _imageManager = [[PHCachingImageManager alloc] init];
    _requestOptions = [[PHImageRequestOptions alloc] init];
    _requestOptions.synchronous = YES;
    _requestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeFastFormat;
    _requestOptions.networkAccessAllowed = YES;
    
    
    _videoOptions = [[PHVideoRequestOptions alloc] init];
    _videoOptions.version = PHVideoRequestOptionsVersionOriginal;
    _videoOptions.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
    _videoOptions.networkAccessAllowed = YES;
    
    
    
    _navHeight.constant = X_NAV(64);
    _bottomHeight.constant = X_TABBAR(49);
    self.dataSource = [NSMutableArray array];
    self.imageArr = [NSMutableArray array];
    if (!self.imageMax) {
        self.imageMax = 9;
    }
    [self UI];
   
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self getThumbnailImages];
                });
            }else {
                
            }
        }];
    });
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reload) name:@"needReload" object:nil];
    
    [_imageManager stopCachingImagesForAllAssets];
    _previousPreheatRect = CGRectZero;
    
}

- (void)reload{
    BOOL canSelect = self.maxIndex == self.imageMax;
    for (UIView *subView in _collectionView.subviews) {
        if ([subView isKindOfClass:[ImagePickerImgCell class]]) {
            [(ImagePickerImgCell *)subView setCanSelect:canSelect];
            [(ImagePickerImgCell *)subView setModel:[(ImagePickerImgCell *)subView model]];
        }
    }
}

- (void)UI{
    self.finishiBtn.cornerRadiusNum = 5;
    _trueSize = CGSizeMake((YYScreenWidth() - 12) / 4 * YYScreenScale(), (YYScreenWidth() - 12) / 4* YYScreenScale());
    self.flowLayout.itemSize = CGSizeMake((YYScreenWidth() - 6) / 4, (YYScreenWidth() - 6) / 4);
    self.flowLayout.headerReferenceSize = CGSizeMake(YYScreenWidth(), X_NAV(64));
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ImagePickerImgCell" bundle:nil] forCellWithReuseIdentifier:@"cellImg"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"ImagePickerVideoCell" bundle:nil] forCellWithReuseIdentifier:@"cellVideo"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark --- collectionView ---


// 设置headerView和footerView的
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        reusableView = header;
        reusableView.backgroundColor = [UIColor whiteColor];
    }

    return reusableView;
}



-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.dataSource.count;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
     ImageModel *model = self.dataSource[indexPath.item];
    if (model.isVideo) {
        VideoDetailVC *vc = [[VideoDetailVC alloc] init];
        vc.model = model;
        vc.isThis = ^{
            self.callBack(@[model.videoUrl]);
            [self.navigationController popToRootViewControllerAnimated:NO];
            [self.navigationController dismissViewControllerAnimated:YES completion:nil];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }else{
    
       
        ATPhotoBrowserVC *vc = [[ATPhotoBrowserVC alloc] init];
        vc.imageArr = self.imageArr;
        vc.index = indexPath.item;
        [self.navigationController pushViewController:vc animated:YES];
    }

    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
   
    
    ImageModel *model = self.dataSource[indexPath.item];
    
    if (model.isVideo) {
        
        ImagePickerVideoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellVideo" forIndexPath:indexPath];
        
        [[PHImageManager defaultManager] requestAVAssetForVideo:model.asset options:_videoOptions resultHandler:^(AVAsset * _Nullable aasset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
            if (aasset) {
                AVURLAsset *urlAsset = (AVURLAsset *)aasset;
                UIImage *firstImg = [self getScreenShotImageFromVideoPath:urlAsset];
                float time = [self getVideoTime:urlAsset];
                dispatch_async(dispatch_get_main_queue(), ^{
                    model.time = time;
                    model.thumImage = firstImg;
                    model.videoUrl = urlAsset.URL.absoluteString;
                    cell.model = model;
                });
            }
        }];
        
        
        return cell;
        
        
    }else{
        ImagePickerImgCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellImg" forIndexPath:indexPath];
        cell.representedAssetIdentifier = model.asset.localIdentifier;
        [cell setCanSelect:self.maxIndex == self.imageMax];
        [cell setModel:model];
       
        [_imageManager requestImageForAsset:model.asset targetSize:CGSizeMake((YYScreenWidth() - 12) / 4, ((YYScreenWidth() - 12) / 4) * model.asset.pixelHeight / model.asset.pixelWidth) contentMode:PHImageContentModeDefault options:_requestOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            if ([cell.representedAssetIdentifier isEqualToString:model.asset.localIdentifier]) {
                cell.aImage.image = result;
            }
        }];
        
        @weakify(self)
        cell.block = ^(BOOL select,ImageModel *cellModel){
            @strongify(self)

            if (select) {
                cellModel.indexOfSelect = ++self.maxIndex;
            }else{
                for (ImageModel *selectModel in self.dataSource) {
                    if (selectModel.indexOfSelect > cellModel.indexOfSelect) {
                        selectModel.indexOfSelect -= 1;
                    }
                }
                cellModel.indexOfSelect = 0;
                self.maxIndex--;
               
            }
            [self imageArrChange];
            
        };
            return cell;
    }

   
}

- (void)imageArrChange{
    BOOL haveSelect = self.maxIndex != 0;
    self.finishiBtn.userInteractionEnabled = haveSelect;
    self.finishiBtn.alpha = haveSelect ? 1 : 0.5;
    [self.finishiBtn setTitle: haveSelect ? [NSString stringWithFormat:@"完成(%ld)", self.maxIndex] : @"完成" forState:UIControlStateNormal];
}

- (void)getThumbnailImages
{
    /*.
    enum PHAssetCollectionType : Int {
         case Album //从 iTunes 同步来的相册，以及用户在 Photos 中自己建立的相册
         case SmartAlbum //经由相机得来的相册
         case Moment //Photos 为我们自动生成的时间分组的相册
    }
    
    enum PHAssetCollectionSubtype : Int {
         case AlbumRegular //用户在 Photos 中创建的相册，也就是我所谓的逻辑相册
         case AlbumSyncedEvent //使用 iTunes 从 Photos 照片库或者 iPhoto 照片库同步过来的事件。然而，在iTunes 12 以及iOS 9.0 beta4上，选用该类型没法获取同步的事件相册，而必须使用AlbumSyncedAlbum。
         case AlbumSyncedFaces //使用 iTunes 从 Photos 照片库或者 iPhoto 照片库同步的人物相册。
         case AlbumSyncedAlbum //做了 AlbumSyncedEvent 应该做的事
         case AlbumImported //从相机或是外部存储导入的相册，完全没有这方面的使用经验，没法验证。
         case AlbumMyPhotoStream //用户的 iCloud 照片流
         case AlbumCloudShared //用户使用 iCloud 共享的相册
         case SmartAlbumGeneric //文档解释为非特殊类型的相册，主要包括从 iPhoto 同步过来的相册。由于本人的 iPhoto 已被 Photos 替代，无法验证。不过，在我的 iPad mini 上是无法获取的，而下面类型的相册，尽管没有包含照片或视频，但能够获取到。
         case SmartAlbumPanoramas //相机拍摄的全景照片
         case SmartAlbumVideos //相机拍摄的视频
         case SmartAlbumFavorites //收藏文件夹
         case SmartAlbumTimelapses //延时视频文件夹，同时也会出现在视频文件夹中
         case SmartAlbumAllHidden //包含隐藏照片或视频的文件夹
         case SmartAlbumRecentlyAdded //相机近期拍摄的照片或视频
         case SmartAlbumBursts //连拍模式拍摄的照片，在 iPad mini 上按住快门不放就可以了，但是照片依然没有存放在这个文件夹下，而是在相机相册里。
         case SmartAlbumSlomoVideos //Slomo 是 slow motion 的缩写，高速摄影慢动作解析，在该模式下，iOS 设备以120帧拍摄。不过我的 iPad mini 不支持，没法验证。
         case SmartAlbumUserLibrary //这个命名最神奇了，就是相机相册，所有相机拍摄的照片或视频都会出现在该相册中，而且使用其他应用保存的照片也会出现在这里。
         case Any //包含所有类型
    }
     */

    PHAssetCollection *cameraRoll = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].firstObject;
   
    
    PHFetchOptions *fetchOptions = [PHFetchOptions new];
    fetchOptions.sortDescriptors = @[
                                     [NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO],
                                     ];
      
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:cameraRoll options:fetchOptions];
    for (PHAsset *asset in assets) {
        ImageModel *model = [[ImageModel alloc] init];
//        model.thumImage = result;
        model.asset = asset;
        model.isVideo = asset.mediaType == PHAssetMediaTypeVideo;
        if (self.type == LCImageChooseType_Video && asset.mediaType == PHAssetMediaTypeVideo) {
            [self.dataSource addObject:model];
        }
        
        if (self.type == LCImageChooseType_Image && asset.mediaType == PHAssetMediaTypeImage) {
            [self.dataSource addObject:model];
        }
        
        if (self.type == LCImageChooseType_VideoImage) {
            [self.dataSource addObject:model];
        }
        if (asset.mediaType == PHAssetMediaTypeImage) {
            [self.imageArr addObject:model];
        }
    }

    [self.collectionView reloadData];
//     [self enumerateAssetsInAssetCollection:cameraRoll];

}


#pragma mark --- UIScrollViewDelegate ---


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self updateCachedAssets];
}

- (void)updateCachedAssets
{
    if (!self.isViewLoaded || self.view.window == nil) {
        return;
    }
    
    // 预热区域 preheatRect 是 可见区域 visibleRect 的两倍高
    CGRect visibleRect = CGRectMake(0.f, self.collectionView.contentOffset.y, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    CGRect preheatRect = CGRectInset(visibleRect, 0, -0.5*visibleRect.size.height);
    
    // 只有当可见区域与最后一个预热区域显著不同时才更新
    CGFloat delta = fabs(CGRectGetMidY(preheatRect) - CGRectGetMidY(_previousPreheatRect));
    if (delta > self.view.bounds.size.height / 3.f) {
        // 计算开始缓存和停止缓存的区域
        [self computeDifferenceBetweenRect:_previousPreheatRect andRect:preheatRect removedHandler:^(CGRect removedRect) {
            [self imageManagerStopCachingImagesWithRect:removedRect];
        } addedHandler:^(CGRect addedRect) {
            [self imageManagerStartCachingImagesWithRect:addedRect];
        }];
        _previousPreheatRect = preheatRect;
    }
}
- (void)computeDifferenceBetweenRect:(CGRect)oldRect andRect:(CGRect)newRect removedHandler:(void (^)(CGRect removedRect))removedHandler addedHandler:(void (^)(CGRect addedRect))addedHandler
{
    if (CGRectIntersectsRect(newRect, oldRect)) {
        CGFloat oldMaxY = CGRectGetMaxY(oldRect);
        CGFloat oldMinY = CGRectGetMinY(oldRect);
        CGFloat newMaxY = CGRectGetMaxY(newRect);
        CGFloat newMinY = CGRectGetMinY(newRect);
        //添加 向下滑动时 newRect 除去与 oldRect 相交部分的区域（即：屏幕外底部的预热区域）
        if (newMaxY > oldMaxY) {
            CGRect rectToAdd = CGRectMake(newRect.origin.x, oldMaxY, newRect.size.width, (newMaxY - oldMaxY));
            addedHandler(rectToAdd);
        }
        //添加 向上滑动时 newRect 除去与 oldRect 相交部分的区域（即：屏幕外底部的预热区域）
        if (oldMinY > newMinY) {
            CGRect rectToAdd = CGRectMake(newRect.origin.x, newMinY, newRect.size.width, (oldMinY - newMinY));
            addedHandler(rectToAdd);
        }
        //移除 向上滑动时 oldRect 除去与 newRect 相交部分的区域（即：屏幕外底部的预热区域）
        if (newMaxY < oldMaxY) {
            CGRect rectToRemove = CGRectMake(newRect.origin.x, newMaxY, newRect.size.width, (oldMaxY - newMaxY));
            removedHandler(rectToRemove);
        }
        //移除 向下滑动时 oldRect 除去与 newRect 相交部分的区域（即：屏幕外顶部的预热区域）
        if (oldMinY < newMinY) {
            CGRect rectToRemove = CGRectMake(newRect.origin.x, oldMinY, newRect.size.width, (newMinY - oldMinY));
            removedHandler(rectToRemove);
        }
    }
    else {
        //当 oldRect 与 newRect 没有相交区域时
        addedHandler(newRect);
        removedHandler(oldRect);
    }
}
- (void)imageManagerStartCachingImagesWithRect:(CGRect)rect
{
    NSMutableArray<PHAsset *> *addAssets = [self indexPathsForElementsWithRect:rect];
    [_imageManager startCachingImagesForAssets:addAssets targetSize:_trueSize contentMode:PHImageContentModeAspectFill options: _requestOptions];
}

- (void)imageManagerStopCachingImagesWithRect:(CGRect)rect
{
    NSMutableArray<PHAsset *> *removeAssets = [self indexPathsForElementsWithRect:rect];
    [_imageManager stopCachingImagesForAssets:removeAssets targetSize:_trueSize contentMode:PHImageContentModeAspectFill options:_requestOptions];
}

- (NSMutableArray<PHAsset *> *)indexPathsForElementsWithRect:(CGRect)rect
{
    UICollectionViewLayout *layout = self.collectionView.collectionViewLayout;
    NSArray<__kindof UICollectionViewLayoutAttributes *> *layoutAttributes = [layout layoutAttributesForElementsInRect:rect];
    NSMutableArray<PHAsset *> *assets = [NSMutableArray array];
    for (__kindof UICollectionViewLayoutAttributes *layoutAttr in layoutAttributes) {
        NSIndexPath *indexPath = layoutAttr.indexPath;
        ImageModel *model =  [self.dataSource objectAtIndex:indexPath.item];
        PHAsset *asset = model.asset;
        [assets addObject:asset];
    }
    return assets;
}

#pragma mark --- 获取图片资源 ---
- (void)enumerateAssetsInAssetCollection:(PHAssetCollection *)assetCollection
{
//
//    PHImageRequestOptions *imageOptions = [[PHImageRequestOptions alloc] init];
//    imageOptions.synchronous = YES;
//    imageOptions.deliveryMode = PHImageRequestOptionsDeliveryModeFastFormat;
//    imageOptions.networkAccessAllowed = YES;
//
//    PHVideoRequestOptions* videoOptions = [[PHVideoRequestOptions alloc] init];
//    videoOptions.version = PHVideoRequestOptionsVersionOriginal;
//    videoOptions.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
//    videoOptions.networkAccessAllowed = YES;
//
//
//
//    dispatch_group_t group = dispatch_group_create();
//
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        for (PHAsset *asset in assets) {
//             dispatch_group_enter(group);
//            if (asset.mediaType == PHAssetMediaTypeImage) {
//                [_imageManager requestImageForAsset:asset targetSize:CGSizeMake((YYScreenWidth() - 12) / 4, ((YYScreenWidth() - 12) / 4) * asset.pixelHeight / asset.pixelWidth) contentMode:PHImageContentModeDefault options:imageOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
//                    if (result) {
//                        ImageModel *model = [[ImageModel alloc] init];
//                        model.thumImage = result;
//                        model.asset = asset;
//                        model.isVideo = NO;
//                        [self addDat:model];
//                    }
//                    dispatch_group_leave(group);
//
//                }];
//            }else if(asset.mediaType == PHAssetMediaTypeVideo) {
//

//            }else{
//                dispatch_group_leave(group);
//                continue;
//            }
//        }
//        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//            NSLog(@"3");
//            [self.collectionView reloadData];
////            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:(self.dataSource.count - 1) inSection:0];
////            if (indexPath.row >= 0) {
////                [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
////            }
//        });
//    });
//
//
    
    
    
}




- (IBAction)finishiBtnAction:(UIButton *)sender {
    NSMutableArray *arr = [NSMutableArray array];
    for (ImageModel *model in self.dataSource) {
        if (model.indexOfSelect > 0) {
            PHImageRequestOptions *imageOptions = [[PHImageRequestOptions alloc] init];
            imageOptions.synchronous = YES;
            imageOptions.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
            imageOptions.networkAccessAllowed = YES;
            [[PHImageManager defaultManager] requestImageForAsset:model.asset targetSize:CGSizeMake(model.asset.pixelWidth, model.asset.pixelWidth) contentMode:PHImageContentModeDefault options:imageOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                if (result) {
                    [arr addObject:result];
                }
            }];
        }
    }
    if (_callBack) {
        _callBack(arr);
    }
     [self.collectionView removeFromSuperview];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)backAction:(UIButton *)sender {
     [self.collectionView removeFromSuperview];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (UIImage *)getScreenShotImageFromVideoPath:(AVURLAsset *)asset{
    
    UIImage *shotImage;

    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    
    gen.appliesPreferredTrackTransform = YES;
    
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    
    NSError *error = nil;
    
    CMTime actualTime;
    
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    
    shotImage = [[UIImage alloc] initWithCGImage:image];
    
    CGImageRelease(image);
    
    return shotImage;
    
}

- (float)getVideoTime:(AVURLAsset *)asset{
     CMTime audioDuration=asset.duration;
    float audioDurationSeconds=CMTimeGetSeconds(audioDuration);
    return audioDurationSeconds;
}



@end
