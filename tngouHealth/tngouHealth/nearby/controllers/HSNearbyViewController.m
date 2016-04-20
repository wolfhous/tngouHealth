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
#import <MapKit/MapKit.h>
@interface HSNearbyViewController ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic,strong)CLLocationManager *manager;
@end

@implementation HSNearbyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setForumUITitle:UMComLocalizedString(@"nearby", @"附近药店")];
    //初始化manager对象
    self.manager = [CLLocationManager new];
    //征求用户同意(相同点)Info.plist添加key
    [self.manager requestAlwaysAuthorization];
    
    //delegate
    self.mapView.delegate = self;
    //设置地图不允许旋转
    self.mapView.rotateEnabled = NO;
    //设置地图的显示类型(卫星/标准地图/混合)
    self.mapView.mapType = MKMapTypeStandard;
    //开始定位/显示
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
}

#pragma mark - MapViewDelegate
//已经定位到用户位置并且显示完毕
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    DLog(@"纬度%f, 经度%f", userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude);
    //设定蓝色圈的大头针对象title/subtitle
    userLocation.title = @"用户位置";
    userLocation.subtitle = @"用户详细描述";
    
}
//监听到地图发生移动
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    NSLog(@"地图已经发生移动");
}


@end
