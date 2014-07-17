//
//  PPBaseDB.h
//  PigParking
//
//  Created by Vincent on 7/17/14.
//  Copyright (c) 2014 VincentStation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPBaseDB : NSObject

@property (nonatomic, readonly) FMDatabase *db;

+ (FMDatabase *)db;

@end
