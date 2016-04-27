//
//  HEMedListTableViewController.m
//  Health
//
//  Created by wolfhous on 16/1/13.
//  Copyright © 2016年 wolfhous. All rights reserved.
//  药品单个分类列表

#import "HEMedListTableView.h"
//#import "AFNetworking.h"
//#import "HEDataManager.h"
#import "HEMedList.h"
#import "HEMedListCell.h"
#import "MJRefresh.h"
#import "HEMedDetaliViewController.h"
//#import "MBProgressHUD+KR.h"
@interface HEMedListTableView ()
/** 药品列表数组*/
@property (nonatomic,strong)NSMutableArray *medListArray;
/** 请求药品列表页数*/
@property (nonatomic,assign)NSInteger page;
/** 最新发送请求对象*/
@property (nonatomic,strong)AFHTTPRequestOperation *lastRequest;
/** 记录网络是否能连接成功*/
@property (nonatomic,assign)BOOL isRequest;
@end

@implementation HEMedListTableView
/** 懒加载药品列表数组*/
- (NSArray *)medListArray {
    if(_medListArray == nil) {
        _medListArray = [NSMutableArray array];
    }
    return _medListArray;
}

#pragma mark - --------viewDidLoad------
- (void)viewDidLoad {
    [super viewDidLoad];
    [MBProgressHUD showMessage:@"正在加载数据"];
    self.isRequest = NO;
    self.navigationItem.title = @"分类列表";
    /** 注册自定义cell*/
    [self.tableView registerNib:[UINib nibWithNibName:@"HEMedListCell" bundle:nil] forCellReuseIdentifier:@"myCell"];
    /** 第一次请求分类列表*/
    [self loadfirstMedList];
    /** 添加上拉刷新控件*/
    [self addRefreshControl];
    
}

#pragma mark - ----------上拉刷新----------------
- (void)addRefreshControl {
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        /** 有上拉刷新动作,自动执行该方法*/
        [self loadMoreMedList];
    }];
}

#pragma mark - --------请求List数据-------
/** 第一次请求分类列表*/
-(void)loadfirstMedList
{
    /** 初始化请求页数为1*/
    self.page = 1;
    [self getMedList];
}
/** 加载更多List*/
-(void)loadMoreMedList
{
    self.page++;
    [self getMedList];
}
/** 获取某个药品分类旗下的药品列表*/
-(void)getMedList
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"page"] = @(self.page);
    /** 每页请求12条数据*/
    parameters[@"rows"] = @(12);
    parameters[@"id"] = self.id;
    AFHTTPRequestOperation *request = [manager GET:@"http://www.tngou.net/api/drug/list" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD hideHUD];
        self.isRequest = YES;
        if (self.lastRequest != request) {
            
            return ;
        }else{
            
            self.lastRequest = request;
        }
        NSArray *array = [HSManager getMedList:responseObject];
        /** 如果是第一次请求,先移除所有obj*/
        if (self.page == 1) {
            [self.medListArray removeAllObjects];
        }
        [self.medListArray addObjectsFromArray:array];
        if (self.medListArray) {
            [self.tableView reloadData];
            //停止上拉控件的动画
            [self.tableView.mj_footer endRefreshing];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.isRequest = NO;
        [MBProgressHUD hideHUD];
        [MBProgressHUD showError:@"网络连接失败,请查看网络并重试"];
        //停止上拉控件的动画--
        [self.tableView.mj_footer endRefreshing];
    }];
}


#pragma mark - ----Table view data source----

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete implementation, return the number of rows
    return self.medListArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HEMedListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    HEMedList *medList = self.medListArray[indexPath.row];
    cell.list = medList;
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = [UIColor colorWithRed:228.0/255 green:243.0/255 blue:243.0/255 alpha:1];
    }else{
        cell.backgroundColor = nil;
    }
    return cell;
}
/** 设置cell行高*/
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 62;
}
/** 选中某一行cell*/
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isRequest == NO) {
        [MBProgressHUD showError:@"网络连接失败,请查看网络并重试"];
        return;
    }
    HEMedDetaliViewController *detail = [HEMedDetaliViewController new];
    HEMedList *medList = self.medListArray[indexPath.row];
    detail.id = medList.id;
    detail.name = medList.name;
    [self.navigationController pushViewController:detail animated:YES];
    
}





@end
