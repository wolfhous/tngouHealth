//
//  NSString+HSString.m
//  tngouHealth
//
//  Created by hou on 16/4/20.
//  Copyright © 2016年 houshuai. All rights reserved.
//

#import "NSString+HSString.h"

@implementation NSString (HSString)
+ (BOOL)isPhone:(NSString *)phone
{
    NSString *regex = @"^(1)\\d{10}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [pred evaluateWithObject:phone];
}
@end
