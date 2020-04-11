//
//  ImagePickerCollectionViewCell.h
//  ocCrazy
//
//  Created by mac on 2018/4/25.
//  Copyright © 2018年 dukai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageModel.h"
@interface ImagePickerImgCell : UICollectionViewCell<CAAnimationDelegate>
@property (nonatomic,copy) void(^block)(BOOL select,ImageModel * cellModel);
@property (nonatomic,strong) ImageModel * model;

@property (weak, nonatomic) IBOutlet UIImageView *aImage;

@property (nonatomic,strong) NSString * representedAssetIdentifier;

- (void)setImage:(UIImage *)image;

- (void)setCount:(NSInteger)count;

- (void)setCanSelect:(BOOL)select;

@end



