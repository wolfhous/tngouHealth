//
//  HEBodyTableViewController.m
//  Health
//
//  Created by wolfhous on 16/1/18.
//  Copyright © 2016年 wolfhous. All rights reserved.
//

#import "HEBodyTableViewController.h"
//#import "HEDataManager.h"
#import "HEBodyList.h"
//#import "AFNetworking.h"
#import "HEOrgansTableViewController.h"
@interface HEBodyTableViewController ()
/** 身体部位数组*/
@property (nonatomic,strong) NSArray *bodyArray;//需要对该数组里面的自定义对象进行归档
/** 归档文件路径(xxx/Documents/archiving)*/
@property (nonatomic, strong) NSString *archivingFilePath;
@end

@implementation HEBodyTableViewController
#pragma mark - ------懒加载数据------
/** 归档路径*/
- (NSString *)archivingFilePath {
    if (!_archivingFilePath) {
        NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        _archivingFilePath = [documentsPath stringByAppendingPathComponent:@"bodyArchiving"];
    }
    return _archivingFilePath;
}
/** 部位数据获取*/
- (NSArray *)bodyArray {
    if(_bodyArray == nil) {
        _bodyArray = [[NSArray alloc] init];
        //1.最先从磁盘中读取数据,而不是从网络上请求
        NSData *readingData = [NSData dataWithContentsOfFile:self.archivingFilePath];
        if (readingData != nil) {//1.1如果磁盘中有数据
            //2.解档对象
            NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:readingData];
            //3.解码
            _bodyArray = [unarchiver decodeObjectForKey:@"bodyArray"];
            //4.完成解码
            [unarchiver finishDecoding];
            
        }else{
            
        }
    }
    return _bodyArray;
}

#pragma mark - ------viewDidLoad------
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"部位查病";
    self.tableView.backgroundColor = [UIColor colorWithRed:129/255.0 green:231/255.0 blue:197/255.0 alpha:1];
    /** 加载部位数组*/
    [self loadBodyArray];
}

/** 加载部位数组*/
-(void)loadBodyArray
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://www.tngou.net/api/place/classify" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.bodyArray = [HSManager getBodyList:responseObject];
        if ([HSManager getBodyList:responseObject]) {
            [self.tableView reloadData];//保证新数据,重新刷新表格
            /** 归档步骤*/
            //1.可变数据
            NSMutableData *mutableData = [NSMutableData data];
            //2.归档对象
            NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:mutableData];
            //3.编码
            [archiver encodeObject:self.bodyArray forKey:@"bodyArray"];
            //4.完成编码
            [archiver finishEncoding];
            //5.写入文件
            [mutableData writeToFile:self.archivingFilePath atomically:YES];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"网络连接错误" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete implementation, return the number of rows
    return self.bodyArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseIdentifier"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseIdentifier"];
    }
    HEBodyList *body = self.bodyArray[indexPath.row];
    cell.textLabel.text = body.bodyDame;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HEOrgansTableViewController *vc = [HEOrgansTableViewController new];
    HEBodyList *body = self.bodyArray[indexPath.row];
    vc.organsName = body.bodyDame;
    vc.organsID = body.bodyID;
    [self.navigationController pushViewController:vc animated:YES];
}

@end











