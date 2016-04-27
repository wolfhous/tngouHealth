//
//  HEMedList.h
//  Health
//
//  Created by wolfhous on 16/1/13.
//  Copyright © 2016年 wolfhous. All rights reserved.
//

#import <Foundation/Foundation.h>
//药品列表
@interface HEMedList : NSObject
/** 药品名称*/
@property (nonatomic,strong) NSString *name;
/** 药品ID*/
@property (nonatomic,assign) NSNumber *id;
/** 药品图片*/
@property (nonatomic,strong) NSString *imageURL;
/** 药品简介*/
@property (nonatomic,strong) NSString *desc;
@end
