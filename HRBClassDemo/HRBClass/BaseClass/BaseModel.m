

#import "BaseModel.h"
#import "LCNetWorkTool.h"
#import "Tool.h"


@implementation BaseModel

codera

+ (NSDictionary *)modelCustomPropertyMapper {
    if ([self respondsToSelector:@selector(cc_customProPerty)]) {
        return [self cc_customProPerty];
    }
    return @{};
}
+ (NSDictionary *)modelContainerPropertyGenericClass {
    if ([self respondsToSelector:@selector(cc_arrayWithClass)]) {
        return [self cc_arrayWithClass];
    }
    return @{};
}

-(NSArray<BaseModel *> *)modelArr{return nil;}

- (NSString *)description
{
    NSString *description = @"";
    
    if (self) {
        unsigned int outCount , i;
        objc_property_t *properties = class_copyPropertyList([self class], &outCount);
        for (i = 0; i < outCount; i++){
            objc_property_t property = properties[i];
            const char *char_f = property_getName(property);
            
            NSString *propertyName = [NSString stringWithUTF8String:char_f];
            if ([description isEqualToString:@""]) {
             description =  [description stringByAppendingFormat:@"%@\n", @"{"];
                
            }
            if ([self valueForKey:propertyName] == NULL) {
              description =  [description stringByAppendingFormat:@" %@ = NULL;\n", propertyName];
            }else if([self valueForKey:propertyName] == nil ){
               description =  [description stringByAppendingFormat:@" %@ = nil;\n", propertyName];
            }else{
              description =  [description stringByAppendingFormat:@" %@ = %@;\n", propertyName, [self valueForKey:propertyName]];
            }
            if (i == outCount - 1) {
              description =   [description stringByAppendingString:@"}"];
            }
       
        }
    }else{
        NSLog(@"所打印的model为nil");
    }
    
    return description;
}



@end

