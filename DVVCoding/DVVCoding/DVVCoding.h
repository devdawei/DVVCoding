//
//  DVVCoding.h
//  DVVCoding
//
//  Created by 大威 on 2016/11/21.
//  Copyright © 2016年 devdawei. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DVVCodingDelegate <NSObject>

@optional

/**
 如果有不想缓存的属性，通过此代理方法返回就可以了
 */
+ (NSArray *)dvv_codingIgnoreProperties;

@end

@interface NSObject (DVVCoding)

/**
 *  解码（从文件解析对象）
 */
- (void)dvv_decode:(NSCoder *)decoder;
/**
 *  编码（将对象写入文件）
 */
- (void)dvv_encode:(NSCoder *)encoder;


/**
 *  属性归档的实现
 */
#define DVVCodingImplementation \
- (instancetype)initWithCoder:(NSCoder *)aDecoder \
{ \
self = [super init]; \
if (self) { \
[self dvv_decode:aDecoder]; \
} \
return self; \
} \
\
- (void)encodeWithCoder:(NSCoder *)coder \
{ \
[self dvv_encode:coder]; \
}

@end
