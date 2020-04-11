//
//  NSURLRequest+Tool.m
//  OhEastMakeWant_Shop
//
//  Created by SZJ on 2020/2/17.
//  Copyright © 2020 SZJ. All rights reserved.
//

#import "NSURLRequest+Tool.h"




@implementation NSURLRequest (Tool)

+ (instancetype)url:(NSString *)url{
    if (![url containsString:@"http"]) {
        url = [NSString stringWithFormat:@"http://%@",url];
    }
    return [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
}

@end
