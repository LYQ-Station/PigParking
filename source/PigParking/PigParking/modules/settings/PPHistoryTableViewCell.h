//
//  PPHistoryTableViewCell.h
//  PigParking
//
//  Created by VincentLi on 14-7-13.
//  Copyright (c) 2014年 VincentStation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PPHistoryTableViewCell : UITableViewCell

@property (nonatomic, readonly) UILabel *chargeLabel;
@property (nonatomic, readonly) UILabel *parkingCountLabel;
@property (nonatomic, readonly) UILabel *addressLabel;

+ (CGFloat)cellHeight;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;

@end
