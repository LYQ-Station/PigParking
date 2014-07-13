//
//  PPIndexViewController.h
//  PigParking
//
//  Created by VincentLi on 14-7-5.
//  Copyright (c) 2014年 VincentStation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPMapView.h"
#import "PPParkingTableView.h"
#import "PPParkingDetailsView.h"

@interface PPIndexViewController : UIViewController <UITextFieldDelegate, PPParkingTableViewActDelegate, PPMapViewDelegate, PPParkingDetailsViewDelegate>

+ (UINavigationController *)navController;

@end
