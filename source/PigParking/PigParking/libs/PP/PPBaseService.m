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
                 kApiInitDevice:                @"/InitDevice", //70bfa77745b8e0303621a17d9f1b483a3c5d2366d0d7f7c97c6a3ed46bd2f448837d86706c0b6f2481f95e4e02579b01
                 kApiUploadUserInfo :           @"/uploadUserInfo",
                 kApiQueryPoint :               @"/queryPoint", //lat=2254812&lng=11402238 //查周边
                 kApiSuggest :                  @"/suggest",
                 kApiParkingDetails :           @"/parkingDetail"
                 };
    }
    
    return [NSString stringWithFormat:@"%@%@", PP_API_URL, [apis objectForKey:key]];
}

@end
