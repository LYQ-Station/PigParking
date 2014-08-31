//
//  PPMapNavigators.m
//  PigParking
//
//  Created by LiYongQiang on 14-8-31.
//  Copyright (c) 2014年 VincentStation. All rights reserved.
//

#import "PPMapNavigators.h"

@interface PPMapNavigators ()

@property (nonatomic, strong) NSMutableArray *myNavigators;

@end

@implementation PPMapNavigators

- (id)init
{
    self = [super init];
    if (self)
    {
        self.myNavigators = [NSMutableArray array];
        [_myNavigators addObject:@{@"title": @"地图导航",@"type":@"0"}];
        
        UIApplication *app = [UIApplication sharedApplication];
        
        NSURL *URL = nil;
        
        URL = [NSURL URLWithString:@"baidumap://map/direction?origin=34.264642646862,108.95108518068&destination=40.007623,116.360582&mode=driving&src=yourCompanyName|yourAppName"];
        if ([app canOpenURL:URL])
        {
            [_myNavigators addObject:@{@"title": @"百度导航",@"type":@"1"}];
        }
        
        URL = [NSURL URLWithString:@"iosamap://path?sourceApplication=%@&backScheme=%@&sid=&slat=%f&slon=%f&sname=&did=&dlat=%f&dlon=%f&dname=&dev=0&m=0&t=2"];
        if ([app canOpenURL:URL])
        {
            [_myNavigators addObject:@{@"title": @"高德导航",@"type":@"2"}];
        }
    }
    return self;
}

- (NSArray *)navigators
{
    return [NSArray arrayWithArray:_myNavigators];
}

@end
