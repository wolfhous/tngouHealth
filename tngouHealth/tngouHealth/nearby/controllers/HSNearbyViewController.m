//
//  HSNearbyViewController.m
//  tngouHealth
//
//  Created by hou on 16/4/20.
//  Copyright © 2016年 houshuai. All rights reserved.
//

#import "HSNearbyViewController.h"
//两个设置title需要的头文件
#import "UIViewController+UMComAddition.h"
#import "UMComProfileSettingController.h"
//地图
#import <MapKit/MapKit.h>
//医院药店药企模型
#import "HSNearbyHospitalModel.h"
//自定义大头针
#import "HSAnnotation.h"
@interface HSNearbyViewController ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic,strong)CLLocationManager *manager;
/** 附近医院*/
@property (nonatomic,strong)NSArray *array_hospital;
/** 附近药店*/
@property (nonatomic,strong)NSArray *array_store;
/** 附近药企*/
@property (nonatomic,strong)NSArray *array_factory;


/**用来存选择的大头针*/
@property (nonatomic, strong) HSAnnotation *selectAnnotation;
/** 详细页面*/
@property (weak, nonatomic) IBOutlet UIView *detailView;
/** 医院名字*/
@property (weak, nonatomic) IBOutlet UILabel *modelName;
/** 医院电话*/
@property (weak, nonatomic) IBOutlet UILabel *modelTel;

@property (weak, nonatomic) IBOutlet UIButton *callNumBtn;
@property (weak, nonatomic) IBOutlet UIButton *goToBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@end

@implementation HSNearbyViewController
-(NSArray *)array_hospital
{
    if (!_array_hospital) {
        _array_hospital = [NSArray array];
    }
    return _array_hospital;
}
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
    userLocation.subtitle = @"这是您目前的所在位置";
    if (self.array_hospital.count == 0) {
        [self loadHospitalData:userLocation];
    }
    if (self.array_store.count == 0) {
        [self loadStoreData:userLocation];
    }
    if (self.array_factory.count == 0) {
        [self loadFactoryData:userLocation];
    }
    
}
//监听到地图发生移动
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    NSLog(@"地图已经发生移动");
}
#pragma mark - 请求医院药店药企
//请求附近医院
-(void)loadHospitalData:(MKUserLocation *)userLocation{
    HS_PARAMETERS;
    parameters[@"y"] = @(userLocation.location.coordinate.latitude);
    parameters[@"x"] = @(userLocation.location.coordinate.longitude);
    [HS_AF_MANAGER POST:@"http://www.tngou.net/api/hospital/location" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        self.array_hospital = [HSNearbyHospitalModel mj_objectArrayWithKeyValuesArray:responseObject[@"tngou"]];
        [self addAnnotationWithArray:self.array_hospital withImage:[UIImage imageNamed:@"annotation_hospital"]];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [MBProgressHUD showError:@"网络错误"];
    }];
}
//请求附近药店
-(void)loadStoreData:(MKUserLocation *)userLocation{
    HS_PARAMETERS;
    parameters[@"y"] = @(userLocation.location.coordinate.latitude);
    parameters[@"x"] = @(userLocation.location.coordinate.longitude);
    [HS_AF_MANAGER POST:@"http://www.tngou.net/api/store/location" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        self.array_store = [HSNearbyHospitalModel mj_objectArrayWithKeyValuesArray:responseObject[@"tngou"]];
        [self addAnnotationWithArray:self.array_store withImage:[UIImage imageNamed:@"annotation_store"]];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [MBProgressHUD showError:@"网络错误"];
    }];
}
//请求附近药企
-(void)loadFactoryData:(MKUserLocation *)userLocation{
    HS_PARAMETERS;
    parameters[@"y"] = @(userLocation.location.coordinate.latitude);
    parameters[@"x"] = @(userLocation.location.coordinate.longitude);
    [HS_AF_MANAGER POST:@"http://www.tngou.net/api/factory/location" parameters:parameters success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        self.array_factory = [HSNearbyHospitalModel mj_objectArrayWithKeyValuesArray:responseObject[@"tngou"]];
        [self addAnnotationWithArray:self.array_factory withImage:[UIImage imageNamed:@"annotation_factory"]];
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        [MBProgressHUD showError:@"网络错误"];
    }];
}


#pragma mark - 添加大头针
/**
 *  添加大头针
 *
 *  @param array 模型数组(包含坐标等)
 *  @param image 大头针图片
 */
-(void)addAnnotationWithArray:(NSArray *)array withImage:(UIImage *)image
{
    for (HSNearbyHospitalModel *model in array) {
        /** 创建自定义大头针,并设置好属性*/
        HSAnnotation *annotation = [HSAnnotation new];
        annotation.coordinate = CLLocationCoordinate2DMake(model.y, model.x);
        annotation.title = model.name;
        annotation.subtitle = model.tel;
        annotation.image = image;
        annotation.add = model.address;
        [self.mapView addAnnotation:annotation];
    }
}
/** 添加大头针一瞬间,设置大头针*/
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    //需求:修改大头针自定义图片
    
    /** 1 如果是用户位置蓝点,则不修改其样式*/
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    /** 2设置大头针(大头针重用机制*/
    static NSString *identifier = @"annoView";
    MKAnnotationView *annoView = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (!annoView) {
        annoView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        annoView.canShowCallout = YES;
        //设置annotation的图片属性给annoView(前提:自定义的大头针对象需要添加图片属性)
        HSAnnotation *anno = (HSAnnotation *)annotation;
        annoView.image = anno.image;
    } else {
        annoView.annotation = annotation;
    }
    
    return annoView;

}


#pragma mark -- 点击某个大头针 需要完成一系列的事件
/**点击大头针的方法   */
-(void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    /**获取选取大头针的坐标*/
    self.selectAnnotation = (HSAnnotation*)view.annotation;
    /**将药店信息显示到drugstoreView上*/
    self.modelName.text = self.selectAnnotation.add;
    self.modelTel.text = self.selectAnnotation.subtitle;
    /** 设置圆形button*/
    [self.goToBtn setRoundLayerWithCornerRadius:5];
    [self.cancelBtn setRoundLayerWithCornerRadius:5];
    [self.callNumBtn setRoundLayerWithCornerRadius:5];
    /**显示选择的view*/
    if (self.detailView.hidden == YES) {
        self.detailView.hidden = NO;
    }
    
}

#pragma mark - detailView点击事件

/** 打电话*/
- (IBAction)callNumBtn:(id)sender {
    //获取能拨打的电话号码
    NSRange range = NSMakeRange(0, 11);
    NSString *telNumber = [self.selectAnnotation.subtitle  substringWithRange:range];
    telNumber = [telNumber  stringByReplacingOccurrencesOfString:@"-" withString:@""];
    //把能拨打的号码 给url
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",telNumber]];
    
    [[UIApplication sharedApplication]openURL:url];
}
/** 去这里*/
- (IBAction)goToBtn:(id)sender {
    //用户位置
    MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
    //药店位置
    MKMapItem *drugstoreLocation = [[MKMapItem alloc]initWithPlacemark:[[MKPlacemark alloc]initWithCoordinate:self.selectAnnotation.coordinate addressDictionary:nil]];
    //默认坐公交去目标地点
    [MKMapItem openMapsWithItems:@[currentLocation, drugstoreLocation]
                   launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeTransit}];
}
/** 取消*/
- (IBAction)cancelBtn:(id)sender {
    self.detailView.hidden = YES;
}

@end
