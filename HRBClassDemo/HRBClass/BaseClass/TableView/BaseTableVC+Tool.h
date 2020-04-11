//
//  BaseTableVC+Tool.h
//  Test
//
//  Created by mac on 2019/10/15.
//  Copyright © 2019 SZJ. All rights reserved.
//

#import "BaseTableVC.h"
#import "BaseTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface BaseTableVC (Tool)


/*
 计算有多少个section
 */
- (NSInteger)countSection;
/*
 计算有多少个row
 */
- (NSInteger)countRow:(NSInteger)section;
/*
  返回cell
 */
- (__kindof UITableViewCell *)getCell:(NSIndexPath *)indexPath;
/*
 cell高度
 */
- (CGFloat)cellHeight:(NSIndexPath *)indexPath;
/*
  header高度
 */
- (CGFloat)headerHeight:(NSInteger)section;
/*
  footer高度
 */
- (CGFloat)footerHeight:(NSInteger)section;
/*
  header
 */
- (UIView *)header:(NSInteger)section;
/*
  footer
 */
- (UIView *)footer:(NSInteger)section;
/*
  点击
 */
- (void)selectAtIndex:(NSIndexPath *)indexPath;
/*
  左滑事件
 */
- (NSArray <UIContextualAction *> *)leftSlideAction:(NSIndexPath *)indexPath;
@end

NS_ASSUME_NONNULL_END
