//
//  UILabel+Tool.m
//  ocCrazy
//
//  Created by mac on 2018/4/25.
//  Copyright © 2018年 dukai. All rights reserved.
//

#import "UILabel+Tool.h"





@implementation UILabel (Tool)





-(void)setHTMLStr:(NSString *)str{
    NSAttributedString *attrStr = [[NSAttributedString alloc] initWithData:[str dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    self.attributedText = attrStr;
}

- (void)addCenterLine{
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:self.text attributes:attribtDic];
    self.attributedText = attribtStr;
}
- (void)setLineSpacing:(CGFloat)lineSpacing{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing; // 调整行间距
    NSRange range = NSMakeRange(0, [self.text length]);
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
    self.attributedText = attributedString;
}

@end
