//
//  PPFeedbackModel.m
//  PigParking
//
//  Created by Vincent on 7/23/14.
//  Copyright (c) 2014 VincentStation. All rights reserved.
//

#import "PPFeedbackModel.h"

@implementation PPFeedbackModel

- (void)postFeedback:(id)params complete:(void(^)(NSError *error))complete
{
    NSDictionary *p = @{
                        @"qq":[params objectForKey:@"qq"],
                        @"phone":[params objectForKey:@"phone"],
                        @"content":[params objectForKey:@"content"],
                        @"lables":[params objectForKey:@"lables"],
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
        [self parseResponseData:responseObject error:&err];
        
        if (err)
        {
            complete(err);
            return ;
        }
        
        complete(nil);
    }
                              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                  complete(error);
                              }];
    
    [op start];
}

@end
