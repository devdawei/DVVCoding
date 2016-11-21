//
//  Test.h
//  DVVCoding
//
//  Created by 大威 on 2016/11/21.
//  Copyright © 2016年 devdawei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DVVCoding.h"

@interface Test : NSObject <DVVCodingDelegate>

@property (nonatomic, copy) NSString *token;
@property (nonatomic, assign) NSUInteger userID;

@property (nonatomic, copy) NSString *name;

@end
