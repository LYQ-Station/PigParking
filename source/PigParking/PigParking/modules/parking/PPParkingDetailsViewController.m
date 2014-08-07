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
#import "UIImageView+MJWebCache.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "PPParkingModel.h"
#import "PPHistoryDB.h"

@interface PPParkingDetailsViewController () <FBImagesWheelDelegate>

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
    
    self.titleLabel.text = _data[@"title"];
    self.addressLabel.text = _data[@"address"];
    self.chargeLabel.text = _data[@"charge"];
    self.parkingCountLabel.text = _data[@"parkingCount"];
    
    [self.model fetchParkingDetails:_data[@"id"]
                           complete:^(id data, NSError *error) {
                               if (error)
                               {
                                   MBProgressHUD *alert = [[MBProgressHUD alloc] initWithView:self.view];
                                   alert.labelText = error.userInfo[NSLocalizedDescriptionKey];
                                   alert.mode = MBProgressHUDModeText;
                                   [self.view addSubview:alert];
                                   [alert show:YES];
                                   [alert hide:YES afterDelay:1.5];
                                   return ;
                               }
                               
                               self.parkingInfo = data;
                               
//                               NSMutableArray *a = [NSMutableArray array];
//                               for (NSDictionary *d in data[@"images"])
//                               {
//                                   [a addObject:d[@"thumb"]];
//                               }
                               
                               [self setupImagesScrollView:data[@"samllImages"]];
                           }];
    
    _toCoordinate = MAKE_COOR_S(_data[@"lat"], _data[@"lon"]);
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
    if ([PPUser currentUser].isSaveSearchHistory)
    {
        [[PPHistoryDB db] insert:_data];
    }
    
    [PPMapView navigateFrom:_fromCoordinate to:_toCoordinate];
}

- (void)btnBackClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)btnUpClick:(id)sender
{
    
}

#pragma mark -

- (void)imageWheelDidChangeImage:(FBImagesWheel *)wheel imageView:(UIImageView *)imageView
{
    NSMutableArray *a = [NSMutableArray array];
//    for (NSDictionary *d in _parkingInfo[@"images"])
//    {
//        NSString *url = d[@"original"];
//        MJPhoto *photo = [[MJPhoto alloc] init];
//        photo.url = [NSURL URLWithString:url];
//        photo.srcImageView = imageView;
//        [a addObject:photo];
//    }
    
    for (NSString *d in _parkingInfo[@"bigImages"])
    {
        MJPhoto *photo = [[MJPhoto alloc] init];
        photo.url = [NSURL URLWithString:d];
        photo.srcImageView = imageView;
        [a addObject:photo];
    }
    
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = imageView.tag;
    browser.photos = a;
    [browser show];
}

@end
