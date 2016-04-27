//
//  HEMessageWebViewController.m
//  Health
//
//  Created by wolfhous on 16/1/25.
//  Copyright © 2016年 wolfhous. All rights reserved.
//

#import "HEMessageWebViewController.h"

@interface HEMessageWebViewController ()<UIWebViewDelegate>
/** 疾病单个详情信息*/
@property (nonatomic,strong)UIWebView *webView;
@end

@implementation HEMessageWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详情介绍";

    self.webView.delegate = self;
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    [self.view addSubview:self.webView];
    [self.webView loadHTMLString:self.str baseURL:nil];
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
