//
//  LOGView.m
//  OhEastMakeWant_Shop
//
//  Created by SZJ on 2020/3/19.
//  Copyright © 2020 SZJ. All rights reserved.
//

#import "LOGView.h"

@implementation LOGView
{
    __weak IBOutlet UILabel *_notice_label;
}
+ (void)showMessage:(NSString *)message{
    LOGView *view = [NSBundle.mainBundle loadNibNamed:@"LOGView" owner:nil options:nil].firstObject;
    view->_notice_label.text = message;
    [AppDelegate addSubview:view];
}
- (IBAction)remove:(id)sender {
    [self removeFromSuperview];
}


@end
