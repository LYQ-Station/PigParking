//
//  PPMapParkingAnnotationView.m
//  PigParking
//
//  Created by Vincent on 7/8/14.
//  Copyright (c) 2014 VincentStation. All rights reserved.
//

#import "PPMapParkingAnnotationView.h"

@interface PPMapParkingAnnotationView ()

@property (nonatomic, strong) UIImageView *ivFlagBubbleView;
@property (nonatomic, strong) UILabel *lbFlag;

@end

@implementation PPMapParkingAnnotationView

- (id)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    
    if (self)
    {
        self.ivFlagBubbleView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"ann-bubble"] resizableImageWithCapInsets:UIEdgeInsetsMake(11.0, 14.0, 17.0, 14.0)]];
        
        self.lbFlag = [[UILabel alloc] initWithFrame:CGRectZero];
        _lbFlag.font = [UIFont systemFontOfSize:13.0];
        
        self.clipsToBounds = NO;
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

- (void)setFlag:(PPParkingTableViewCellFlag)flag
{
    _flag = flag;
    
    if (PPParkingTableViewCellFlagNone == flag)
    {
        [_lbFlag removeFromSuperview];
        return;
    }
    
    NSString *s;
    CGSize sz;
    
    if (PPParkingTableViewCellFlagCheap == flag)
    {
        s = @"最便宜";
        sz = [s sizeWithFont:[UIFont systemFontOfSize:13.0f]];
    }
    else if (PPParkingTableViewCellFlagMost == flag)
    {
        s = @"车位最多";
        sz = [s sizeWithFont:[UIFont systemFontOfSize:13.0f]];
    }
    else if (PPParkingTableViewCellFlagNearest == flag)
    {
        s = @"距离最近";
        sz = [s sizeWithFont:[UIFont systemFontOfSize:13.0f]];
    }
    
    _lbFlag.text = s;
    _lbFlag.frame = CGRectMake(14.0, 3.0, sz.width, sz.height);
    _ivFlagBubbleView.frame = CGRectMake(0.0, 0.0, sz.width+14.0*2, 30.0);
    [_ivFlagBubbleView addSubview:_lbFlag];
    _ivFlagBubbleView.center = CGPointMake(self.bounds.size.width*0.5, 0-_ivFlagBubbleView.image.size.height*0.5+7.0);
    
    [self addSubview:_ivFlagBubbleView];
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
