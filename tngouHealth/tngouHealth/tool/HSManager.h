//
//  HSManager.h
//  tngouHealth
//
//  Created by hou on 16/4/20.
//  Copyright © 2016年 houshuai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HEBodyList.h"
#import "HEOrgansList.h"
#import "HEDiseaseList.h"
#import "HEMedList.h"
#import "HEMedCategory.h"
@interface HSManager : NSObject

/** 返回正确image路径*/
+(NSString *)getSureImageUrl:(NSString *)httpImageUrl;


#pragma mark - 药品查询
/** 给定请求分类大字典,返回药品分类数组*/
+(NSArray *)getMedCategory:(id)responseObject;
/** 给定药品分类,返回分类旗下药品列表*/
+(NSArray *)getMedList:(id)medCategory;
/** 解析服务器返回的搜索结果(是一个药品id数组) */
+(NSArray *)getParsedMedID:(NSDictionary *)responseObj;

#pragma mark - 部位查病
/** 返回部位(头,手...)*/
+(NSArray *)getBodyList:(id)responseObject;
/** 返回器官(鼻,眼..)*/
+(NSArray *)getOrgansList:(id)responseObject;
/** 返回疾病症状(感冒,鼻炎..)*/
+(NSArray *)getDiseaseList:(id)responseObject;

@end
