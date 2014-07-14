//
//  PPParkingDetailsViewController.h
//  PigParking
//
//  Created by VincentLi on 14-7-6.
//  Copyright (c) 2014年 VincentStation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PPParkingDetailsViewController : UIViewController

@property (nonatomic, assign) NSDictionary *data;
@property (nonatomic, assign) CLLocationCoordinate2D fromCoordinate;
@property (nonatomic, assign) CLLocationCoordinate2D toCoordinate;

@end
