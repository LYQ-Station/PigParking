//
//  PPIndexModel.m
//  PigParking
//
//  Created by Vincent on 7/8/14.
//  Copyright (c) 2014 VincentStation. All rights reserved.
//

#import "PPIndexModel.h"

@interface PPIndexModel ()

@property (nonatomic, strong) AFHTTPClient *request;

@end

@implementation PPIndexModel

+ (id)model
{
    return [[PPIndexModel alloc] init];
}

- (void)cancel
{
    [_request cancelAllHTTPOperationsWithMethod:nil path:nil];
}

- (void)fetchAroundParking:(CLLocationCoordinate2D)coordinate block:(void(^)(NSArray *data, NSError *error))complete
{
    NSMutableArray *arr = [NSMutableArray array];
    NSDictionary *d = nil;
    UInt32 r = 0;
    
    for (int i=0; i<6; i++)
    {
        r = arc4random() % 100;
        
        d = @{@"id": @1,
              @"title":[NSString stringWithFormat:@"步行%d分钟", i],
              @"lat":@(coordinate.latitude+(r*0.0001f*(r%10>5?1:-1))),
              @"lon":@(coordinate.longitude+(r*0.0001f*(r%10>5?1:-1))),
              };
        
        [arr addObject:d];
    }
    
    complete(arr, nil);
}

@end
