//
//  PPParkingDetailsViewController.m
//  PigParking
//
//  Created by VincentLi on 14-7-6.
//  Copyright (c) 2014年 VincentStation. All rights reserved.
//

#import "PPParkingDetailsViewController.h"

@interface PPParkingDetailsViewController ()

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *addressLabel;
@property (nonatomic, strong) IBOutlet UILabel *chargeLabel;
@property (nonatomic, strong) IBOutlet UILabel *parkingCountLabel;

@property (nonatomic, strong) IBOutlet UIScrollView *imagesScrollView;

@end

@implementation PPParkingDetailsViewController

- (void)dealloc
{
    self.titleLabel = nil;
    self.addressLabel = nil;
    self.chargeLabel = nil;
    self.parkingCountLabel = nil;
    
    self.imagesScrollView = nil;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = @"停车场详情";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupTheme];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonThemeItem:UIBarButtonThemeItemBack
                                                                                         target:self
                                                                                         action:@selector(btnBackClick:)];
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonThemeItem:UIBarButtonThemeItemUp
//                                                                                          target:self
//                                                                                          action:@selector(btnUpClick:)];
    
    self.titleLabel.text = _data[@"title"];
    self.addressLabel.text = _data[@"address"];
    self.chargeLabel.text = _data[@"charge"];
    self.parkingCountLabel.text = _data[@"parkingCount"];
    
    _toCoordinate = CLLocationCoordinate2DMake([_data[@"lat"] floatValue], [_data[@"lon"] floatValue]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (IBAction)btnGoHereClick:(id)sender
{
    CLLocationCoordinate2D coords1 = _fromCoordinate;
    CLLocationCoordinate2D coords2 = _toCoordinate;
    
//    {
//        NSString *urlString = @"http://api.map.baidu.com/direction?origin=latlng:30.691793,104.088264|name=x&destination=latlng:30.691393,104.085264|name:y&mode=driving&region=深圳&output=html";
////        urlString = @"http://map.baidu.com";
//        NSURL *aURL = [NSURL URLWithString:urlString];
//        BOOL x = [[UIApplication sharedApplication] openURL:aURL];
//        NSLog(@"%d", x);
//    }
    
    if (LESS_THAN_IOS6)
    {
        NSString *url_str = [[NSString alloc] initWithFormat:@"http://maps.google.com/maps?saddr=%f,%f&daddr=%f,%f&dirfl=d",
                             coords1.latitude,coords1.longitude,coords2.latitude,coords2.longitude];
        NSURL *url = [NSURL URLWithString:url_str];
        
        [[UIApplication sharedApplication] openURL:url];
    }
    else
    {
        MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
        
        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coords2 addressDictionary:nil]];
        toLocation.name = _data[@"title"];
        
        NSArray *items = [NSArray arrayWithObjects:currentLocation, toLocation, nil];
        
        NSDictionary *options = @{
                                  MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,
                                  MKLaunchOptionsMapTypeKey:[NSNumber numberWithInteger:MKMapTypeStandard],
                                  MKLaunchOptionsShowsTrafficKey:@YES
                                  };
        
        [MKMapItem openMapsWithItems:items launchOptions:options];
    }
}

- (void)btnBackClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)btnUpClick:(id)sender
{
    
}

@end
