//
//  BaseTableVCDataSource.h
//  FrameWork
//
//  Created by SZJ on 2020/3/14.
//  Copyright © 2020 SZJ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseDataSource : NSObject
@property (nonatomic,copy) NSString * headerClass;
@property (nonatomic,copy) NSString * footerClass;

@property (nonatomic,strong) NSArray <NSNumber *> *noHeader;
@property (nonatomic,strong) NSArray <NSNumber *> *noFooter;

@property (nonatomic,strong) NSArray <BaseModel *> *headerModels;
@property (nonatomic,strong) NSArray <BaseModel *> *footerModels;

@property (nonatomic,strong) NSMutableArray * dataSource;
@end

NS_ASSUME_NONNULL_END
