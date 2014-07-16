//
//  PPParkingModel.m
//  PigParking
//
//  Created by VincentLi on 14-7-16.
//  Copyright (c) 2014年 VincentStation. All rights reserved.
//

#import "PPParkingModel.h"

@implementation PPParkingModel

+ (id)model
{
    return [[PPParkingModel alloc] init];
}

- (void)cancel
{
    
}

- (void)fetchAroundParking:(id)params complete:(void(^)(id data, NSError *error))complete
{
    NSDictionary *d = @{@"id": @1,
                        @"title":@"xxxx区xxx公益停车场",
                        @"lat":@(30.691393),
                        @"lon":@(104.085264),
                        @"charge":@"免费",
                        @"distance":@"步行xxx分钟",
                        @"parkingCount":@"500",
                        @"address":@"深圳市珠光村",
                        @"flag":@(0)
                        };
    
    complete(d, nil);
}

@end
