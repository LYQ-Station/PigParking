//
//  PPMapParkingAnnotationView.m
//  PigParking
//
//  Created by Vincent on 7/8/14.
//  Copyright (c) 2014 VincentStation. All rights reserved.
//

#import "PPMapParkingAnnotationView.h"

@implementation PPMapParkingAnnotationView

- (id)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        
    }
    
    return self;
}

- (void)setIsFree:(BOOL)isFree
{
    _isFree = isFree;
    
    if (isFree)
    {
        self.image = [UIImage imageNamed:@"map-free-parking"];
    }
    else
    {
        self.image = [UIImage imageNamed:@"map-nofree-parking"];
    }
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
