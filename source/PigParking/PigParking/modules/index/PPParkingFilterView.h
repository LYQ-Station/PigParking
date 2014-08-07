//
//  PPParkingFilterView.h
//  PigParking
//
//  Created by VincentLi on 14-7-10.
//  Copyright (c) 2014年 VincentStation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PPParkingFilterView : UIView

@property (nonatomic, assign) id delegate;

- (id)initWithDelegate:(id)delegate;

@end

@protocol ParkingFilterViewDelegate <NSObject>

- (void)parkingFilterViewDidSelectOption:(PPParkingFilterView *)view options:(NSDictionary *)options;

@end
