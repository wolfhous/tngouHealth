//
//  HEOrgansTableViewController.m
//  Health
//
//  Created by wolfhous on 16/1/18.
//  Copyright © 2016年 wolfhous. All rights reserved.
//

#import "HEOrgansTableViewController.h"
//#import "AFNetworking.h"
#import "HEOrgansList.h"
//#import "HEDataManager.h"
#import "HEDiseaseListTableViewController.h"
#import "MBProgressHUD+KR.h"
@interface HEOrgansTableViewController ()
/** 器官列表数组*/
@property (nonatomic,strong) NSArray *organsList;
@end

@implementation HEOrgansTableViewController
#pragma mark - -------懒加载------
- (NSArray *)organsList {
    if(_organsList == nil) {
        _organsList = [[NSArray alloc] init];
    }
    return _organsList;
}
#pragma mark - -----viewDidLoad------
- (void)viewDidLoad {
    [super viewDidLoad];
    [MBProgressHUD showMessage:@"正在加载数据..."];
    self.navigationItem.title = self.organsName;
    self.tableView.backgroundColor = [UIColor colorWithRed:129/255.0 green:231/255.0 blue:197/255.0 alpha:1];
    /** 加载器官列表*/
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self loadOrgansList];
    });
}
/** 加载器官列表*/
-(void)loadOrgansList{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"id"] = self.organsID;
    [manager GET:@"http://www.tngou.net/api/place/classify" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUD];
        _organsList = [HSManager getOrgansList:responseObject];
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


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.organsList.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
    }
    
    HEOrgansList *organs = self.organsList[indexPath.row];
    cell.textLabel.text = organs.organsName;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell setBackgroundColor:[UIColor clearColor]];
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HEDiseaseListTableViewController *vc = [HEDiseaseListTableViewController new];
    HEOrgansList *organs = self.organsList[indexPath.row];
    vc.diseaseListName = organs.organsName;
    vc.diseaseListID = organs.organsID;
    [self.navigationController pushViewController:vc animated:YES];
}




@end
