//
//  HSHomeTableViewController.m
//  tngouHealth
//
//  Created by hou on 16/4/15.
//  Copyright © 2016年 houshuai. All rights reserved.
//

#import "HSHomeTableViewController.h"

#import "SDCycleScrollView.h"

#import "UIViewController+UMComAddition.h"
#import "UMComProfileSettingController.h"

#import "HSCeshiViewController.h"
@interface HSHomeTableViewController ()<SDCycleScrollViewDelegate>

@end

@implementation HSHomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setForumUITitle:UMComLocalizedString(@"home", @"首页")];
    [self setupHeaderScrollView];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
     self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - 配置轮播图片---创建轮播图片
/** 配置表头ScrollView,放在tableHeaderView*/
-(void)setupHeaderScrollView
{
    SDCycleScrollView *headerView = [[SDCycleScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
    //设置navigationbar不透明
    self.edgesForExtendedLayout = UIRectEdgeNone;
    NSArray *imagesURLStrings = @[
                                  @"http://www.danzhaowang.com/UploadFiles/2015-11-17/2/2015111710265656155.jpg",
                                  @"http://www.danzhaowang.com/images/2016danzhaohelp.jpg",
                                  @"http://www.danzhaowang.com/ad/33.jpg"
                                  ];
    NSArray *titles = @[@"www.houshuai.com",
                        @"天狗查药测试版本!!!",
                        @"重做测试!!!!"
                        ];
    headerView.imageURLStringsGroup = imagesURLStrings;
    headerView.titlesGroup = titles;
    //配置pageControl样式
    headerView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    headerView.delegate = self;
    self.tableView.tableHeaderView = headerView;
}
#pragma mark - 配置轮播图片---图片点击代理
/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    DLog(@"点击了第%ld张图片",index);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HScell" forIndexPath:indexPath];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HScell"];
//    }
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HScell"];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    // Configure the cell...
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HSCeshiViewController *vc = [HSCeshiViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
