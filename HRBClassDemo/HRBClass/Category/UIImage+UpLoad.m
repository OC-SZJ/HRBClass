//
//  UIImage+UpLoad.m
//  mingjiangkeji
//
//  Created by SZJ on 2020/4/3.
//  Copyright © 2020 SZJ. All rights reserved.
//

#import "UIImage+UpLoad.h"

@implementation UIImage (UpLoad)
-(void (^)(void (^)(id _Nonnull)))upload{
    void (^up)(void (^)(id _Nonnull)) = ^(void (^result)(id data)) {
//           [LCNetWorkTool upLoad:_lc_index_uploads parameters:@{} imageArr:@[self] nameArr:@[@"file"] fileNameArr:@[@"file.png"] block:^(NSString *urlStr, NSDictionary *dic, NSString *json, NSDictionary *params) {
//               if (result) {
//                   [dic success:^{
//                       result(dic[@"img"]);
//                   }];
//               }
//           } fail:^(NSString *urlStr, NSError *error, NSDictionary *params) {
//               
//           }];
       };
    return up;
}
-(void)setUpload:(void (^)(void (^ _Nonnull)(id _Nonnull)))upload{
    
}
@end
