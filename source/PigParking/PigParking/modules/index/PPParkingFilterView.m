//
//  PPParkingFilterView.m
//  PigParking
//
//  Created by VincentLi on 14-7-10.
//  Copyright (c) 2014年 VincentStation. All rights reserved.
//

#import "PPParkingFilterView.h"

@implementation PPParkingFilterView

- (id)initWithDelegate:(id)delegate
{
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"test-filter"]];
    
    self = [super initWithFrame:iv.bounds];
    if (self)
    {
        _delegate = delegate;
        
        [self addSubview:iv];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
