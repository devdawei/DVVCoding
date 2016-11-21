
//
//  Test.m
//  DVVCoding
//
//  Created by 大威 on 2016/11/21.
//  Copyright © 2016年 devdawei. All rights reserved.
//

#import "Test.h"

@implementation Test

DVVCodingImplementation

/**
 缓存时忽略的属性

 @return 忽略列表
 */
+ (NSArray *)dvv_codingIgnoreProperties
{
    return @[ @"token", @"userID" ];
}

@end
