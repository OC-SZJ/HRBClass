//
//  NSIndexPath+Tool.m
//  mingjiangkeji
//
//  Created by SZJ on 2020/3/25.
//  Copyright © 2020 SZJ. All rights reserved.
//

#import "NSIndexPath+Tool.h"

@implementation NSIndexPath (Tool)


-(void)userRow:(void(^)(NSInteger row))useRow{
    if (self.row >= 0) useRow(self.row);
}
-(void)userSection:(void(^)(NSInteger section))useSection{
    if (self.section >= 0)  useSection(self.section);
}
-(void)userRowSection:(void(^)(NSInteger row,NSInteger section))useRowSection{
    if (self.section >= 0 && self.row >= 0 )  useRowSection(self.row,self.section);
}
@end
