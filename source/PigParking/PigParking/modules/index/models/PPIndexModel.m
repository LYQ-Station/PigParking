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
    
    CLLocationCoordinate2D coor;
    
    for (int i=0; i<6; i++)
    {
        r = arc4random() % 100;
        
        coor = CLLocationCoordinate2DMake(coordinate.latitude+(r*0.0001f*(r%10>5?1:-1)), coordinate.longitude+(r*0.0001f*(r%10>5?1:-1)));
        coor = BMKCoorDictionaryDecode(BMKConvertBaiduCoorFrom(coor, BMK_COORDTYPE_GPS));
        
        d = @{@"id": @1,
              @"title":[NSString stringWithFormat:@"步行%d分钟", i],
              @"lat":@(coor.latitude),
              @"lon":@(coor.longitude),
              @"charge":@"免费",
              @"distance":[NSString stringWithFormat:@"步行%d分钟", i],
              @"parkingCount":@"500",
              @"address":@"深圳市珠光村",
              @"flag":@((i+3+1)%3)
              };
        
        [arr addObject:d];
    }
    
    complete(arr, nil);
}

@end
