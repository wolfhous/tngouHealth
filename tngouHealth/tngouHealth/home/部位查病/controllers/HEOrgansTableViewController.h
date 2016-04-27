//
//  HEOrgansTableViewController.h
//  Health
//
//  Created by wolfhous on 16/1/18.
//  Copyright © 2016年 wolfhous. All rights reserved.
//  部位器官列表

#import <UIKit/UIKit.h>

@interface HEOrgansTableViewController : UITableViewController
/**  器官ID*/
@property (nonatomic,strong)NSNumber *organsID;
@property (nonatomic,strong)NSString *organsName;
@end
