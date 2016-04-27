//
//  HSManager.m
//  tngouHealth
//
//  Created by hou on 16/4/20.
//  Copyright © 2016年 houshuai. All rights reserved.
//

#import "HSManager.h"

@implementation HSManager
+(NSString *)getSureImageUrl:(NSString *)httpImageUrl{
    NSString *sureUrl;
    if (![httpImageUrl isEqual:[NSNull null]]) {
        DLog(@"图片路径为空");
        return httpImageUrl;
    }
    if ([httpImageUrl hasPrefix:@"http"]) {
        sureUrl = httpImageUrl;
    } else{
        sureUrl = [NSString stringWithFormat:@"%@%@",IMGPATH,httpImageUrl];
    }
    return sureUrl;
}
+(NSArray *)getBodyList:(id)responseObject{
    NSArray *array = responseObject[@"tngou"];
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        HEBodyList *body = [HEBodyList new];
        body.bodyDame = dic[@"name"];
        body.bodyID = dic[@"id"];
        [mutableArray addObject:body];
    }
    return [mutableArray copy];
}
+(NSArray *)getOrgansList:(id)responseObject
{
    NSArray *array = responseObject[@"tngou"];
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        HEOrgansList *organs = [HEOrgansList new];
        organs.organsName = dic[@"name"];
        organs.organsID = dic[@"id"];
        [mutableArray addObject:organs];
    }
    return [mutableArray copy];
}
+(NSArray *)getDiseaseList:(id)responseObject
{
    NSArray *array = responseObject[@"list"];
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        HEDiseaseList *disease = [HEDiseaseList new];
//                [disease setValuesForKeysWithDictionary:dic];
        disease.name = dic[@"name"];
        disease.symptom = dic[@"symptom"];
        disease.symptomtext = dic[@"symptomtext"];
        disease.caretext = dic[@"caretext"];
        disease.checktext = dic[@"checktext"];
        disease.department = dic[@"department"];
        disease.drugtext = dic[@"drugtext"];
        disease.foodtext = dic[@"foodtext"];
        disease.drug = dic[@"drug"];
        [mutableArray addObject:disease];
    }
    return [mutableArray copy];
}
+(NSArray *)getParsedMedID:(NSDictionary *)responseObj
{
    NSMutableArray *mutArr = [NSMutableArray array];
    NSArray *array = responseObj[@"tngou"];
    for (NSDictionary *dic in array) {
        HEMedList *medList = [HEMedList new];
        medList.id = dic[@"id"];
        medList.name = dic[@"name"];
        medList.desc = dic[@"description"];
        medList.imageURL = dic[@"img"];
        [mutArr addObject:medList];
    }
    return [mutArr copy];
}
+(NSArray *)getMedList:(id)medList
{
    NSArray *array = medList[@"tngou"];
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        HEMedList *medList = [HEMedList new];
        medList.id = dic[@"id"];
        medList.name = dic[@"name"];
        medList.desc = dic[@"description"];
        NSString *imageHead = @"http://tnfs.tngou.net/image";
        medList.imageURL = [NSString stringWithFormat:@"%@%@",imageHead,dic[@"img"]];
        [mutableArray addObject:medList];
    }
    return [mutableArray copy];
    
}
+(NSArray *)getMedCategory:(id)responseObject
{
    NSArray *array = responseObject[@"tngou"];
    NSMutableArray *mutableArray = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        HEMedCategory *medCategory = [HEMedCategory new];
        medCategory.id = dic[@"id"];
        medCategory.title = dic[@"title"];
        [mutableArray addObject:medCategory];
    }
    return [mutableArray copy];
}
@end
