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

- (void)removeAll;

- (void)insert:(NSDictionary *)history;

- (void)remove:(NSString *)rid;

@end
