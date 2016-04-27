//
//  HEOrgansList.h
//  Health
//
//  Created by wolfhous on 16/1/18.
//  Copyright © 2016年 wolfhous. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HEOrgansList : NSObject<NSCoding>
/** 器官名称*/
@property (nonatomic,strong) NSString *organsName;
/** 器官ID*/
@property (nonatomic,assign) NSNumber *organsID;
@end
