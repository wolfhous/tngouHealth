//
//  HEBodyList.m
//  Health
//
//  Created by wolfhous on 16/1/18.
//  Copyright © 2016年 wolfhous. All rights reserved.
//

#import "HEBodyList.h"

@implementation HEBodyList
#pragma mark - NSCoding
//对属性进行编码(时机:控制器执行encodeObject方法)
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.bodyDame forKey:@"bodyDame"];
    [aCoder encodeObject:self.bodyID forKey:@"bodyID"];
}

//对属性进行解码(时机:控制器执行decodeObject方法)
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.bodyDame =  [aDecoder decodeObjectForKey:@"bodyDame"];
        self.bodyID = [aDecoder decodeObjectForKey:@"bodyID"];
    }
    return self;
    
}
@end
