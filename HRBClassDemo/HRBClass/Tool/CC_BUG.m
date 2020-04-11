//
//  CC_BUG.m
//  AutoCare365
//
//  Created by mac on 2018/9/27.
//  Copyright © 2018年 SZJ. All rights reserved.
//

#import "CC_BUG.h"

#import <mach-o/dyld.h>
#import <mach-o/loader.h>

@implementation CC_BUG

void UncaughtExceptionHandler(NSException *exception) {
    
    NSArray *arr = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];

    //这里是异常报告
    
    NSDictionary *dataError = @{@"arr":arr,@"reason":reason,@"name":name,};
    NSString *path = GetPath();
    

    
    BOOL writeSuccess;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dataError options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString * strData = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    
    writeSuccess = [[NSString stringWithFormat:@"%@",strData] writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    if (writeSuccess) {
        NSLog(@"写入成功");
    }
    
}

NSString *GetPath(){
    NSString * docsdir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    NSString *dataFilePath = [docsdir stringByAppendingPathComponent:@"CCCrash"];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL existed = [fileManager fileExistsAtPath:dataFilePath isDirectory:&isDir];
    if (!(isDir && existed)) {
        [fileManager createDirectoryAtPath:dataFilePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSLog(@"%@",dataFilePath);
    NSString *path = [dataFilePath stringByAppendingPathComponent:@"CCCrash.txt"];
    return path;
}

static NSUUID *ExecutableUUID(void){
    const struct mach_header *executableHeader = NULL;
    for (uint32_t i = 0; i < _dyld_image_count(); i++)
    {
        const struct mach_header *header = _dyld_get_image_header(i);
        if (header->filetype == MH_EXECUTE)
        {
            executableHeader = header;
            break;
            
        }
        
    }
    if (!executableHeader) return nil;
    BOOL is64bit = executableHeader->magic == MH_MAGIC_64 || executableHeader->magic == MH_CIGAM_64;
    uintptr_t cursor = (uintptr_t)executableHeader + (is64bit ? sizeof(struct mach_header_64) : sizeof(struct mach_header));
    const struct segment_command *segmentCommand = NULL;
    for (uint32_t i = 0; i < executableHeader->ncmds; i++, cursor += segmentCommand->cmdsize)
    {
        segmentCommand = (struct segment_command *)cursor;
        if (segmentCommand->cmd == LC_UUID)
        {
            const struct uuid_command *uuidCommand = (const struct uuid_command *)segmentCommand;
            return [[NSUUID alloc] initWithUUIDBytes:uuidCommand->uuid];
            
        }
        
    }
    return nil;
    
}

int DeleteError(){
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:GetPath()];
    if (!blHave) {

        return 1;
    }else {
        
        BOOL blDele= [[NSFileManager defaultManager] removeItemAtPath:GetPath() error:nil];
        if (blDele) {
            return 1;
        }else {
            return 0;
        }
        
    }
    
    
}




+ (void)beginBug:(int(^)(NSString *uuid,NSString *dsymUUID,NSString *reason))callBack{
    
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);//监听程序崩溃
    
    NSString *uuid = [[NSUUID UUID] UUIDString];

    NSString *dsymUUID = [ExecutableUUID() UUIDString];
    
    NSString *str = [NSString stringWithContentsOfFile:GetPath() encoding:NSUTF8StringEncoding error:nil];
    
    if (str) {
        int success = callBack(uuid,dsymUUID,str);
        if (success) {
            DeleteError();
        }else{
            
        }
    }
}

@end
