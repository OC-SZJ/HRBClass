//
//  AtPhotoCell.h
//  ATPhotoBrowser
//
//  Created by mac on 2019/11/22.
//  Copyright © 2019 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AtPhotoCell : UICollectionViewCell

-(void)setCellWithImage:(UIImage *)image;

@property (nonatomic,copy) NSString * representedAssetIdentifier;
@end

NS_ASSUME_NONNULL_END
