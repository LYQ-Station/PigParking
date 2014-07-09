//
//  PPIndexViewController.h
//  PigParking
//
//  Created by VincentLi on 14-7-5.
//  Copyright (c) 2014年 VincentStation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPParkingTableView.h"

@interface PPIndexViewController : UIViewController <UITextFieldDelegate, PPParkingTableViewActDelegate>

+ (UINavigationController *)navController;

@end
