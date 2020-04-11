//
//  AtPhotoCell.m
//  ATPhotoBrowser
//
//  Created by mac on 2019/11/22.
//  Copyright © 2019 mac. All rights reserved.
//

#import "AtPhotoCell.h"
@interface AtPhotoCell()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrV;
@property (nonatomic, strong) UIImageView *imgV;
@end


@implementation AtPhotoCell
-(void)setCellWithImage:(UIImage *)image{
   _imgV.image = image;
    NSInteger height = (image.size.height*([UIScreen mainScreen].bounds.size.width/image.size.width));
    _imgV.userInteractionEnabled = YES;
    _imgV.center = self.contentView.center;
    _scrV.delegate = self;
    _scrV.contentSize = [UIScreen mainScreen].bounds.size;
    _scrV.center = self.contentView.center;
    _scrV.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    [_scrV setMinimumZoomScale:1];
    [_scrV setMaximumZoomScale:2];
    [_scrV setZoomScale:1 animated:NO];
     [_imgV setFrame:CGRectMake(_scrV.bounds.origin.x, _scrV.center.y-height/2, [UIScreen mainScreen].bounds.size.width, height )];
    [_scrV addSubview:_imgV];
    [self.contentView addSubview:_scrV];
    
}
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
 
    return _imgV;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
         _scrV = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
         _imgV = [[UIImageView alloc]init];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)scrollViewDidZoom:(UIScrollView *)scrollView {
    [_imgV setCenter:CGPointMake(scrollView.center.x, scrollView.center.y)];
}

@end
