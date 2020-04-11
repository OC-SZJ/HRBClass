//
//  TableViewNullView.h
//  mingjiangkeji
//
//  Created by SZJ on 2020/4/4.
//  Copyright © 2020 SZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface TableViewNullView : UIView

@end

@interface UITableView (NilData)
-(void(^)(BOOL isNil))isNil;
@end


NS_ASSUME_NONNULL_END
