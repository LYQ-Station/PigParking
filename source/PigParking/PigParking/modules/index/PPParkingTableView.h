//
//  PPParkingTableView.h
//  PigParking
//
//  Created by Vincent on 7/9/14.
//  Copyright (c) 2014 VincentStation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PPParkingTableView : UITableView <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) id actDelegate;

- (id)initWithFrame:(CGRect)frame data:(NSArray *)data;

@end

@protocol PPParkingTableViewActDelegate <NSObject>

@optional
- (void)parkingTableView:(PPParkingTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end
