//
//  HEDiseaseList.h
//  Health
//
//  Created by wolfhous on 16/1/18.
//  Copyright © 2016年 wolfhous. All rights reserved.
//

#import <Foundation/Foundation.h>

//疾病列表
@interface HEDiseaseList : NSObject<NSCoding>

/** 疾病名字*/
@property (nonatomic,strong)NSString *name;
/** 疾病描述*/
@property (nonatomic,strong)NSString *message;
/** 简单描述疾病病症*/
@property (nonatomic,strong)NSString *symptom;
/** 详情描述疾病病症*/
@property (nonatomic,strong)NSString *symptomtext;
/** 预防*/
@property (nonatomic,strong)NSString *caretext;
/** 相关检查*/
@property (nonatomic,strong)NSString *checks;
/** 检查描述*/
@property (nonatomic,strong)NSString *checktext;
/** 相关科室*/
@property (nonatomic,strong)NSString *department;
/** 常用药物*/
@property (nonatomic,strong)NSString *drug;
/** 药品描述*/
@property (nonatomic,strong)NSString *drugtext;
/** 建议吃食物*/
@property (nonatomic,strong)NSString *food;
/** 建议吃食物描述*/
@property (nonatomic,strong)NSString *foodtext;
/** 常见疾病名字*/
@property (nonatomic,strong)NSString *disease;



@end
