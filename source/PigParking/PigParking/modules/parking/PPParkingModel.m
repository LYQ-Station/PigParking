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
        
        complete(j, nil);
    }
                              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                  complete(nil, error);
                              }];
    
    [op start];
    
//    NSDictionary *d = @{@"id": @1,
//                        @"title":@"xxxx区xxx公益停车场",
//                        @"lat":@(30.691393),
//                        @"lon":@(104.085264),
//                        @"charge":@"免费",
//                        @"distance":@"步行xxx分钟",
//                        @"parkingCount":@"500",
//                        @"address":@"深圳市珠光村",
//                        @"flag":@(0),
//                        @"images":@[@{@"thumb":@"http://img.pconline.com.cn/images/upload/upc/tx/auto5/1108/24/c20/8755883_8755883_1314179993130_120x90.jpg", @"original":@"http://img.pconline.com.cn/images/upload/upc/tx/auto5/1108/24/c20/8755883_8755883_1314180016869_800x600.jpg"},
//                                    @{@"thumb":@"http://img.pconline.com.cn/images/upload/upc/tx/auto5/1108/24/c20/8755883_8755883_1314180016869_120x90.jpg", @"original":@"http://img.pconline.com.cn/images/upload/upc/tx/auto5/1108/24/c20/8755883_8755883_1314180096203_800x600.jpg"},
//                                    @{@"thumb":@"http://img.pconline.com.cn/images/upload/upc/tx/auto5/1108/24/c20/8755883_8755883_1314180096203_120x90.jpg", @"original":@"http://img.pconline.com.cn/images/upload/upc/tx/auto5/1111/08/c4/9546414_9546414_1320725993125_800x600.jpg"},
//                                    @{@"thumb":@"http://img.pconline.com.cn/images/upload/upc/tx/auto5/1108/24/c20/8755883_8755883_1314179996120_120x90.jpg", @"original":@"http://img.pconline.com.cn/images/upload/upc/tx/auto5/1108/24/c20/8755883_8755883_1314179996120_800x600.jpg"},
//                                    @{@"thumb":@"http://img.pconline.com.cn/images/upload/upc/tx/auto5/1108/24/c20/8755883_8755883_1314180134788_120x90.jpg", @"original":@"http://img.pconline.com.cn/images/upload/upc/tx/auto5/1108/24/c20/8755883_8755883_1314180134788_800x600.jpg"}
//                                    ]
//                        };
//    
//    complete(d, nil);
}

@end
