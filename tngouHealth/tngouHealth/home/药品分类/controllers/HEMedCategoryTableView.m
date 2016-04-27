//
//  HEMedCategoryTableView.m
//  Health
//
//  Created by wolfhous on 16/1/13.
//  Copyright © 2016年 wolfhous. All rights reserved.
//  药品有哪些分类

#import "HEMedCategoryTableView.h"
#import "AFNetworking.h"
//#import "HEDataManager.h"
#import "HEMedListTableView.h"
#import "MBProgressHUD+KR.h"

@interface HEMedCategoryTableView ()
/** 药品分类数组*/
@property (nonatomic,strong)NSArray *medArray;
/** 归档路径*/
@property (nonatomic,strong)NSString *medArrayArchivingFilePath;
/** 记录网络是否能连接成功*/
@property (nonatomic,assign)BOOL isRequest;
@end

@implementation HEMedCategoryTableView
/** 懒加载药品分类数组*/
- (NSArray *)medArray {
    if(_medArray == nil) {
        _medArray = [[NSArray alloc] init];
        NSData *data = [NSData dataWithContentsOfFile:self.medArrayArchivingFilePath];
        if (data != nil) {
            NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
            _medArray = [unarchiver decodeObjectForKey:@"medArray"];
        }
    }
    return _medArray;
}

/** 归档路径*/
- (NSString *)medArrayArchivingFilePath
{
    if (_medArrayArchivingFilePath == nil) {
        NSString *docment = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
        _medArrayArchivingFilePath = [docment stringByAppendingPathComponent:@"MedCategoryArchiving"];
    }
    
    return _medArrayArchivingFilePath;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.isRequest = YES;
    [self requestCategoryList];
}
#pragma mark - ----请求数据----
/** 请求药品分类数据*/
-(void)requestCategoryList
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://www.tngou.net/api/drug/classify" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.isRequest = YES;
        self.medArray = [HSManager getMedCategory:responseObject];
        [self.tableView reloadData];
        NSMutableData *mutableData = [NSMutableData data];
        NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc]initForWritingWithMutableData:mutableData];
        [archiver encodeObject:self.medArray forKey:@"medArray"];
        [archiver finishEncoding];
        [mutableData writeToFile:self.medArrayArchivingFilePath atomically:YES];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.isRequest = NO;
        if (self.medArray == nil) {
            [MBProgressHUD showError:@"药品分类列出失败,请检查网络并重试"];
        }
    }];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete implementation, return the number of rows
    return self.medArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"medCategoryCell" forIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"medCategoryCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"medCategoryCell"];
    }
    HEMedCategory *med = self.medArray[indexPath.row];
    cell.textLabel.text = med.title;
    return cell;
}
/** 选中某个分类*/
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isRequest == NO) {
        [self requestCategoryList];
        [MBProgressHUD showError:@"药品分类列出失败,请检查网络并重试"];
        return;
    }
    HEMedCategory *med = self.medArray[indexPath.row];
    HEMedListTableView *medListTableView = [HEMedListTableView new];
    medListTableView.id = med.id;
    //    self.isRequest = NO;
    [self.navigationController pushViewController:medListTableView animated:YES];
}












@end
