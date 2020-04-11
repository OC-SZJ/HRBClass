//
//  MHSafeTool.h
//  JadeShop
//
//  Created by mac on 2019/8/13.
//  Copyright © 2019 SZJ.test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <dlfcn.h>
#import <sys/types.h>


typedef int (*ptrace_ptr_t)(int _request, pid_t _pid, caddr_t _addr, int _data);
#if !defined(PT_DENY_ATTACH)
#define PT_DENY_ATTACH 31
#endif

void disable_gdb(void);

NS_ASSUME_NONNULL_BEGIN

@interface MHSafeTool : NSObject

@end

NS_ASSUME_NONNULL_END
