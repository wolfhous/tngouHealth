//
//  HSTabBarController.m
//  tngouHealth
//
//  Created by hou on 16/4/15.
//  Copyright © 2016年 houshuai. All rights reserved.
//

#import "HSTabBarController.h"

@interface HSTabBarController ()

@end

@implementation HSTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    统一设置UITabBarItem字体样式
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:9];//默认字体大小
    attrs[NSForegroundColorAttributeName] = HSRGBColor(43, 175, 136);//默认字体颜色
    NSMutableDictionary *selectAttrs = [NSMutableDictionary dictionary];
    selectAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:9];//选中时字体大小
    selectAttrs[NSForegroundColorAttributeName] = HSRGBColor(43, 175, 136);//选中时字体颜色
    UITabBarItem *item = [UITabBarItem appearance];//统一设置所有tabBarItem
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectAttrs forState:UIControlStateSelected];
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
