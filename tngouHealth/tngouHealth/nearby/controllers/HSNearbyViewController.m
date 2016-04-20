//
//  HSNearbyViewController.m
//  tngouHealth
//
//  Created by hou on 16/4/20.
//  Copyright © 2016年 houshuai. All rights reserved.
//

#import "HSNearbyViewController.h"
#import "UIViewController+UMComAddition.h"
#import "UMComProfileSettingController.h"
@interface HSNearbyViewController ()

@end

@implementation HSNearbyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setForumUITitle:UMComLocalizedString(@"nearby", @"附近药店")];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
