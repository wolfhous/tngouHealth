//
//  HSAnnotation.h
//  tngouHealth
//
//  Created by hou on 16/4/21.
//  Copyright © 2016年 houshuai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface HSAnnotation : NSObject<MKAnnotation>
/** 坐标 必须要*/
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
/** 可选title*/
@property (nonatomic,copy) NSString *title;
/** 可选subtitle*/
@property (nonatomic, copy) NSString *subtitle;
/** 添加描述图片的属性*/
@property (nonatomic,strong) UIImage *image;
/** 用来传递药店地址的属性*/
@property (nonatomic, strong) NSString *add;
@end
