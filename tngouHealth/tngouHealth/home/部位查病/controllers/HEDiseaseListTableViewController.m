//
//  HEDiseaseListTableViewController.m
//  Health
//
//  Created by wolfhous on 16/1/19.
//  Copyright © 2016年 wolfhous. All rights reserved.
//

#import "HEDiseaseListTableViewController.h"
#import "HEDiseaseList.h"
//#import "HEDataManager.h"
//#import "AFNetworking.h"
#import "HEDiseaseTableViewController.h"
//#import "MBProgressHUD+KR.h"
@interface HEDiseaseListTableViewController ()
/** 疾病列表数组*/
@property (nonatomic,strong)NSArray *disListArray;
@end

@implementation HEDiseaseListTableViewController
- (NSArray *)disListArray {
    if(_disListArray == nil) {
        _disListArray = [[NSArray alloc] init];
    }
    return _disListArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [MBProgressHUD showMessage:@"正在加载数据..."];
    self.navigationItem.title = self.diseaseListName;
    self.tableView.backgroundColor = [UIColor colorWithRed:129/255.0 green:231/255.0 blue:197/255.0 alpha:1];
    [self requestDiseaseList];
    
}
/** 请求疾病分类列表*/
-(void)requestDiseaseList
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"id"] = self.diseaseListID;
    parameters[@"rows"] = @(20);
    [manager GET:@"http://www.tngou.net/api/disease/place?" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUD];
        self.disListArray = [HSManager getDiseaseList:responseObject];
        /** 一旦请求到数据,就刷新表格*/
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD hideHUD];
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"网络连接错误" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete implementation, return the number of rows
    return self.disListArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
    }
    HEDiseaseList *dic = self.disListArray[indexPath.row];
    cell.textLabel.text = dic.name;
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HEDiseaseTableViewController *vc = [HEDiseaseTableViewController new];
    vc.disease = self.disListArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
    
}



@end
