//
//  PPBaseModel.m
//  PigParking
//
//  Created by Vincent on 7/8/14.
//  Copyright (c) 2014 VincentStation. All rights reserved.
//

#import "PPBaseModel.h"

@implementation PPBaseModel

+ (id)model
{
    return [[[self class] alloc] init];
}

+ (NSDictionary *)makeJSONParam:(NSDictionary *)params
{
    NSData *d = [NSJSONSerialization dataWithJSONObject:params options:0 error:NULL];
    NSString *json = [[NSString alloc] initWithData:d encoding:NSUTF8StringEncoding];
    
    return @{@"V": json};
}

- (id)parseResponseData:(NSData *)data error:(NSError *__autoreleasing *)error
{
    if (!data)
    {
        *error = [NSError errorWithDomain:PP_BASE_DOMAIN
                                     code:1002
                                 userInfo:@{NSLocalizedDescriptionKey:@"无效的data"}];
        
        return nil;
    }
    
    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSData *d = [str base64DecodedData];
    d = [d DESDecryptWithKey:PP_SECRET_KEY];
    
        //if cloud not decrypt data restore it!
    if (!d)
    {
        d = data;
    }
    
    *error = nil;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:d
                                                         options:NSJSONReadingMutableContainers
                                                           error:error];
    
    if (*error)
    {
        *error = [NSError errorWithDomain:PP_BASE_DOMAIN
                                     code:1002
                                 userInfo:@{NSLocalizedDescriptionKey:@"无效的json data"}];
        
        return nil;
    }
    
    if (!json)
    {
        *error = [NSError errorWithDomain:PP_BASE_DOMAIN
                                     code:1001
                                 userInfo:@{NSLocalizedDescriptionKey:@"服务器返回错误"}];
        
        return nil;
    }
    
    int code = [json[@"retcode"] intValue];
    if (code)
    {
        id msg = nil;
        
        if ([json objectForKey:@"retmsg"])
        {
            msg = json[@"retmsg"];
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
