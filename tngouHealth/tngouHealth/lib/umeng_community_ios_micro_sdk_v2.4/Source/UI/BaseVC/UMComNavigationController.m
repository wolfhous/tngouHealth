//
//  UMComNavigationController.m
//  UMCommunity
//
//  Created by Gavin Ye on 8/27/14.
//  Copyright (c) 2014 Umeng. All rights reserved.
//

#import "UMComNavigationController.h"
#import "UMComTools.h"

@interface UMComNavigationController ()

@end

@implementation UMComNavigationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([[UIDevice currentDevice].systemVersion floatValue] < 7) {
        [self.navigationBar setBackgroundColor:[UMComTools colorWithHexString:@"#f7f7f8"]];
        [self.navigationBar setBackgroundImage:[[UIImage alloc]init] forBarMetrics:UIBarMetricsDefault];
    }else{
        [self.navigationBar setBarTintColor:[UMComTools colorWithHexString:@"#f7f7f8"]];
    }
    // Do any additional setup after loading the view from its nib.
}
//重写父类的pushViewController方法
//退出时隐藏底部bar
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated//viewController这个就是要退出的视图
{
    if (self.childViewControllers.count > 0) { // 如果push进来的不是第一个控制器
        viewController.hidesBottomBarWhenPushed = YES;
        //iOS7及以后的版本支持，self.view.frame.origin.y会下移64像素至navigationBar下方。
//        viewController.edgesForExtendedLayout = UIRectEdgeNone;
    }
    // 这句super的push要放在后面, 让viewController可以覆盖上面设置的leftBarButtonItem
    [super pushViewController:viewController animated:animated];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
