//
//  ImagePickerVideoCell.h
//  JadeShop
//
//  Created by mac on 2019/3/4.
//  Copyright © 2019年 SZJ.test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageModel.h"
@interface ImagePickerVideoCell : UICollectionViewCell
@property (nonatomic,strong) ImageModel * model;
@property (weak, nonatomic) IBOutlet UIImageView *aImage;

@end
