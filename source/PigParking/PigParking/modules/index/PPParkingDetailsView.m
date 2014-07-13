//
//  PPParkingDetailsView.m
//  PigParking
//
//  Created by VincentLi on 14-7-13.
//  Copyright (c) 2014年 VincentStation. All rights reserved.
//

#import "PPParkingDetailsView.h"

@implementation PPParkingDetailsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIImage *im = [[UIImage imageNamed:@"parking-details-pull-view-bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(6.0f, 6.0f, 6.0f, 6.0f)];
        UIImageView *iv = [[UIImageView alloc] initWithFrame:frame];
        iv.image = im;
        [self addSubview:iv];
        
        _chargeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0f, 11.0f, self.bounds.size.width, 14.0f)];
        _chargeLabel.font = [UIFont systemFontOfSize:14.0];
        _chargeLabel.textColor = [UIColor colorWithRed:0.4f green:0.4f blue:0.4f alpha:1.0f];
        _chargeLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_chargeLabel];
        
        _distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0f, _chargeLabel.frame.origin.y+_chargeLabel.frame.size.height+5.0f, self.bounds.size.width, 14.0f)];
        _distanceLabel.font = [UIFont systemFontOfSize:14.0];
        _distanceLabel.textColor = [UIColor colorWithRed:0.4f green:0.4f blue:0.4f alpha:1.0f];
        _distanceLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_distanceLabel];
        
        _parkingCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0f, _distanceLabel.frame.origin.y+_distanceLabel.frame.size.height+5.0f, self.bounds.size.width, 14.0f)];
        _parkingCountLabel.font = [UIFont systemFontOfSize:14.0];
        _parkingCountLabel.textColor = [UIColor colorWithRed:0.4f green:0.4f blue:0.4f alpha:1.0f];
        _parkingCountLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_parkingCountLabel];
        
        _addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0f, _parkingCountLabel.frame.origin.y+_parkingCountLabel.frame.size.height+5.0f, self.bounds.size.width, 14.0f)];
        _addressLabel.font = [UIFont systemFontOfSize:14.0];
        _addressLabel.textColor = [UIColor colorWithRed:0.4f green:0.4f blue:0.4f alpha:1.0f];
        _addressLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_addressLabel];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(12.0f, 78.0f, 147.0f, 66.0f);
        [btn setImage:[UIImage imageNamed:@"idx-btn-go-here"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnGoHereClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(164.0f, 78.0f, 147.0f, 66.0f);
        [btn setImage:[UIImage imageNamed:@"idx-btn-details"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnShowDetailsClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
    return self;
}

- (void)setChargeText:(NSString *)chargeText
{
    _chargeLabel.text = [NSString stringWithFormat:@"费用：%@", chargeText];
}

-(void)setDistanceText:(NSString *)distanceText
{
    _distanceLabel.text = [NSString stringWithFormat:@"距离：%@", distanceText];
}

- (void)setParkingCountText:(NSString *)parkingCountText
{
    _parkingCountLabel.text = [NSString stringWithFormat:@"车位：%@", parkingCountText];
}

- (void)setAddressText:(NSString *)addressText
{
    _addressLabel.text = [NSString stringWithFormat:@"地址：%@", addressText];
}

- (void)setFlag:(PPParkingTableViewCellFlag)flag
{
    if (PPParkingTableViewCellFlagNone == flag)
    {
        
    }
    else
    {
        UIImageView *fv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"parking-cell-flag1"]];
        fv.frame = CGRectMake(self.bounds.size.width-fv.bounds.size.width-15.0f, 0.0f, fv.bounds.size.width, fv.bounds.size.height);
        [self addSubview:fv];
    }
}

#pragma mark - 

- (void)btnGoHereClick
{
    
    CLLocationCoordinate2D coords1 =
    CLLocationCoordinate2DMake(30.691793,104.088264);
    CLLocationCoordinate2D coords2 =
    CLLocationCoordinate2DMake(30.691293,104.088264);
    
//    {
//        NSString *urlString = @"http://api.map.baidu.com/direction?origin=latlng:30.691793,104.088264|name=x&destination=latlng:30.691393,104.085264|name:y&mode=driving&region=深圳&output=html";
////        urlString = @"http://map.baidu.com";
//        NSURL *aURL = [NSURL URLWithString:urlString];
//        BOOL x = [[UIApplication sharedApplication] openURL:aURL];
//        NSLog(@"%d", x);
//    }
    
//    if (SYSTEM_VERSION_LESS_THAN(@"6.0"))// ios6以下，调用google map
//    {
        NSString *urlString = [[NSString alloc]
                               initWithFormat:@"http://maps.google.com/maps?saddr=%f,%f&daddr=%f,%f&dirfl=d",
                               coords1.latitude,coords1.longitude,coords2.latitude,coords2.longitude];
        NSURL *aURL = [NSURL URLWithString:urlString];
    
        [[UIApplication sharedApplication] openURL:aURL];
//    }else// 直接调用ios自己带的apple map
//    {
//        //当前的位置
//        //MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
//        //起点
//        MKMapItem *currentLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coords1 addressDictionary:nil]];
//        //目的地的位置
//        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coords2 addressDictionary:nil]];
//        toLocation.name = @"目的地";
//        NSArray *items = [NSArray arrayWithObjects:currentLocation, toLocation, nil];
//        
//        /*
//         //keys
//         MKLaunchOptionsMapCenterKey:地图中心的坐标(NSValue)
//         MKLaunchOptionsMapSpanKey:地图显示的范围(NSValue)
//         MKLaunchOptionsShowsTrafficKey:是否显示交通信息(boolean NSNumber)
//         
//         //MKLaunchOptionsDirectionsModeKey: 导航类型(NSString)
//         {
//         MKLaunchOptionsDirectionsModeDriving:驾车
//         MKLaunchOptionsDirectionsModeWalking:步行
//         }
//         
//         //MKLaunchOptionsMapTypeKey:地图类型(NSNumber)
//         enum {
//         MKMapTypeStandard = 0,
//         MKMapTypeSatellite,
//         MKMapTypeHybrid
//         };
//         */
//        NSDictionary *options = @{
//                                  MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,
//                                  MKLaunchOptionsMapTypeKey:[NSNumber numberWithInteger:MKMapTypeStandard],
//                                  MKLaunchOptionsShowsTrafficKey:@YES
//                                  };
//        //打开苹果自身地图应用，并呈现特定的item  
//        [MKMapItem openMapsWithItems:items launchOptions:options];  
//    }
    return;
    
    if (_delegate && [_delegate respondsToSelector:@selector(ppParkingDetailsViewGoHere:)])
    {
        [_delegate performSelector:@selector(ppParkingDetailsViewGoHere:) withObject:self];
    }
}

- (void)btnShowDetailsClick
{
    if (_delegate && [_delegate respondsToSelector:@selector(ppParkingDetailsViewShowDetails:)])
    {
        [_delegate performSelector:@selector(ppParkingDetailsViewShowDetails:) withObject:self];
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
