//
//  HEDiseaseListTableViewController.h
//  Health
//
//  Created by wolfhous on 16/1/19.
//  Copyright © 2016年 wolfhous. All rights reserved.
//

#import <UIKit/UIKit.h>
// 疾病列表类
@interface HEDiseaseListTableViewController : UITableViewController
/**  疾病列表ID*/
@property (nonatomic,strong)NSNumber *diseaseListID;
@property (nonatomic,strong)NSString *diseaseListName;
@end
