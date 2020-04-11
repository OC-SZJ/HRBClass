//
//  AdapterForNoAutoLayout.h
//  Test
//
//  Created by mac on 2019/10/25.
//  Copyright © 2019 SZJ. All rights reserved.
//

#import <Foundation/Foundation.h>




NS_ASSUME_NONNULL_BEGIN

@interface AdapterForNoAutoLayout : NSObject




@end


@interface UIView (f)

@property (nonatomic,assign) BOOL alreadyGood;// 是否适配

- (void)frameSelf;


@end


NS_ASSUME_NONNULL_END
