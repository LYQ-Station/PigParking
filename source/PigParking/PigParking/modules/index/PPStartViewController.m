//
//  PPStartViewController.m
//  PigParking
//
//  Created by VincentLi on 14-7-5.
//  Copyright (c) 2014年 VincentStation. All rights reserved.
//

#import "PPStartViewController.h"
#import "PPIndexViewController.h"
#import "PPAppDelegate.h"
#import "PPMapView.h"

@interface PPStartViewController ()

@property (nonatomic, assign) PPMapView *mapView;

@end

@implementation PPStartViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView *v = [[UIView alloc] initWithFrame:self.view.bounds];
    v.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:v];
    
    _mapView = [PPMapView mapViewWithFrame:CGRectMake(50.0f, 100.0f, 120.0f, 120.0f)];
    _mapView.mapView.userInteractionEnabled = NO;
    [self.view addSubview:_mapView];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [_mapView removeFromSuperview];
    _mapView = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    PPAppDelegate *app = (PPAppDelegate *)([UIApplication sharedApplication].delegate);
    app.window.rootViewController = [PPIndexViewController navController];
}

@end
