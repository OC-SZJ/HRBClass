//
//  CCSelectView.h
//  ocCrazy
//
//  Created by mac on 2018/7/4.
//  Copyright © 2018年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface CCSelectView : UIView
+(instancetype)shareForTitles:(NSArray<NSString *>*)titles withFrame:(CGRect)frame withSetBlock:(void(^)(UIColor **titleColor,UIColor **selectColor,UIFont **normalFont,UIFont **selectFont,bool *canMove))setBlock;

@property (nonatomic,copy)  void(^callBack)(NSInteger index,NSString *title);
@property (nonatomic,copy)  void(^finishCallBack)(NSInteger index,NSString *title);
@property (nonatomic,copy)  BOOL(^clipCallBack)(NSInteger index);

- (void)setTitles:(NSArray <NSString *> *)titles;
- (void)setIndex:(NSInteger)index;
@end


