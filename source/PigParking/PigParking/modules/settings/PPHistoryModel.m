//
//  PPHistoryModel.m
//  PigParking
//
//  Created by VincentLi on 14-7-16.
//  Copyright (c) 2014年 VincentStation. All rights reserved.
//

#import "PPHistoryModel.h"

@implementation PPHistoryModel

+ (id)model
{
    return [[PPHistoryModel alloc] init];
}

- (NSArray *)fetchHistory
{
//    return nil;
    
    NSMutableArray *arr = [NSMutableArray array];
    NSDictionary *d = nil;
    UInt32 r = 0;
    
    for (int i=0; i<6; i++)
    {
        r = arc4random() % 100;
        
        d = @{@"id": @1,
              @"title":[NSString stringWithFormat:@"步行%d分钟", i],
              @"lat":@(30.691393),
              @"lon":@(104.085264),
              @"charge":@"免费",
              @"distance":[NSString stringWithFormat:@"步行%d分钟", i],
              @"parkingCount":@"500",
              @"address":@"深圳市珠光村",
              @"flag":@((i+3+1)%3)
              };
        
        [arr addObject:d];
    }
    
    return arr;
}

@end
