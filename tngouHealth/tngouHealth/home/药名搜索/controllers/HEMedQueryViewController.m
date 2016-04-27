//
//  HEMedQueryViewController.m
//  Health
//
//  Created by FengGY on 16/1/18.
//  Copyright © 2016年 wolfhous. All rights reserved.
//

#import "HEMedQueryViewController.h"
#import "HEMedList.h"
#import "HEMedListCell.h"
#import "AFNetworking.h"
//#import "HEDataManager.h"
#import "HEMedDetaliViewController.h"
#import "MJRefresh.h"

/******************** 冯广勇 ********************/



@interface HEMedQueryViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    NSInteger index;
}

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UILabel *showResultSummaryLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

/** 药品列表数组*/
@property (nonatomic,strong)NSMutableArray *medListArray;
/** 请求药品列表页数*/
@property (nonatomic,assign)NSInteger page;
/** 最新发送请求对象*/
@property (nonatomic,strong)AFHTTPRequestOperation *lastRequest;

@end


@implementation HEMedQueryViewController
/** 懒加载药品列表数组*/
- (NSArray *)medListArray {
    if(_medListArray == nil) {
        _medListArray = [NSMutableArray array];
    }
    return _medListArray;
}
#pragma mark - --------viewDidLoad------
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.searchBar.delegate = self;
    index = 1;
    [self.tableView registerNib:[UINib nibWithNibName:@"HEMedListCell" bundle:nil] forCellReuseIdentifier:@"MedListCell"];
    self.searchBar.text = @"胶囊";
    self.tableView.estimatedRowHeight = 50;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.tableHeaderView.hidden = YES;
    /** 添加上拉刷新控件*/
    [self addRefreshControl];
}

#pragma mark - --------UISearchBarDelegate------
/** 点击键盘右下角搜索*/
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;{
    [self.view endEditing:YES];
    [self loadfirstMedList];
}
#pragma mark - --------点击搜索按钮------
/** 点击右上角按钮搜索*/
- (IBAction)searchBarButtonClick:(id)sender {
    [self.view endEditing:YES];
    [self loadfirstMedList];
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
    self.showResultSummaryLabel.text = @"正在查询.";
    NSTimer *timer  = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(changeLabelText:) userInfo:nil repeats:YES];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"page"] = @(self.page);
    parameters[@"keyword"] = self.searchBar.text;
    /** 每页请求12条数据*/
    parameters[@"rows"] = @(12);
    parameters[@"name"] = @"drug";
    AFHTTPRequestOperation *request = [manager GET:@"http://www.tngou.net/api/search" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (self.lastRequest != request) {
            //            NSLog(@"老请求不响应");
            return ;
        }else{
            //            NSLog(@"新请求就响应");
            self.lastRequest = request;
        }
        /**释放timer*/
        [timer invalidate];
        /** 显示总条数到label上 */
        self.showResultSummaryLabel.text = [NSString stringWithFormat:@"共搜索到结果%@条",responseObject[@"total"]];
        
        //        NSLog(@"请求成功 %@",responseObject);
        if (self.page == 1) {
            [self.medListArray removeAllObjects];
        }
        [self.medListArray addObjectsFromArray:[HSManager getParsedMedID:responseObject]];
        if (self.medListArray) {
            [self.tableView reloadData];
            //停止上拉控件的动画
            [self.tableView.mj_footer endRefreshing];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        /**释放timer*/
        [timer invalidate];
        self.showResultSummaryLabel.text = @"药品查询失败,请查看网络并重试!";
        //停止上拉控件的动画
        [self.tableView.mj_footer endRefreshing];
    }];
}
/** 查询是显示的正在查询文本*/
-(void)changeLabelText:(NSTimer *)timer {
    if (index <4) {
        index++;
    }else {
        index = 1;
    }
    switch (index) {
        case 1:
            self.showResultSummaryLabel.text = @"正在查询.";
            break;
        case 2:
            self.showResultSummaryLabel.text = @"正在查询..";
            break;
        case 3:
            self.showResultSummaryLabel.text = @"正在查询...";
            break;
        default:
            break;
    }
    
}

#pragma mark - tableView

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.view endEditing:YES];
    HEMedDetaliViewController *detailVC = [HEMedDetaliViewController new];
    HEMedList *list = self.medListArray[indexPath.row];
    detailVC.id = list.id;
    [self.navigationController pushViewController:detailVC animated:YES];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.showResultSummaryLabel.alpha = 1 - scrollView.contentOffset.y / 50;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.medListArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HEMedListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MedListCell" forIndexPath:indexPath];
    HEMedList *list = self.medListArray[indexPath.row];
    cell.list = list;
    return cell;
}




@end
