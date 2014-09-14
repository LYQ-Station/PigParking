//
//  PPMapNavigators.m
//  PigParking
//
//  Created by LiYongQiang on 14-8-31.
//  Copyright (c) 2014年 VincentStation. All rights reserved.
//

#import "PPMapNavigators.h"

@interface PPMapNavigators () <UIActionSheetDelegate>

@property (nonatomic, strong) NSMutableArray *myNavigators;

@end

@implementation PPMapNavigators

+ (void)navigateFrom:(CLLocationCoordinate2D)from to:(CLLocationCoordinate2D)to destionName:(NSString *)destionName type:(int)type
{
    if (0 == type)
    {
        if (LESS_THAN_IOS6)
        {
                //from Baidu to GPS
            from.latitude -= 0.0060f;
            from.longitude -= 0.0065f;
            
            to.latitude -= 0.0060f;
            to.longitude -= 0.0065f;
            
            NSString *url_str = [[NSString alloc] initWithFormat:@"http://maps.google.com/maps?saddr=%f,%f&daddr=%f,%f&dirfl=d", from.latitude, from.longitude, to.latitude, to.longitude];
            NSURL *url = [NSURL URLWithString:url_str];
            
            [[UIApplication sharedApplication] openURL:url];
        }
        else
        {
            MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
            
//            MKMapItem *currentLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coords1 addressDictionary:nil]];
            
            MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:to addressDictionary:nil]];
            toLocation.name = destionName;
            
            NSArray *items = [NSArray arrayWithObjects:currentLocation, toLocation, nil];
            
            /*
             //keys
             MKLaunchOptionsMapCenterKey:地图中心的坐标(NSValue)
             MKLaunchOptionsMapSpanKey:地图显示的范围(NSValue)
             MKLaunchOptionsShowsTrafficKey:是否显示交通信息(boolean NSNumber)
             
             //MKLaunchOptionsDirectionsModeKey: 导航类型(NSString)
             {
             MKLaunchOptionsDirectionsModeDriving:驾车
             MKLaunchOptionsDirectionsModeWalking:步行
             }
             
             //MKLaunchOptionsMapTypeKey:地图类型(NSNumber)
             enum {
             MKMapTypeStandard = 0,
             MKMapTypeSatellite,
             MKMapTypeHybrid
             };
             */
            NSDictionary *options = @{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,
                                      MKLaunchOptionsMapTypeKey:[NSNumber numberWithInteger:MKMapTypeStandard],
                                      MKLaunchOptionsShowsTrafficKey:@YES
                                      };
            
            [MKMapItem openMapsWithItems:items launchOptions:options];
        }
    }
    else if (1 == type)
    {
            //from GPS to Baidu
//        from = BMKCoorDictionaryDecode(BMKConvertBaiduCoorFrom(from, BMK_COORDTYPE_GPS));
        
        NSString *url = [NSString stringWithFormat:@"baidumap://map/direction?origin=%f,%f&destination=%f,%f&mode=driving&src=人人停车", from.latitude, from.longitude, to.latitude, to.longitude];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }
    else if (2 == type)
    {
            //from Baidu to GPS
        from.latitude -= 0.0060f;
        from.longitude -= 0.0065f;
        
        to.latitude -= 0.0060f;
        to.longitude -= 0.0065f;
        
        NSString *url = [NSString stringWithFormat:@"iosamap://path?sourceApplication=人人停车&backScheme=&sid=&slat=%f&slon=%f&sname=&did=&dlat=%f&dlon=%f&dname=&dev=0&m=0&t=2", from.latitude, from.longitude, to.latitude, to.longitude];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }
}

+ (PPMapNavigators *)sharedInstance
{
    static PPMapNavigators *__instance = nil;
    
    @synchronized (self) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            __instance = [[PPMapNavigators alloc] init];
        });
    }
    
    return __instance;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        self.myNavigators = [NSMutableArray array];
        [_myNavigators addObject:@{@"title": @"苹果导航",@"type":@"0"}];
        
        UIApplication *app = [UIApplication sharedApplication];
        
        NSURL *URL = nil;
        
        URL = [NSURL URLWithString:@"baidumap://map/direction?origin=34.264642646862,108.95108518068&destination=40.007623,116.360582&mode=driving&src=yourCompanyName|yourAppName"];
        if ([app canOpenURL:URL])
        {
            [_myNavigators addObject:@{@"title": @"百度导航",@"type":@"1"}];
        }
        
        URL = [NSURL URLWithString:@"iosamap://path?sourceApplication=%@&backScheme=%@&sid=&slat=%f&slon=%f&sname=&did=&dlat=%f&dlon=%f&dname=&dev=0&m=0&t=2"];
        if ([app canOpenURL:URL])
        {
            [_myNavigators addObject:@{@"title": @"高德导航",@"type":@"2"}];
        }
    }
    return self;
}

- (NSArray *)navigators
{
    return [NSArray arrayWithArray:_myNavigators];
}

- (UIActionSheet *)navigatorsSheet
{
    UIActionSheet *as = nil;
    
    if (1==_myNavigators.count)
    {
        as = [[UIActionSheet alloc] initWithTitle:@"请选择导航"
                                         delegate:nil
                                cancelButtonTitle:@"取消"
                           destructiveButtonTitle:nil
                                otherButtonTitles:_myNavigators[0][@"title"], nil];
    }
    else if (2 == _myNavigators.count)
    {
        as = [[UIActionSheet alloc] initWithTitle:@"请选择导航"
                                         delegate:nil
                                cancelButtonTitle:@"取消"
                           destructiveButtonTitle:nil
                                otherButtonTitles:_myNavigators[0][@"title"],_myNavigators[1][@"title"], nil];
    }
    else if (3 == _myNavigators.count)
    {
        as = [[UIActionSheet alloc] initWithTitle:@"请选择导航"
                                         delegate:nil
                                cancelButtonTitle:@"取消"
                           destructiveButtonTitle:nil
                                otherButtonTitles:_myNavigators[0][@"title"],_myNavigators[1][@"title"],_myNavigators[2][@"title"], nil];
    }
    else if (4 == _myNavigators.count)
    {
        as = [[UIActionSheet alloc] initWithTitle:@"请选择导航"
                                         delegate:nil
                                cancelButtonTitle:@"取消"
                           destructiveButtonTitle:nil
                                otherButtonTitles:_myNavigators[0][@"title"],_myNavigators[1][@"title"],_myNavigators[2][@"title"],_myNavigators[3][@"title"], nil];
    }
    
    
    return as;
}

@end
