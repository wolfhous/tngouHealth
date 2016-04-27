//
//  HEBodyList.h
//  Health
//
//  Created by wolfhous on 16/1/18.
//  Copyright © 2016年 wolfhous. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HEBodyList : NSObject<NSCoding>
/** 部位名称*/
@property (nonatomic,strong) NSString *bodyDame;
/** 部位ID*/
@property (nonatomic,assign) NSNumber *bodyID;
@end
