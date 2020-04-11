//
//  MHSafeTool.m
//  JadeShop
//
//  Created by mac on 2019/8/13.
//  Copyright © 2019 SZJ.test. All rights reserved.
//

#import "MHSafeTool.h"
void disable_gdb() {
    void* handle = dlopen(0, RTLD_GLOBAL | RTLD_NOW);
    ptrace_ptr_t ptrace_ptr = dlsym(handle, "ptrace");
    ptrace_ptr(PT_DENY_ATTACH, 0, 0, 0);
    dlclose(handle);
}

@implementation MHSafeTool

#pragma mark --- 检测是否越狱 ---
//一般能拿到自己ipa包都需要有一台越狱的手机
//
//判断设备是否安装了越狱常用工具：
//一般安装了越狱工具的设备都会存在以下文件：
///Applications/Cydia.app
///Library/MobileSubstrate/MobileSubstrate.dylib
///bin/bash
///usr/sbin/sshd
///etc/apt
//判断设备上是否存在cydia应用
//是否有权限读取系统应用列表
//没有越狱的设备是没有读取所有应用名称的权限
//检测当前程序运行的环境变量 DYLD_INSERT_LIBRARIES
//非越狱手机DYLD_INSERT_LIBRARIES获取到的环境变量为NULL。
//
//综上所述，检查设备是否越狱

+ (BOOL)isJailbroken{
      // 检查是否存在越狱常用文件
    NSArray *jailFilePaths = @[@"/Applications/Cydia.app",
                               @"/Library/MobileSubstrate/MobileSubstrate.dylib",
                               @"/bin/bash",
                               @"/usr/sbin/sshd",
                               @"/etc/apt"];
    for (NSString *filePath in jailFilePaths) {
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
            return YES;
        }
    }
    // 检查是否有权限读取系统应用列表
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/User/Applications/"]){
        NSArray *applist = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"/User/Applications/"
                                                                               error:nil];
        NSLog(@"applist = %@",applist);
        return YES;
    }
    //  检测当前程序运行的环境变量
    char *env = getenv("DYLD_INSERT_LIBRARIES");
    if (env != NULL) {
        return YES;
    }
    
    return NO;
}

@end
