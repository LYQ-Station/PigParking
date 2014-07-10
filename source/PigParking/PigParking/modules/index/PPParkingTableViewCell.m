//
//  PPParkingTableViewCell.m
//  PigParking
//
//  Created by Vincent on 7/9/14.
//  Copyright (c) 2014 VincentStation. All rights reserved.
//

#import "PPParkingTableViewCell.h"

@implementation PPParkingTableViewCell

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        _chargeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0f, 11.0f, self.bounds.size.width, 14.0f)];
        _chargeLabel.font = [UIFont systemFontOfSize:14.0];
        _chargeLabel.textColor = [UIColor colorWithRed:0.4f green:0.4f blue:0.4f alpha:1.0f];
        [self addSubview:_chargeLabel];
        
        _distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0f, _chargeLabel.frame.origin.y+_chargeLabel.frame.size.height+5.0f, self.bounds.size.width, 14.0f)];
        _distanceLabel.font = [UIFont systemFontOfSize:14.0];
        _distanceLabel.textColor = [UIColor colorWithRed:0.4f green:0.4f blue:0.4f alpha:1.0f];
        [self addSubview:_distanceLabel];
        
        _parkingCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0f, _distanceLabel.frame.origin.y+_distanceLabel.frame.size.height+5.0f, self.bounds.size.width, 14.0f)];
        _parkingCountLabel.font = [UIFont systemFontOfSize:14.0];
        _parkingCountLabel.textColor = [UIColor colorWithRed:0.4f green:0.4f blue:0.4f alpha:1.0f];
        [self addSubview:_parkingCountLabel];
        
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0f, _parkingCountLabel.frame.origin.y+_parkingCountLabel.frame.size.height+5.0f, self.bounds.size.width, 14.0f)];
        _addressLabel.font = [UIFont systemFontOfSize:14.0];
        _addressLabel.textColor = [UIColor colorWithRed:0.4f green:0.4f blue:0.4f alpha:1.0f];
        [self addSubview:_addressLabel];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark -

- (void)setFlag:(PPParkingTableViewCellFlag)flag
{
    if (PPParkingTableViewCellFlagNone == flag)
    {
        [_flagImageView removeFromSuperview];
        _flagImageView = nil;
    }
    else
    {
        _flagImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"parking-cell-flag1"]];
        _flagImageView.frame = CGRectMake(self.bounds.size.width-_flagImageView.bounds.size.width-15.0f, 0.0f, _flagImageView.bounds.size.width, _flagImageView.bounds.size.height);
        [self addSubview:_flagImageView];
    }
}

@end