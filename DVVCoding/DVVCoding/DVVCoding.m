//
//  DVVCoding.m
//  DVVCoding <https://github.com/devdawei/DVVCoding.git>
//
//  Created by 大威 on 2016/11/21.
//  Copyright © 2016年 devdawei. All rights reserved.
//

#import "DVVCoding.h"
#import <objc/runtime.h>

typedef NS_ENUM(NSUInteger, DVVCodingType)
{
    DVVCodingTypeEncode,
    DVVCodingTypeDecode,
};

@implementation NSObject (DVVCoding)


- (void)dvv_encode:(NSCoder *)encoder
{
    [self dvv_codingFor:encoder type:DVVCodingTypeEncode];
}

- (void)dvv_decode:(NSCoder *)decoder
{
    [self dvv_codingFor:decoder type:DVVCodingTypeDecode];
}

- (void)dvv_codingFor:(NSCoder *)coder type:(DVVCodingType)type
{
    NSArray *ignoreProperties = nil;
    if ([[self class] respondsToSelector:@selector(dvv_codingIgnoreProperties)])
    {
        ignoreProperties = (NSArray *)[[self class] performSelector:@selector(dvv_codingIgnoreProperties)];
    }
    
    if (!ignoreProperties) ignoreProperties = [NSArray array];
    // 添加默认忽略的属性
    NSMutableArray *defaultIgnoreProperties = [NSMutableArray arrayWithObjects:@"hash", @"superclass", @"description", @"debugDescription", nil];
    ignoreProperties = [defaultIgnoreProperties arrayByAddingObjectsFromArray:ignoreProperties];
    
    unsigned int count;
    // 获取属性列表
    objc_property_t *properties = class_copyPropertyList(self.class, &count);
    
    for (unsigned int i = 0; i < count; i++)
    {
        // 获取一个属性
        objc_property_t property = properties[i];
        // 获取一个属性名
        const char *name = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:name];
        
        // 过滤属性
        if (ignoreProperties)
        {
            BOOL flage = NO;
            for (NSString *ignorePropertyName in ignoreProperties)
            {
                if ([propertyName isEqualToString:ignorePropertyName])
                {
                    flage = YES;
                    break;
                }
            }
            if (flage)
            {
                continue;
            }
        }
        
        // 用来存储一个属性值
        NSString *propertyValue = nil;
        
        // 编码
        if (DVVCodingTypeEncode == type)
        {
            propertyValue = [self valueForKey:propertyName];
            if(propertyValue) [coder encodeObject:propertyValue forKey:propertyName];
        }
        // 解码
        else if (DVVCodingTypeDecode == type)
        {
            propertyValue = [coder decodeObjectForKey:propertyName];
            if(propertyValue) [self setValue:propertyValue forKey:propertyName];
        }
    }
    // 释放
    free(properties);
}

@end
