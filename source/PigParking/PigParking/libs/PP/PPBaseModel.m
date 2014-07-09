//
//  PPBaseModel.m
//  PigParking
//
//  Created by Vincent on 7/8/14.
//  Copyright (c) 2014 VincentStation. All rights reserved.
//

#import "PPBaseModel.h"

@implementation PPBaseModel

+ (NSDictionary *)makeJSONParam:(NSDictionary *)params
{
    NSData *d = [NSJSONSerialization dataWithJSONObject:params options:0 error:NULL];
    NSString *json = [[NSString alloc] initWithData:d encoding:NSUTF8StringEncoding];
    
    return @{@"V": json};
}

- (id)parseResponseData:(NSData *)data error:(NSError **)error
{
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data
                                                         options:NSJSONReadingMutableContainers
                                                           error:nil];
    
    if (!json)
    {
        *error = [NSError errorWithDomain:PP_BASE_DOMAIN
                                     code:1001
                                 userInfo:@{NSLocalizedDescriptionKey:@"服务器返回错误"}];
        
        return nil;
    }
    
    int code = [json[@"code"] intValue];
    if (code)
    {
        id msg = nil;
        
        if ([json objectForKey:@"msg"])
        {
            msg = json[@"msg"];
        }
        
        *error = [NSError errorWithDomain:PP_BASE_DOMAIN
                                     code:code
                                 userInfo:@{NSLocalizedDescriptionKey:msg}];
        
        return nil;
    }
    
    id result = json[@"data"];
    if ([result isEqual:@""])
    {
        return nil;
    }
    
    return result;
}

@end
