//
//  HEMedCategory.h
//  Health
//
//  Created by wolfhous on 16/1/13.
//  Copyright © 2016年 wolfhous. All rights reserved.
//

#import <Foundation/Foundation.h>
//药品分类
@interface HEMedCategory : NSObject<NSCoding>
/** 药品分类id*/
@property (nonatomic,assign)NSNumber *id;
/** 药品分类title*/
@property (nonatomic,strong)NSString *title;
@end
