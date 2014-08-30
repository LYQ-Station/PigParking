//
//  PPMapView.h
//  PigParking
//
//  Created by VincentLi on 14-7-5.
//  Copyright (c) 2014年 VincentStation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPMapAnnoation.h"

typedef enum {
    PPMapViewscopeModeFollow,
    PPMapViewscopeModeBrowser,
    PPMapViewscopeModeDirect
}PPMapViewscopeMode;

@class PPMapAnnoation;

@interface PPMapView : UIView  <CLLocationManagerDelegate,BMKMapViewDelegate,BMKRouteSearchDelegate>

@property (nonatomic, assign) id delegate;
@property (nonatomic, readonly) BMKMapView *mapView;
@property (nonatomic, readonly) BMKMapView *tempMapView; //for calculator region only!
@property (nonatomic, assign) PPMapViewscopeMode scopeMode;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly, copy) NSString *city;

+ (PPMapView *)sharedInstance;

+ (PPMapView *)mapViewWithFrame:(CGRect)frame;

+ (void)navigateFrom:(CLLocationCoordinate2D)from to:(CLLocationCoordinate2D)to;

- (void)startUpdatingLocation;

- (void)updateUserLocation:(CLLocationCoordinate2D)coordinate;

- (void)showAroundParking:(NSArray *)list;

- (void)zoomIn;

- (void)zoomOut;

@end

@protocol PPMapViewDelegate <NSObject>

@optional
- (void)ppMapView:(PPMapView *)mapView didUpdateToLocation:(CLLocation *)newLocation;

- (void)ppMapView:(PPMapView *)mapView didSelectAnnotation:(PPMapAnnoation *)annotation;

- (void)ppMapView:(PPMapView *)mapView didDeselectAnnotation:(PPMapAnnoation *)annotation;

@end
