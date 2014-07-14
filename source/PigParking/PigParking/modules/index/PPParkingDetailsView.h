//
//  PPParkingDetailsView.h
//  PigParking
//
//  Created by VincentLi on 14-7-13.
//  Copyright (c) 2014年 VincentStation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPParkingTableViewCell.h"

@interface PPParkingDetailsView : UIView

@property (nonatomic, assign) id delegate;

@property (nonatomic, readonly) UILabel *chargeLabel;
@property (nonatomic, readonly) UILabel *distanceLabel;
@property (nonatomic, readonly) UILabel *parkingCountLabel;
@property (nonatomic, readonly) UILabel *addressLabel;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, assign) NSString *chargeText;
@property (nonatomic, assign) NSString *distanceText;
@property (nonatomic, assign) NSString *parkingCountText;
@property (nonatomic, assign) NSString *addressText;

@property (nonatomic, assign) CLLocationCoordinate2D fromCoordinate;
@property (nonatomic, assign) CLLocationCoordinate2D toCoordinate;

@property (nonatomic, assign) PPParkingTableViewCellFlag flag;

@end

@protocol PPParkingDetailsViewDelegate <NSObject>

@optional
- (void)ppParkingDetailsViewGoHere:(PPParkingDetailsView *)view;

- (void)ppParkingDetailsViewShowDetails:(PPParkingDetailsView *)view;

@end
