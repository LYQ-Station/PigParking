//
//  PPHistoryDB.h
//  PigParking
//
//  Created by Vincent on 7/29/14.
//  Copyright (c) 2014 VincentStation. All rights reserved.
//

#import "PPBaseDB.h"

@interface PPHistoryDB : PPBaseDB

@property (nonatomic, readonly) NSString *tableName;

+ (PPHistoryDB *)db;

- (NSArray *)fetchAll;

- (void)insert:(NSDictionary *)history;

@end
