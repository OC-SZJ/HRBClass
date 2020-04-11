//
//  ImagePickerSelectView.h
//  JadeShop
//
//  Created by mac on 2019/3/4.
//  Copyright © 2019年 SZJ.test. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImagePickerSelectView : UIView<CAAnimationDelegate>
-(void)setText:(NSString *)text;
- (void)scaleAnimation:(void(^)(void))finish;
- (BOOL)isSelect;
@end
