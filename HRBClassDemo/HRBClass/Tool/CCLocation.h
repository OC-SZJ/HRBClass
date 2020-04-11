//
//  CCLocation.h
//  JadeShop
//
//  Created by mac on 2019/7/5.
//  Copyright © 2019年 SZJ.test. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^CompletionHandler)(CLLocationCoordinate2D cLLocationCoordinate2D);




CLLocationCoordinate2D CLLocationCoordinate2DNull(void);

BOOL CLLocationCoordinate2DIsNull(CLLocationCoordinate2D coordinate);
/*
 
 CLPlacemark类说明
 //           location  CLLocation 类型  位置对象信息, 里面包含经纬度, 海拔等
 //              region  CLRegion 类型 地标对象对应的区域
 //           addressDictionary NSDictionary 存放街道,省市等信息
 //              name  NSString 地址全称
 //              thoroughfare NSString  街道名称
 //              locality NSString  城市名称
 //              administrativeArea  NSString   省名称
 //              country  NSString  国家名称
 */


@interface CCLocation : NSObject

///获取当前的经纬度
+(void)getCurrentCLLocationCoordinate2D:(CompletionHandler)completionHandler;

/// 根据经纬度获取地址
+ (void)getAddressForCLLocationCoordinate2D:(CLLocationCoordinate2D)LLocationCoordinat_Nullablee2D completionHandler:(void(^)(CLPlacemark *placemark,NSError *error))completionHandler;
/// 根据地址获取经纬度
+ (void)getCLLocationCoordina_Nullablete2DForAddress:(NSString *)address completionHandler:(void(^)(CLLocationCoordinate2D cLLocationCoordinate2D,NSError * error))completionHandler;
@end


@interface CLLocationManager(Tool)
@property (nonatomic,copy) NSString * cc_key;
@property (nonatomic,copy) CompletionHandler completionHandler;
@end
