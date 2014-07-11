//
//  PPMapView.h
//  PigParking
//
//  Created by VincentLi on 14-7-5.
//  Copyright (c) 2014年 VincentStation. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    PPMapViewscopeModeFollow,
    PPMapViewscopeModeBrowser,
    PPMapViewscopeModeDirect
}PPMapViewscopeMode;

@interface PPMapView : UIView  <CLLocationManagerDelegate,BMKMapViewDelegate,BMKRouteSearchDelegate>

@property (nonatomic, assign) id delegate;
@property (nonatomic, readonly) BMKMapView *mapView;
@property (nonatomic, assign) PPMapViewscopeMode scopeMode;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

+ (PPMapView *)sharedInstance;

+ (PPMapView *)mapViewWithFrame:(CGRect)frame;

- (void)startUpdatingLocation;

- (void)updateUserLocation:(CLLocationCoordinate2D)coordinate;

- (void)showAroundParking:(NSArray *)list;

- (void)zoomIn;

- (void)zoomOut;

@end

@protocol PPMapViewDelegate <NSObject>

@optional
- (void)ppMapView:(PPMapView *)mapView didUpdateToLocation:(CLLocation *)newLocation;

@end
