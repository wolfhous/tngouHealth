//
//  HSHomeViewController.m
//  tngouHealth
//
//  Created by hou on 16/4/26.
//  Copyright © 2016年 houshuai. All rights reserved.
//

#import "HSHomeViewController.h"
//滚动视图
#import "SDCycleScrollView.h"
//标题配置
#import "UIViewController+UMComAddition.h"
#import "UMComProfileSettingController.h"

#import "SubLBXScanViewController.h"
#import "LBXScanViewStyle.h"
#import "LBXScanViewController.h"

//1一定要先配置自己项目在商店的APPID,配置完最好在真机上运行才能看到完全效果哦
#define STOREAPPID @"1104867082"

@interface HSHomeViewController ()<SDCycleScrollViewDelegate>
/** 头部滚动视图*/
@property (weak, nonatomic) IBOutlet SDCycleScrollView *headerView;

@end

@implementation HSHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setForumUITitle:UMComLocalizedString(@"home", @"首页")];
    [self setupHeaderScrollView];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //一句代码实现检测更新,很简单哦
    [self hsUpdateApp];
}
#pragma mark - 配置轮播图片---创建轮播图片
/** 配置表头ScrollView,放在tableHeaderView*/
-(void)setupHeaderScrollView
{
    
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
    self.headerView.imageURLStringsGroup = imagesURLStrings;
    self.headerView.titlesGroup = titles;
    //配置pageControl样式
    self.headerView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    self.headerView.delegate = self;
}
#pragma mark ------检测更新----------
/**
 *  天朝专用检测app更新
 */
-(void)hsUpdateApp
{
    //2先获取当前工程项目版本号
    NSDictionary *infoDic=[[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion=infoDic[@"CFBundleShortVersionString"];
    
    //3从网络获取appStore版本号
    NSError *error;
    NSData *response = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/cn/lookup?id=%@",STOREAPPID]]] returningResponse:nil error:nil];
    if (response == nil) {
        NSLog(@"你没有连接网络哦");
        return;
    }
    NSDictionary *appInfoDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
    if (error) {
        NSLog(@"hsUpdateAppError:%@",error);
        return;
    }
    //    NSLog(@"%@",appInfoDic);
    NSArray *array = appInfoDic[@"results"];
    NSDictionary *dic = array[0];
    NSString *appStoreVersion = dic[@"version"];
    //打印版本号
    NSLog(@"当前版本号:%@\n商店版本号:%@",currentVersion,appStoreVersion);
    //4当前版本号小于商店版本号,就更新
    if([currentVersion floatValue] < [appStoreVersion floatValue])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"版本有更新" message:[NSString stringWithFormat:@"检测到新版本(%@),是否更新?",appStoreVersion] delegate:self cancelButtonTitle:@"取消"otherButtonTitles:@"更新",nil];
        [alert show];
    }else{
        NSLog(@"版本号好像比商店大噢!检测到不需要更新");
    }
    
}

- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //5实现跳转到应用商店进行更新
    if(buttonIndex==1)
    {
        //6此处加入应用在app store的地址，方便用户去更新，一种实现方式如下：
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://itunes.apple.com/us/app/id%@?ls=1&mt=8", STOREAPPID]];
        [[UIApplication sharedApplication] openURL:url];
    }
}
#pragma mark - 配置轮播图片---图片点击代理

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    DLog(@"点击了第%ld张图片",index);
}

#pragma mark -非正方形，可以用在扫码条形码界面
- (IBAction)clickScanBtn:(id)sender {
    [self notSquare];
}

- (UIImage*) createImageWithColor: (UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

- (void)notSquare
{
    //设置扫码区域参数
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];
    style.centerUpOffset = 44;
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Inner;
    style.photoframeLineW = 4;
    style.photoframeAngleW = 28;
    style.photoframeAngleH = 16;
    style.isNeedShowRetangle = NO;
    style.anmiationStyle = LBXScanViewAnimationStyle_LineStill;
    style.animationImage = [self createImageWithColor:[UIColor redColor]];
    //非正方形
    //设置矩形宽高比
    style.whRatio = 4.3/2.18;
    
    //离左边和右边距离
    style.xScanRetangleOffset = 30;
    
    SubLBXScanViewController *vc = [SubLBXScanViewController new];
    vc.isQQSimulator = YES;
    vc.style = style;
    //vc.isOpenInterestRect = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
