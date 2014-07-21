//
//  PPBaseService.h
//  PigParking
//
//  Created by Vincent on 7/21/14.
//  Copyright (c) 2014 VincentStation. All rights reserved.
//

#import <Foundation/Foundation.h>

static const NSString *kApiInitDevice = @"InitDevice";
static const NSString *kApiUploadUserInfo = @"uploadUserInfo";
static const NSString *kApiQueryPoint = @"queryPoint";
static const NSString *kApiSuggest = @"suggest";
static const NSString *kApiParkingDetails = @"parkingDetail";

@interface PPBaseService : NSObject

+ (NSString *)apiForKey:(const NSString *)key;

@end
