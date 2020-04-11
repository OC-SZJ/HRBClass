//
//  BaseCollectionVC+Tool.h
//  FrameWork
//
//  Created by SZJ on 2020/3/16.
//  Copyright © 2020 SZJ. All rights reserved.
//


#import "BaseCollectionViewUI.h"

#import "BaseCollectionVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseCollectionVC (Tool)
- (NSInteger)countSection;
- (NSInteger)countItem:(NSInteger)section;
- (__kindof UICollectionViewCell *)getCell:(NSIndexPath *)indexPath;
- (CGSize)cellSize:(NSIndexPath *)indexPath;
-(UIView *)header:(NSIndexPath *)indexPath;
-(CGSize)headerSize:(NSInteger)section;
-(UIView *)footer:(NSIndexPath *)indexPath;
-(CGSize)footerSize:(NSInteger)section;
-(void)selectAtIndex:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
