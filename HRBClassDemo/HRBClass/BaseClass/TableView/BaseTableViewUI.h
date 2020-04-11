//
//  BaseTableViewUI.h
//  FrameWork
//
//  Created by SZJ on 2020/3/15.
//  Copyright © 2020 SZJ. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BaseModel;






NS_ASSUME_NONNULL_BEGIN

@interface TableViewLeftSlideAction : NSObject

@property (readonly) NSString * t_title;
@property (readonly) UIColor * t_backColor;
@property (readonly) UIImage *t_backImage;
@property (readonly) void(^t_result)(NSIndexPath *indexPath);

/*
  初始化
 */
+ (instancetype)action;
/*
  设置标题
 */
- (TableViewLeftSlideAction *(^)(NSString *title))title;
/*
  设置背景颜色
 */
- (TableViewLeftSlideAction *(^)(UIColor *backColor))backColor;
/*
  设置背景图片
 */
- (TableViewLeftSlideAction *(^)(UIImage *backImage))backImage;
/*
  回调
 */
- (TableViewLeftSlideAction *(^)(void(^result)(NSIndexPath *indexPath)))result;
@end


@interface BaseTableViewUI : NSObject

/*
  数据
 */
@property (nonatomic,strong) BaseModel * model;
/*
 section个数
 */
@property (nonatomic,assign) NSInteger sectionCount;
/*
 row个数
 */
@property (nonatomic,assign) NSInteger rowsCount;

/*
  cell类的数组 @[@[@""]]   section[row[cell]]
 */
@property (nonatomic,strong) NSArray <NSArray <NSString *>*> *classArr;
/*
   header 类 和  footer类
 */
@property (nonatomic,strong) NSArray<NSString *> * viewClassForSectionFooterHeader;
/*
  如果只是单纯想要section之间加点缝隙 就设置这个
 */
@property (nonatomic,assign) CGFloat headerHeight;
/*
  如果只是单纯想要section之间加点缝隙 就设置这个
*/
@property (nonatomic,assign) CGFloat footerHeight;
/*
  header的model
 */
@property (nonatomic,strong) BaseModel * headerModel;
/*
  footer的model
*/
@property (nonatomic,strong) BaseModel *footerModel;
/*
  不想放header的section
 */
@property (nonatomic,strong) NSArray <NSNumber *> * noHeaderSections;
/*
  不想放footer的section
*/
@property (nonatomic,strong) NSArray <NSNumber *> * noFooterSections;
/*
  tableviewCell点击事件
 */
@property (nonatomic,copy) void(^tableViewSelectAtIndex)(NSIndexPath *indexpath,id oj);
/*
  获取 左滑事件
 */
- (NSMutableArray <TableViewLeftSlideAction *>*)getActions;
/*
  创建 左滑事件
 */
- (void)makeLeftSlideActions:(void(^)(NSMutableArray <TableViewLeftSlideAction *>*action))actions;
@end

NS_ASSUME_NONNULL_END
