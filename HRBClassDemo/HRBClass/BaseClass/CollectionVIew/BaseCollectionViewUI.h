//
//  BaseCollectionViewUI.h
//  FrameWork
//
//  Created by SZJ on 2020/3/16.
//  Copyright © 2020 SZJ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseCollectionViewUI : NSObject
/*
  cell类型
 */
@property (nonatomic,strong) NSArray <NSArray <NSString *> *> *classArr;
/*
  section个数
 */
@property (nonatomic,assign) NSInteger sectionCount;
/*
  item个数
 */
@property (nonatomic,assign) NSInteger itemsCount;

/*
  数据
 */
@property (nonatomic,strong) BaseModel *model;

/*
  header 的 数据
 */
@property (nonatomic,strong) BaseModel *headerModel;
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
   header 类 和  footer类
 */
@property (nonatomic,strong) NSArray<NSString *> * viewClassForSectionFooterHeader;
/*
  如果只是单纯想要section之间加点缝隙 就设置这个
 */
@property (nonatomic,assign) CGSize headerSize;
/*
  如果只是单纯想要section之间加点缝隙 就设置这个
*/
@property (nonatomic,assign) CGSize footerSize;
/*
  tableviewCell点击事件
 */
@property (nonatomic,copy) void(^collectionViewSelectAtIndexPath)(NSIndexPath *indexpath,id oj);
@end

NS_ASSUME_NONNULL_END
