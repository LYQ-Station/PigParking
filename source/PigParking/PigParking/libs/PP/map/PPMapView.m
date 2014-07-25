//
//  PPMapView.m
//  PigParking
//
//  Created by VincentLi on 14-7-5.
//  Copyright (c) 2014年 VincentStation. All rights reserved.
//

#import "PPMapView.h"
#import "PPMapAnnoation.h"
#import "PPMapUserAnnotationView.h"
#import "PPMapParkingAnnotationView.h"

@interface PPMapView ()

@property (nonatomic, strong) PPMapAnnoation *userAnnotation;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) BMKRouteSearch *routeSearch;

@end

@implementation PPMapView

static PPMapView *__instance = nil;

+ (PPMapView *)sharedInstance
{
    if (!__instance)
    {
        return [PPMapView mapViewWithFrame:CGRectZero];
    }
    
    return __instance;
}

+ (PPMapView *)mapViewWithFrame:(CGRect)frame
{
    if (!__instance)
    {
        __instance = [[PPMapView alloc] initWithFrame:frame];
    }
    
    __instance.frame = frame;
    __instance.mapView.frame = __instance.bounds;
    
    return __instance;
}

+ (void)navigateFrom:(CLLocationCoordinate2D)from to:(CLLocationCoordinate2D)to
{
        //from Baidu to GPS
    from.latitude -= 0.0060f;
    from.longitude -= 0.0065f;
    
    to.latitude -= 0.0060f;
    to.longitude -= 0.0065f;
    
//    {
//        NSString *urlString = @"http://api.map.baidu.com/direction?origin=latlng:30.691793,104.088264|name=x&destination=latlng:30.691393,104.085264|name:y&mode=driving&region=深圳&output=html";
////        urlString = @"http://map.baidu.com";
//        NSURL *aURL = [NSURL URLWithString:urlString];
//        BOOL x = [[UIApplication sharedApplication] openURL:aURL];
//        NSLog(@"%d", x);
//    }
    
    if (LESS_THAN_IOS6)
    {
        NSString *url_str = [[NSString alloc] initWithFormat:@"http://maps.google.com/maps?saddr=%f,%f&daddr=%f,%f&dirfl=d",
                             from.latitude, from.longitude, to.latitude, to.longitude];
        NSURL *url = [NSURL URLWithString:url_str];
        
        [[UIApplication sharedApplication] openURL:url];
    }
    else
    {
        //当前的位置
        MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
        
        //起点
        //        MKMapItem *currentLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coords1 addressDictionary:nil]];
        
        //目的地的位置
        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:to addressDictionary:nil]];
//        toLocation.name = _title;
        
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
        
        //打开苹果自身地图应用，并呈现特定的item
        [MKMapItem openMapsWithItems:items launchOptions:options];
    }
}

- (void)dealloc
{
    _mapView.delegate = nil;
    _routeSearch.delegate = nil;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _scopeMode = PPMapViewscopeModeFollow;
        
        _mapView = [[BMKMapView alloc] initWithFrame:self.bounds];
        _mapView.delegate = self;
        [self addSubview:_mapView];
        
        self.routeSearch = [[BMKRouteSearch alloc] init];
        _routeSearch.delegate = self;
        
        self.locationManager = [[CLLocationManager alloc] init];
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        [_locationManager setDistanceFilter:500.0f];
        [_locationManager setDelegate:self];
    }
    return self;
}

- (CLLocationCoordinate2D)coordinate
{
    return _userAnnotation.coordinate;
}

#pragma mark - show annotation

- (void)startUpdatingLocation
{
    _scopeMode = PPMapViewscopeModeFollow;
    
    [_locationManager stopUpdatingLocation];
    [_locationManager startUpdatingLocation];
}

- (void)updateUserLocation:(CLLocationCoordinate2D)coordinate
{
    if (PPMapViewscopeModeFollow == _scopeMode || PPMapViewscopeModeDirect == _scopeMode)
    {
        [_mapView setRegion:BMKCoordinateRegionMake(coordinate, BMKCoordinateSpanMake(0.005, 0.005)) animated:YES];
    }
    
    if (!_userAnnotation)
    {
        _userAnnotation = [[PPMapAnnoation alloc] init];
        _userAnnotation.type = PPMapAnnoationTypeUser;
        _userAnnotation.coordinate = coordinate;
        
        [_mapView addAnnotation:_userAnnotation];
        
        return;
    }
    
    _userAnnotation.coordinate = coordinate;
}

- (void)showAroundParking:(NSArray *)list
{
    NSArray *a = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:a];
    
    NSMutableArray *arr = [NSMutableArray array];
    PPMapAnnoation *ann = nil;
    
    for (NSDictionary *d in list)
    {
        ann = [[PPMapAnnoation alloc] init];
        ann.title = d[@"title"];
        ann.coordinate = MAKE_COOR_S(d[@"lat"], d[@"lon"]);
        ann.type = PPMapAnnoationTypeParking;
        ann.data = d;
        [arr addObject:ann];
    }
    
    if (_userAnnotation)
    {
        [arr addObject:_userAnnotation];
    }
    
    [_mapView addAnnotations:arr];
}

#pragma mark - zoom 

- (void)zoomIn
{
    [_mapView zoomIn];
}

- (void)zoomOut
{
    [_mapView zoomOut];
}

#pragma mark - baidu mapview delegate

- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
    PPMapAnnoation *a = (PPMapAnnoation *)annotation;
    
    if (PPMapAnnoationTypeUser == a.type)
    {
        PPMapUserAnnotationView *v = [[PPMapUserAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"user"];
        return v;
    }
    else if (PPMapAnnoationTypeParking == a.type)
    {
        PPMapParkingAnnotationView *v = nil;
        
        v = (PPMapParkingAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"parking"];
        if (!v)
        {
            v = [[PPMapParkingAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"parking"];
        }
        
        return v;
    }
    
    return nil;
}

- (void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view
{
    NSArray *os = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:os];
    
    if (_delegate && [_delegate respondsToSelector:@selector(ppMapView:didDeselectAnnotation:)])
    {
        [_delegate performSelector:@selector(ppMapView:didDeselectAnnotation:) withObject:self withObject:(PPMapAnnoation *)(view.annotation)];
    }
}

- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    NSArray *os = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:os];
    
    BMKPlanNode *n_start = [[BMKPlanNode alloc] init];
    n_start.pt = _userAnnotation.coordinate;
    
    BMKPlanNode *n_end = [[BMKPlanNode alloc] init];
    n_end.pt = ((BMKPointAnnotation *)view.annotation).coordinate;
    
//    BMKDrivingRoutePlanOption *p = [[BMKDrivingRoutePlanOption alloc] init];
//    p.from = n_start;
//    p.to = n_end;
//    
//    if (![_routeSearch drivingSearch:p])
//    {
//        NSLog(@"error: BMKRouteSearch fail");
//    }
    
    BMKWalkingRoutePlanOption *w = [[BMKWalkingRoutePlanOption alloc] init];
    w.from = n_start;
    w.to = n_end;
    if (![_routeSearch walkingSearch:w])
    {
        NSLog(@"error: BMKRouteSearch fail");
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(ppMapView:didSelectAnnotation:)])
    {
        [_delegate performSelector:@selector(ppMapView:didSelectAnnotation:) withObject:self withObject:(PPMapAnnoation *)(view.annotation)];
    }
    
    CLLocationCoordinate2D center;
    BMKCoordinateRegion region;
    
    if (n_end.pt.latitude > n_start.pt.latitude)
    {
        center.latitude = n_start.pt.latitude + (n_end.pt.latitude - n_start.pt.latitude) * 0.5;
    }
    else
    {
        center.latitude = n_end.pt.latitude + (n_start.pt.latitude - n_end.pt.latitude) * 0.5;
    }
    
    if (n_end.pt.longitude > n_start.pt.longitude)
    {
        center.longitude = n_start.pt.longitude + (n_end.pt.longitude - n_start.pt.longitude) * 0.5;
    }
    else
    {
        center.longitude = n_end.pt.longitude + (n_start.pt.longitude - n_end.pt.longitude) * 0.5;
    }
    
    region = [_mapView regionThatFits:BMKCoordinateRegionMake(center, BMKCoordinateSpanMake(ABS(n_start.pt.latitude - n_end.pt.latitude), ABS(n_start.pt.longitude - n_end.pt.longitude)))];
    [_mapView setRegion:region animated:YES];
}

- (BMKOverlayView *) mapView:(BMKMapView *)mapView viewForOverlay:(id< BMKOverlay >)overlay
{
    BMKPolylineView *v = [[BMKPolylineView alloc] initWithPolyline:overlay];
    v.fillColor = [UIColor colorWithRed:0.34f green:0.69f blue:0.92f alpha:1.0f];
    v.strokeColor = [UIColor colorWithRed:0.34f green:0.69f blue:0.92f alpha:1.0f];
    v.lineWidth = 4.0f;
    return v;
}

#pragma mark - route search delegate

- (void)onGetDrivingRouteResult:(BMKRouteSearch *)searcher result:(BMKDrivingRouteResult *)result errorCode:(BMKSearchErrorCode)error
{
    BMKDrivingRouteLine *l = (BMKDrivingRouteLine *)(result.routes[0]);
    
    CLLocationCoordinate2D *cs = (CLLocationCoordinate2D *)malloc(sizeof(CLLocationCoordinate2D) * l.steps.count);
    CLLocationCoordinate2D *cs_p = cs;
    
    for (BMKDrivingStep *p in l.steps)
    {
        *cs_p = p.entrace.location;
        cs_p++;
    }
    
    BMKPolyline *pl = [BMKPolyline polylineWithCoordinates:cs count:l.steps.count];
    [_mapView addOverlay:pl];
    
    free(cs);
}

- (void)onGetWalkingRouteResult:(BMKRouteSearch *)searcher result:(BMKWalkingRouteResult *)result errorCode:(BMKSearchErrorCode)error
{
    BMKWalkingRouteLine *l = (BMKWalkingRouteLine *)(result.routes[0]);
    
    CLLocationCoordinate2D *cs = (CLLocationCoordinate2D *)malloc(sizeof(CLLocationCoordinate2D) * l.steps.count);
    CLLocationCoordinate2D *cs_p = cs;
    
    for (BMKWalkingStep *p in l.steps)
    {
        *cs_p = p.entrace.location;
        cs_p++;
    }
    
    BMKPolyline *pl = [BMKPolyline polylineWithCoordinates:cs count:l.steps.count];
    [_mapView addOverlay:pl];
    
    free(cs);
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"Unable to find current location. error: %@",error);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    if (PPMapViewscopeModeFollow != _scopeMode)
    {
        return;
    }
    
    CLLocationCoordinate2D coor = [locations[0] coordinate];
    coor = BMKCoorDictionaryDecode(BMKConvertBaiduCoorFrom(coor, BMK_COORDTYPE_GPS));
    
    [self updateUserLocation:coor];
    
    if (_delegate && [_delegate respondsToSelector:@selector(ppMapView:didUpdateToLocation:)])
    {
        [_delegate performSelector:@selector(ppMapView:didUpdateToLocation:)
                        withObject:self
                        withObject:[[CLLocation alloc] initWithLatitude:coor.latitude longitude:coor.longitude]];
    }
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    CLLocationCoordinate2D coor = newLocation.coordinate;
    coor = BMKCoorDictionaryDecode(BMKConvertBaiduCoorFrom(coor, BMK_COORDTYPE_GPS));
    
    [self updateUserLocation:coor];
    
    if (_delegate && [_delegate respondsToSelector:@selector(ppMapView:didUpdateToLocation:)])
    {
        [_delegate performSelector:@selector(ppMapView:didUpdateToLocation:)
                        withObject:self
                        withObject:[[CLLocation alloc] initWithLatitude:coor.latitude longitude:coor.longitude]];
    }
}

@end
