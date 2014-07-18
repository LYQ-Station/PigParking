//
//  PPParkingDetailsViewController.m
//  PigParking
//
//  Created by VincentLi on 14-7-6.
//  Copyright (c) 2014年 VincentStation. All rights reserved.
//

#import "PPParkingDetailsViewController.h"
#import "PPParkingModel.h"
#import "PPMapView.h"
#import "FBImagesWheel.h"

@interface PPParkingDetailsViewController ()

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UILabel *addressLabel;
@property (nonatomic, strong) IBOutlet UILabel *chargeLabel;
@property (nonatomic, strong) IBOutlet UILabel *parkingCountLabel;

@property (nonatomic, strong) IBOutlet FBImagesWheel *imagesWheelView;

@property (nonatomic, strong) PPParkingModel *model;
@property (nonatomic, strong) NSDictionary *parkingInfo;

@end

@implementation PPParkingDetailsViewController

- (void)dealloc
{
    self.titleLabel = nil;
    self.addressLabel = nil;
    self.chargeLabel = nil;
    self.parkingCountLabel = nil;
    
    self.imagesWheelView = nil;
    
    self.model = nil;
    self.parkingInfo = nil;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = @"停车场详情";
        self.model = [PPParkingModel model];
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
    
    [self.model fetchParkingDetails:nil
                           complete:^(id data, NSError *error) {
                               self.titleLabel.text = _data[@"title"];
                               self.addressLabel.text = _data[@"address"];
                               self.chargeLabel.text = _data[@"charge"];
                               self.parkingCountLabel.text = _data[@"parkingCount"];
                               self.parkingInfo = data;
                               
                               NSMutableArray *a = [NSMutableArray array];
                               for (NSDictionary *d in data[@"images"])
                               {
                                   [a addObject:d[@"thumb"]];
                               }
                               
                               [self setupImagesScrollView:a];
                           }];
    
    _toCoordinate = CLLocationCoordinate2DMake([_data[@"lat"] floatValue], [_data[@"lon"] floatValue]);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (void)setupImagesScrollView:(NSArray *)images
{
    if (0 == images.count)
    {
        return;
    }
    
    [_imagesWheelView setImages:images];
}

#pragma mark -

- (IBAction)btnGoHereClick:(id)sender
{
    [PPMapView navigateFrom:_fromCoordinate to:_toCoordinate];
}

- (void)btnBackClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)btnUpClick:(id)sender
{
    
}

@end
