//
//  PPHistoryDB.m
//  PigParking
//
//  Created by Vincent on 7/29/14.
//  Copyright (c) 2014 VincentStation. All rights reserved.
//

#import "PPHistoryDB.h"

@implementation PPHistoryDB

+ (PPHistoryDB *)db
{
    return [[PPHistoryDB alloc] init];
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _tableName = @"tab_history";
    }
    return self;
}

- (NSArray *)fetchAll
{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@", _tableName];
    FMResultSet *res = [self.db executeQuery:sql];
    
    if (res)
    {
        NSMutableArray *a = [NSMutableArray array];
        while ([res next])
        {
            [a addObject:@{@"id":[res stringForColumn:@"id"],
                           @"title":[res stringForColumn:@"title"],
                           @"lat":[res stringForColumn:@"lat"],
                           @"lon":[res stringForColumn:@"lon"],
                           @"charge":[res stringForColumn:@"charge"],
                           @"parkingCount":[res stringForColumn:@"parkingCount"],
                           @"address":[res stringForColumn:@"address"],
                           @"flag":[res stringForColumn:@"flag"],
                           }];
        }
        
        return a;
    }
    
    return nil;
}

- (void)removeAll
{
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE 1", _tableName];
    [self.db executeUpdate:sql];
}

- (void)insert:(NSDictionary *)history
{
    {
        NSString *sql = [NSString stringWithFormat:@"SELECT COUNT(*) FROM %@ WHERE id=%d", _tableName, [history[@"id"] intValue]];
        FMResultSet *res = [self.db executeQuery:sql];
        [res next];
        
        if (res && 0 != [res intForColumnIndex:0])
        {
            return;
        }
    }
    
    NSDictionary *d = @{@"id": history[@"id"],
                        @"title": history[@"title"],
                        @"lat": history[@"lat"],
                        @"lon": history[@"lon"],
                        @"charge": history[@"charge"],
                        @"parkingCount": history[@"parkingCount"],
                        @"address": history[@"address"],
                        @"flag": history[@"flag"],
                        };
    
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@ (id,title,lat,lon,charge,parkingCount,address,flag) VALUES (:id,:title,:lat,:lon,:charge,:parkingCount,:address,:flag)", _tableName];
    [self.db executeUpdate:sql withParameterDictionary:d];
}

- (void)remove:(NSString *)rid
{
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE id=?", _tableName];
    [self.db executeUpdate:sql, rid];
}

@end
