//
//  PPParkingModel.m
//  PigParking
//
//  Created by VincentLi on 14-7-16.
//  Copyright (c) 2014年 VincentStation. All rights reserved.
//

#import "PPParkingModel.h"

@implementation PPParkingModel

- (void)cancel
{
    
}

- (void)fetchAroundParking:(id)params complete:(void(^)(id data, NSError *error))complete
{
    
}

- (void)fetchParkingDetails:(id)params complete:(void(^)(id data, NSError *error))complete
{
    NSDictionary *p = @{
                        @"id":params,
                        @"uid":[PPUser currentUser].uid
                        };
    
    NSData *jd = [AFQueryStringFromParametersWithEncoding(p, NSUTF8StringEncoding) dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *url = [PPBaseService apiForKey:kApiParkingDetails];
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
        
        NSDictionary *d = @{
                            @"title":j[@"name"],
                            @"lat":j[@"lat"],
                            @"lon":j[@"lng"],
                            @"charge":j[@"price"],
                            @"distance":@"",
                            @"parkingCount":j[@"carNum"],
                            @"address":j[@"addr"],
                            @"flag":@([j[@"flag"] intValue]),
                            @"freeTime":j[@"free_time"],
                            @"fristHourCharge":j[@"frist_hour"],
                            @"fullDayCharge":j[@"highest"],
                            @"bigImages":j[@"bigPic"],
                            @"smallImages":j[@"smallPic"]
                            };
        
        complete(d, nil);
    }
                              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                  complete(nil, error);
                              }];
    
    [op start];
}

@end
