//
//  NSString+HSString.h
//  tngouHealth
//
//  Created by hou on 16/4/20.
//  Copyright © 2016年 houshuai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (HSString)
/** 判断是否为手机号码*/
+ (BOOL)isPhone:(NSString *)phone;
@end
