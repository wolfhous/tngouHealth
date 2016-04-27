//
//  HEDiseaseTableViewController.m
//  Health
//
//  Created by wolfhous on 16/1/19.
//  Copyright © 2016年 wolfhous. All rights reserved.
//

#import "HEDiseaseTableViewController.h"
#import "HEMessageWebViewController.h"
//单个疾病介绍
@interface HEDiseaseTableViewController ()
@end

@implementation HEDiseaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.disease.name;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Incomplete implementation, return the number of sections
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete implementation, return the number of rows
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    switch (indexPath.section) {
            //疾病介绍
        case 0:
        {
            UILabel *messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, cell.bounds.size.width, 90)];
            //            messageLabel.backgroundColor = [UIColor redColor];
            messageLabel.font = [UIFont systemFontOfSize:13];
            messageLabel.numberOfLines = 0;
            NSString *str;
            if (self.disease.message == nil) {
                str = [NSString stringWithFormat:@"%@,%@",self.disease.department,self.disease.symptom];
            }else{
                str = self.disease.message;
            }
            messageLabel.text = str;
            [cell.contentView addSubview:messageLabel];
        }
            break;
            //常见病状
        case 1:
        {
            UILabel *symptomLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, cell.bounds.size.width, 90)];
            //            symptomLabel.backgroundColor = [UIColor redColor];
            symptomLabel.font = [UIFont systemFontOfSize:13];
            symptomLabel.numberOfLines = 0;
            if (![self.disease.symptom  isEqual: @""]) {
                symptomLabel.text = [NSString stringWithFormat:@"\t%@",self.disease.symptom];
            }else{
                symptomLabel.text = [NSString stringWithFormat:@"\t%@",self.disease.disease];
            }
            [cell.contentView addSubview:symptomLabel];
        }
            break;
            //常用药物
        case 2:
        {
            UILabel *drugLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, cell.bounds.size.width, 90)];
            //            drugLabel.backgroundColor = [UIColor redColor];
            drugLabel.font = [UIFont systemFontOfSize:13];
            drugLabel.numberOfLines = 0;
            if (![self.disease.drug isEqual:@""]) {
                drugLabel.text = [NSString stringWithFormat:@"\t%@",self.disease.drug];
            }else{
                drugLabel.text = [NSString stringWithFormat:@"\t关于%@的常用药物与治疗...",self.disease.name];
            }
            
            [cell.contentView addSubview:drugLabel];
        }
            break;
            //相关检查
        default:
        {
            UILabel *drugLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, 5, cell.bounds.size.width, 90)];
            //            drugLabel.backgroundColor = [UIColor redColor];
            drugLabel.font = [UIFont systemFontOfSize:13];
            drugLabel.numberOfLines = 0;
            if (self.disease.checks != nil) {
                drugLabel.text = [NSString stringWithFormat:@"\t%@",self.disease.checks];
            }else{
                drugLabel.text = [NSString stringWithFormat:@"\t关于%@的相关检查...",self.disease.name];
            }
            
            [cell.contentView addSubview:drugLabel];
        }
            break;
    }
    
    return cell;
}
/** 分区头显示内容*/
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"疾病介绍";
        case 1:
            return @"常见病状";
        case 2:
            return @"常见药物";
        default:
            return @"相关检查";
    }
}
/** 行高*/
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HEMessageWebViewController *vc = [HEMessageWebViewController new];
    switch (indexPath.section) {
        case 0:
        {
            NSString *str;
            if (self.disease.message == nil) {
                str = [NSString stringWithFormat:@"%@,%@",self.disease.department,self.disease.symptom];
            }else{
                str = self.disease.message;
            }
            vc.str = str;
        }
            break;
        case 1:
        {
            if (![self.disease.symptomtext isEqual:@""]) {
                vc.str = self.disease.symptomtext;
            }else{
                vc.str = self.disease.disease;
            }
        }
            break;
        case 2:
        {
            if (![self.disease.drugtext isEqual:@""]) {
                vc.str = self.disease.drugtext;
            }else{
                vc.str = @"\t暂未获取到有用信息";
            }
        }
            break;
            
        default:
        {
            if (![self.disease.checktext isEqual:@""]) {
                vc.str = self.disease.checktext;
            }else{
                vc.str = @"\t暂未获取到有用信息";
            }
        }
            break;
    }
    [self.navigationController pushViewController:vc animated:YES];
}


@end
