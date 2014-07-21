//
//  PPConfigsModel.m
//  PigParking
//
//  Created by Vincent on 7/21/14.
//  Copyright (c) 2014 VincentStation. All rights reserved.
//

#import "PPConfigsModel.h"

@implementation PPConfigsModel

- (void)fetchConfigs:(void(^)(id json, NSError *))complete
{
    NSDictionary *p = @{
                        @"imei":@"1234567",
                        @"brand":@"apple",
                        @"os_version":@"ios"
                        };
    
    NSData *jd = [NSJSONSerialization dataWithJSONObject:p options:0 error:NULL];
    
    NSString *url = [PPBaseService apiForKey:kApiUploadUserInfo];
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:jd];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:req];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSData *d = [(NSData *)responseObject DESDecryptWithKey:@"123456"];
        
//        NSData *d = [[[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding] base64DecodedData] DESDecryptWithKey:@"123456"];
        
        NSLog(@"%@", [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
        NSError *err = nil;
        NSDictionary *j = [self parseResponseData:responseObject error:&err];
        
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
}

@end
