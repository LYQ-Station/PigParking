//
//  PPParkingTableViewCell.h
//  PigParking
//
//  Created by Vincent on 7/9/14.
//  Copyright (c) 2014 VincentStation. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    PPParkingTableViewCellFlagNone = 0,
    PPParkingTableViewCellFlagCheap,
    PPParkingTableViewCellFlagNearest,
    PPParkingTableViewCellFlagMost
} PPParkingTableViewCellFlag;

@interface PPParkingTableViewCell : UITableViewCell
{
    UIImageView *_flagImageView;
}

@property (nonatomic, readonly) UILabel *chargeLabel;
@property (nonatomic, readonly) UILabel *distanceLabel;
@property (nonatomic, readonly) UILabel *parkingCountLabel;
@property (nonatomic, readonly) UILabel *addressLabel;

@property (nonatomic, assign) PPParkingTableViewCellFlag flag;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@end
