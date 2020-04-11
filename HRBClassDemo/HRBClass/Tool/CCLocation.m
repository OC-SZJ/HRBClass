//
//  CCLocation.m
//  JadeShop
//
//  Created by mac on 2019/7/5.
//  Copyright © 2019年 SZJ.test. All rights reserved.
//

#import "CCLocation.h"
#import "CCToast.h"
static const int _maxRequestCount = 5;//最多同时多少个定位请求

@interface CCLocation()<CLLocationManagerDelegate>

@property (nonatomic,strong) CLGeocoder * geo;

@property (nonatomic,strong)  NSMutableArray <CLLocationManager *>* managerArray;
@end

CCLocation *Share(){
    static CCLocation *_cclocation;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _cclocation = [[CCLocation alloc] init];
    });
    return _cclocation;
}

CLLocationCoordinate2D CLLocationCoordinate2DNull(void){
    return CLLocationCoordinate2DMake(10000, 10000);
}

BOOL CLLocationCoordinate2DIsZero(CLLocationCoordinate2D coordinate){
    return (coordinate.latitude = 10000) && (coordinate.longitude == 10000);
}


@implementation CCLocation



+(void)getCurrentCLLocationCoordinate2D:(CompletionHandler)completionHandler{
    BOOL needNewManager = YES;
    CLLocationManager *newManager;
    @synchronized (self) {
        
        for (CLLocationManager *manager in Share().managerArray) {
            if (manager.cc_key == nil) {
                newManager = manager;
                newManager.cc_key = @(Share().managerArray.count).stringValue;
                needNewManager = NO;
                break;
            }
        }
        
        if (needNewManager) {
            if (Share().managerArray.count == _maxRequestCount) {
                completionHandler(CLLocationCoordinate2DNull());
                [CCToast setMessage:@"定位繁忙,请重试"];
                return;
            }else{
                newManager = [Share() newManager];
                newManager.cc_key = @(Share().managerArray.count).stringValue;
                [Share().managerArray addObject:newManager];
            }
        }
        
        newManager.completionHandler = completionHandler;
    }
    [newManager startUpdatingLocation];
    
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    [manager stopUpdatingLocation];
    CLLocation *location = [locations firstObject];
    
    manager.completionHandler(location.coordinate);
    manager.cc_key = nil;
    
}

+ (void)getAddressForCLLocationCoordinate2D:(CLLocationCoordinate2D)LLocationCoordinat_Nullablee2D completionHandler:(void(^)(CLPlacemark *placemark,NSError *error))completionHandler{
    [Share().geo reverseGeocodeLocation:[[CLLocation alloc] initWithLatitude:LLocationCoordinat_Nullablee2D.latitude longitude:LLocationCoordinat_Nullablee2D.longitude] completionHandler:^(NSArray<CLPlacemark *> * __nullable placemarks, NSError * __nullable error)
     {
        completionHandler([placemarks firstObject],error);
    }];
}

+ (void)getCLLocationCoordina_Nullablete2DForAddress:(NSString *)address completionHandler:(void(^)(CLLocationCoordinate2D cLLocationCoordinate2D,NSError * error))completionHandler{
    [Share().geo geocodeAddressString:address completionHandler:^(NSArray<CLPlacemark *> * __nullable placemarks, NSError * __nullable error)
     {
        CLPlacemark *placemark = [placemarks firstObject];
        CLLocation *location = placemark.location;
        completionHandler(location.coordinate,error);
    }];
}



-(CLLocationManager *)newManager{
    
    CLLocationManager *manager = [[CLLocationManager alloc] init];
    [manager requestAlwaysAuthorization];
    manager.distanceFilter = 0.1;
    manager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    
    manager.delegate = self;
    
    return manager;
}

-(CLGeocoder *)geo{
    if (!_geo) {
        _geo = [[CLGeocoder alloc] init];
    }
    return _geo;
}

-(NSMutableArray<CLLocationManager *> *)managerArray{
    if (!_managerArray) {
        _managerArray = [NSMutableArray array];
    }
    return _managerArray;
}




-(void)locationManager:(nonnull CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status) {
            // 用户还未决定
        case kCLAuthorizationStatusNotDetermined:
        {
            NSLog(@"用户还未决定");
            break;
        }
            // 访问受限(苹果预留选项,暂时没用)
        case kCLAuthorizationStatusRestricted:
        {
            NSLog(@"访问受限");
            break;
        }
            // 定位关闭时和对此APP授权为never时调用
        case kCLAuthorizationStatusDenied:
        {
            // 定位是否可用（是否支持定位或者定位是否开启）
            if([CLLocationManager locationServicesEnabled])
            {
                NSLog(@"定位开启，但被拒");
                // 在此处, 应该提醒用户给此应用授权, 并跳转到"设置"界面让用户进行授权
                // 在iOS8.0之后跳转到"设置"界面代码
                //                                        if([[UIApplication sharedApplication] canOpenURL:settingURL])
                //                                              {
                //                                                      [[UIApplication sharedApplication] openURL:settingURL];
                //                                                   }
            }else
            {
                NSLog(@"定位关闭，不可用");
            }
            break;
        }
            // 获取前后台定位授权
        case kCLAuthorizationStatusAuthorizedAlways:
            //  case kCLAuthorizationStatusAuthorized: // 失效，不建议使用
        {
            NSLog(@"获取前后台定位授权");
            break;
        }
            // 获得前台定位授权
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        {
            NSLog(@"获得前台定位授权");
            break;
        }
        default:
            break;
    }
}

@end



@implementation CLLocationManager (Tool)

-(NSString *)cc_key{
    return objc_getAssociatedObject(self, @"cc_key");
}

-(void)setCc_key:(NSString *)cc_key{
    objc_setAssociatedObject(self, @"cc_key", cc_key, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(CompletionHandler)completionHandler{
    return objc_getAssociatedObject(self, @"completionHandler");
}
-(void)setCompletionHandler:(CompletionHandler)completionHandler{
    objc_setAssociatedObject(self, @"completionHandler", completionHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


@end


