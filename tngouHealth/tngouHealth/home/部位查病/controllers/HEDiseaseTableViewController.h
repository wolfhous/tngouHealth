//
//  HEDiseaseTableViewController.h
//  Health
//
//  Created by wolfhous on 16/1/19.
//  Copyright © 2016年 wolfhous. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HEDiseaseList.h"
//单个疾病介绍
@interface HEDiseaseTableViewController : UITableViewController
/**  单个疾病详情*/
@property (nonatomic,strong)HEDiseaseList *disease;
@end
