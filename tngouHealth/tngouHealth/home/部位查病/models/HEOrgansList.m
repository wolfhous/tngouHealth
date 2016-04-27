//
//  HEOrgansList.m
//  Health
//
//  Created by wolfhous on 16/1/18.
//  Copyright © 2016年 wolfhous. All rights reserved.
//

#import "HEOrgansList.h"

@implementation HEOrgansList
//对属性进行编码(时机:控制器执行encodeObject方法)
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.organsName forKey:@"organsName"];
    [aCoder encodeObject:self.organsID forKey:@"organsID"];
}
//对属性进行解码(时机:控制器执行decodeObject方法)
- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.organsName = [aDecoder decodeObjectForKey:@"organsName"];
        self.organsID = [aDecoder decodeObjectForKey:@"organsID"];
    }
    return self;
}
@end
