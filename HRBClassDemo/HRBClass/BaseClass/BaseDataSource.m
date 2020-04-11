//
//  BaseTableVCDataSource.m
//  FrameWork
//
//  Created by SZJ on 2020/3/14.
//  Copyright © 2020 SZJ. All rights reserved.
//

#import "BaseDataSource.h"

@implementation BaseDataSource
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource = NSMutableArray.new;
    }
    return _dataSource;
}
@end
