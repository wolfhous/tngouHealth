//
//  HSHomeTableViewController.m
//  tngouHealth
//
//  Created by hou on 16/4/15.
//  Copyright © 2016年 houshuai. All rights reserved.
//

#import "HSHomeTableViewController.h"
#import "EMClient.h"
#import "SDCycleScrollView.h"
@interface HSHomeTableViewController ()<SDCycleScrollViewDelegate>

@end

@implementation HSHomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    [self setupHeaderScrollView];
//    EMError *error = [[EMClient sharedClient] registerWithUsername:@"hs1" password:@"111111"];
//    if (error==nil) {
//        NSLog(@"注册成功");
//    }else{
//        DLog(@"%@",error)
//    }
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
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
