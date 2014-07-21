//
//  PPBaseModel.h
//  PigParking
//
//  Created by Vincent on 7/8/14.
//  Copyright (c) 2014 VincentStation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPBaseModel : NSObject

+ (id)model;

+ (NSDictionary *)makeJSONParam:(NSDictionary *)params;

- (id)parseResponseData:(NSData *)data error:(NSError **)error;

@end
