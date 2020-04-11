//
//  NSIndexPath+Tool.h
//  mingjiangkeji
//
//  Created by SZJ on 2020/3/25.
//  Copyright © 2020 SZJ. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSIndexPath (Tool)

-(void)userRow:(void(^)(NSInteger row))useRow;
-(void)userSection:(void(^)(NSInteger section))useSection;
-(void)userRowSection:(void(^)(NSInteger row,NSInteger section))useRowSection;
@end

NS_ASSUME_NONNULL_END
