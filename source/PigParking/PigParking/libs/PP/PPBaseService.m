//
//  PPBaseService.m
//  PigParking
//
//  Created by Vincent on 7/21/14.
//  Copyright (c) 2014 VincentStation. All rights reserved.
//

#import "PPBaseService.h"

@implementation PPBaseService

+ (NSString *)apiForKey:(const NSString *)key
{
    static NSDictionary *apis = nil;
    
    if (!apis)
    {
        apis = @{
                 kApiInitDevice:                @"/InitDevice",
                 kApiUploadUserInfo :           @"/uploadUserInfo", //imei=123456&brand=brand&os_version=IOS
                 kApiQueryPoint :               @"/queryPoint", //lat=2254812&lng=11402238 //查周边
                 kApiSuggest :                  @"/suggest", //qq=34862010&phone=123456789&content=content&lables=lables&uid=1
                 kApiParkingDetails :           @"/parkingDetail" //id=6// 详细情
                 };
    }
    
    return [NSString stringWithFormat:@"%@%@", PP_API_URL, [apis objectForKey:key]];
}

@end
