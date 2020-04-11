//
//  UIImageView+Tool.m
//  JadeShop
//
//  Created by mac on 2019/4/4.
//  Copyright © 2019年 SZJ.test. All rights reserved.
//

#import "UIImageView+Tool.h"
#import "LCAPI.h"
#import "UIImageView+WebCache.h"

static NSString *_cc_urlStr;

@implementation UIImageView (Tool)

UIImage *HRB_IMG(NSString * img){
    return [UIImage imageNamed:img];
}

-(void)hrb_img:(NSString *)name{
    if (name.length == 0) {
        self.image = [UIImage imageNamed:@"placeHolder"];
        return;
    }
    UIImage *image = [UIImage imageNamed:name];
    if (!image) {
        if ([name containsString:@"http"]) {
            [self sd_setImageWithURL:[NSURL URLWithString:name]];
        }else{
            [self sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",LC_ImageHeader,name]]];
        }
    }else{
        self.image = image;
    }
}
-(void)hrb_head:(NSString *)name{
    if (name.length == 0) {
        self.image = [UIImage imageNamed:@"placeHolder"];
        return;
    }
    UIImage *image = [UIImage imageNamed:name];
    if (!image) {
        if ([name containsString:@"http"]) {
            [self sd_setImageWithURL:[NSURL URLWithString:name]];
        }else{
            [self sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",LC_ImageHeader,name]]];
        }
    }else{
        self.image = image;
    }
}
@end
