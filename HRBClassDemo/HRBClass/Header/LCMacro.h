//
//  LCMacro.h
//  Test
//
//  Created by mac on 2019/10/24.
//  Copyright © 2019 SZJ. All rights reserved.
//

#ifndef LCMacro_h
#define LCMacro_h



#define LC_YES @"yes"
#define LC_NO @"no"

#define LC_CURRENTVC @"cc_currentVC"

#define LC_RGB(r,g,b)  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#define LC_HEX(f) [UIColor colorWithHexString:f]



#define X_TABBAR(f) [AdapterForXIB cc_FrameForX:(f)]

#define X_NAV(f) [AdapterForXIB cc_FrameForNavX:(f)]


#define W(f) ((f) * [UIScreen mainScreen].bounds.size.width / 375)

#define LC_WEAK_SELF __weak typeof(self) weakSelf = self;

#define LC_STRONG_SELF __strong typeof(self) strongSelf = weakSelf;

#define LC_COLOR(f) [UIColor colorNamed:f]

#ifdef DEBUG
#define LC_LOG(format, ...) printf("\n\n------富强、民主、文明、和谐、自由、平等\n\n🇨🇳类: <%p %s:(%d) >🇨🇳\n🇨🇳方法: %s 🇨🇳\n🇨🇳打印内容:\n%s\n", self, [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, __PRETTY_FUNCTION__, [[NSString stringWithFormat:( format @"                         \n🇨🇳\n------公正、法治、爱国、敬业、诚信、友善\n"), ##__VA_ARGS__] UTF8String] )
#else
#define LC_LOG(format, ...)
#endif

#endif /* LCMacro_h */
