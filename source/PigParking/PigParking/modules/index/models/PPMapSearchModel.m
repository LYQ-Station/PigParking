//
//  PPMapSearchModel.m
//  PigParking
//
//  Created by VincentLi on 14-7-15.
//  Copyright (c) 2014年 VincentStation. All rights reserved.
//

#import "PPMapSearchModel.h"

@implementation PPMapSearchModel

+ (id)model
{
    return [[PPMapSearchModel alloc] init];
}

- (NSArray *)fetchHistoryList
{
//    return nil;
    
    NSMutableArray *a = [NSMutableArray array];
    
    for (int i=0; i<20; i++)
    {
        [a addObject:@{@"id": @1,
                       @"title":[NSString stringWithFormat:@"深圳市宝安地点 ＃%d", i],
                       @"lat":@(30.691393),
                       @"lon":@(104.085264),
                       @"charge":@"免费",
                       @"distance":[NSString stringWithFormat:@"步行%d分钟", i],
                       @"parkingCount":@"500",
                       @"address":@"深圳市盐田村",
                       @"flag":@((i+3+1)%3)
                       }];
    }
    
    return a;
}

- (void)doSearch:(NSString *)keyword complete:(void(^)(NSArray *data, NSError *error))complete
{
    NSMutableArray *a = [NSMutableArray array];
    
    for (int i=0; i<20; i++)
    {
        [a addObject:@{@"id": @1,
                       @"title":[NSString stringWithFormat:@"南山地点 ＃%d", i],
                       @"lat":@(30.691393),
                       @"lon":@(104.085264),
                       @"parkingCount":@"200",
                       @"address":@"深圳市南山松坪村"
                       }];
    }
    
    complete(a, nil);
}

@end
