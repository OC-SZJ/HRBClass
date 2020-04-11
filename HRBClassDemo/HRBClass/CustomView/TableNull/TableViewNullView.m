//
//  TableViewNullView.m
//  mingjiangkeji
//
//  Created by SZJ on 2020/4/4.
//  Copyright © 2020 SZJ. All rights reserved.
//

#import "TableViewNullView.h"

@implementation TableViewNullView
+ (void)showWithTableView:(UITableView *)tableView{
    TableViewNullView *view = [NSBundle.mainBundle loadNibNamed:@"TableViewNullView" owner:nil options:nil].firstObject;
    view.frame = tableView.frame;
    view.tag = 10010;
    [tableView addSubview:view];
}
@end

@implementation UITableView (NilData)
-(void(^)(BOOL isNil))isNil;{
    void(^a)(BOOL isNil) = ^(BOOL isNil)
    {
        if (!isNil) {
            [TableViewNullView showWithTableView:self];
        }else{
            if ([self viewWithTag:10010]) {
                [[self viewWithTag:10010] removeFromSuperview];
            }
        }
    };
    
    return a;
}
@end
