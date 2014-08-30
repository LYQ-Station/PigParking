//
//  PPAboutViewController.m
//  PigParking
//
//  Created by VincentLi on 14-7-10.
//  Copyright (c) 2014年 VincentStation. All rights reserved.
//

#import "PPAboutViewController.h"

@interface PPAboutViewController ()

@end

@implementation PPAboutViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = @"关于我们";
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
    
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"st-logo"]];
    iv.center = CGPointMake(self.view.bounds.size.width*0.5f, 130.0f);
    [self.view addSubview:iv];
    
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 235.0f, self.view.bounds.size.width, 20.0f)];
    lb.textAlignment = NSTextAlignmentCenter;
    lb.text = @"人人停车 v1.0";
    lb.font = [UIFont systemFontOfSize:18.0f];
    lb.backgroundColor = [UIColor clearColor];
    lb.textColor = [UIColor colorWithRed:0.08f green:0.08f blue:0.08f alpha:1.0f];
    [self.view addSubview:lb];
    
    lb = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 430.0f, self.view.bounds.size.width, 50.0f)];
    lb.textAlignment = NSTextAlignmentCenter;
    lb.backgroundColor = [UIColor clearColor];
    lb.font = [UIFont systemFontOfSize:13.0f];
    lb.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleHeight;
    lb.textColor = [UIColor colorWithRed:0.51f green:0.51f blue:0.51f alpha:1.0f];
    lb.numberOfLines = 2;
    lb.text = @"流创梦工厂\n想联系我们，请发邮件至kiko@starnet007.com";
    [self.view addSubview:lb];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (void)btnBackClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
