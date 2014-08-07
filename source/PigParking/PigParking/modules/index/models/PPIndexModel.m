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

- (void)cancel
{
    [_request cancelAllHTTPOperationsWithMethod:nil path:nil];
}

- (void)fetchAroundParking:(CLLocationCoordinate2D)coordinate params:(NSDictionary *)params block:(void(^)(NSArray *data, NSError *error))complete
{
    NSDictionary *p = @{
                        @"lat":[NSString stringWithFormat:@"%u", (uint)(coordinate.latitude*100000)],
                        @"lng":[NSString stringWithFormat:@"%u", (uint)(coordinate.longitude*100000)],
                        @"distance":(params && params[@"distance"])?params[@"distance"]:@"300",
                        @"uid":[PPUser currentUser].uid
                        };
    
//    NSDictionary *p = @{
//                        @"lat":@"2255355",
//                        @"lng":@"11409940",
//                        @"distance":@"1000",
//                        @"uid":[PPUser currentUser].uid
//                        };
    
    NSData *jd = [AFQueryStringFromParametersWithEncoding(p, NSUTF8StringEncoding) dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *url = [PPBaseService apiForKey:kApiQueryPoint];
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:jd];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:req];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *err = nil;
        id j = [self parseResponseData:responseObject error:&err];
        
        if (err)
        {
            complete(nil, err);
            return ;
        }
        
        NSMutableArray *arr = [NSMutableArray array];
        NSDictionary *nd = nil;
        for (NSDictionary *d in j)
        {
            nd = @{@"id": d[@"id"],
                   @"title":d[@"name"],
                   @"lat":d[@"lat"],
                   @"lon":d[@"lng"],
                   @"charge":d[@"price"],
                   @"distance":@"0",
                   @"parkingCount":d[@"carNum"],
                   @"address":d[@"addr"],
                   @"flag":d[@"type"]
                   };
            
            [arr addObject:nd];
        }
        
        complete(arr, nil);
    }
                              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                  complete(nil, error);
                              }];
    
    [op start];
    
//    NSMutableArray *arr = [NSMutableArray array];
//    NSDictionary *d = nil;
//    UInt32 r = 0;
//
//    CLLocationCoordinate2D coor;
//
//    for (int i=0; i<6; i++)
//    {
//        r = arc4random() % 100;
//
//        coor = CLLocationCoordinate2DMake(coordinate.latitude+(r*0.0001f*(r%10>5?1:-1)), coordinate.longitude+(r*0.0001f*(r%10>5?1:-1)));
//        coor = BMKCoorDictionaryDecode(BMKConvertBaiduCoorFrom(coor, BMK_COORDTYPE_GPS));
//
//        d = @{@"id": @1,
//              @"title":[NSString stringWithFormat:@"步行%d分钟", i],
//              @"lat":@(coor.latitude),
//              @"lon":@(coor.longitude),
//              @"charge":@"免费",
//              @"distance":[NSString stringWithFormat:@"步行%d分钟", i],
//              @"parkingCount":@"500",
//              @"address":@"深圳市珠光村",
//              @"flag":@((i+3+1)%3)
//              };
//
//        [arr addObject:d];
//    }
//    
//    complete(arr, nil);
}

@end
