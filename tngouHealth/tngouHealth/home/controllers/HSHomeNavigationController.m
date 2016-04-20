//
//  HSHomeNavigationController.m
//  tngouHealth
//
//  Created by hou on 16/4/20.
//  Copyright © 2016年 houshuai. All rights reserved.
//

#import "HSHomeNavigationController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
@interface HSHomeNavigationController ()

@end

@implementation HSHomeNavigationController
+(void)initialize//保证只调用一次
{
    NSLog(@"*********");
    if (self == [HSHomeNavigationController class]) {
        //        0获取导航栏外观对象
        UINavigationBar *bar = [UINavigationBar appearance];//appearance出现
        //        1设置导航栏的背景图
//        [bar setBackgroundImage:[UIImage imageNamed:@"navibg"] forBarMetrics:UIBarMetricsDefault];
        //        2设置导航栏的背景色
        //        [bar setBackgroundColor:[UIColor redColor]];
        //        3设置状态栏白色系
//        [bar setBarStyle:UIBarStyleBlack];
        //        4 设置左右item渲染颜色
        [bar setTintColor:HSRGBColor(187, 187, 187)];
        //        5设置标题的位置(Vertical竖直方向)
        [bar setTitleVerticalPositionAdjustment:0 forBarMetrics:UIBarMetricsDefault];//-10的话上移10个方向
        //        6设置标题文字样式
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];//准备一个字典记录
//        attributes[NSForegroundColorAttributeName] = [UIColor yellowColor];//前景色为黄色(字的颜色)
        //        attributes[NSBackgroundColorAttributeName] = [UIColor blueColor];
        
        attributes[NSFontAttributeName] = [UIFont italicSystemFontOfSize:18];//字体大小为18
        [bar setTitleTextAttributes:attributes];
        
        //        7设置返回箭头样式
        [bar setBackIndicatorImage:[UIImage imageNamed:@"Backx"]];
        [bar setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"Backx"]];
        
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //一句话添加侧滑返回功能
    self.navigationController.fd_fullscreenPopGestureRecognizer.enabled=YES;
}
//重写父类的pushViewController方法
//退出时隐藏底部bar
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated//viewController这个就是要退出的视图
{
    if (self.childViewControllers.count > 0) { // 如果push进来的不是第一个控制器
        viewController.hidesBottomBarWhenPushed = YES;
        //iOS7及以后的版本支持，self.view.frame.origin.y会下移64像素至navigationBar下方。
        viewController.edgesForExtendedLayout = UIRectEdgeNone;
    }
    // 这句super的push要放在后面, 让viewController可以覆盖上面设置的leftBarButtonItem
    [super pushViewController:viewController animated:animated];
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
