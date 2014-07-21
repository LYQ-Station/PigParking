//
//  PPUser.h
//  PigParking
//
//  Created by Vincent on 7/21/14.
//  Copyright (c) 2014 VincentStation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPUser : NSObject

@property (nonatomic, readonly) NSDictionary *userInfo;

@property (nonatomic, readonly) NSString *uid;

+ (id)currentUser;

+ (void)loginUser:(NSDictionary *)userInfo;

@end
