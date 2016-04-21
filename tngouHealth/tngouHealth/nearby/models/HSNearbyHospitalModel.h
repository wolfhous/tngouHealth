//
//  HSNearbyHospitalModel.h
//  tngouHealth
//
//  Created by hou on 16/4/21.
//  Copyright © 2016年 houshuai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HSNearbyHospitalModel : NSObject
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *address;
@property (nonatomic,assign)float x;
@property (nonatomic,assign)float y;
@property (nonatomic,strong)NSString *tel;
@property (nonatomic,strong)NSString *img;
@end
