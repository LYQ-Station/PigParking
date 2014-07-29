//
//  PPBaseDB.m
//  PigParking
//
//  Created by Vincent on 7/17/14.
//  Copyright (c) 2014 VincentStation. All rights reserved.
//

#import "PPBaseDB.h"

static FMDatabase *__db;

@implementation PPBaseDB

+ (void)initialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        NSFileManager *fm = [NSFileManager defaultManager];
        
        NSString *new_db_file = PATH_IN_DOCUMENTS_DIR(@"DB.rdb");
        
        if (![fm fileExistsAtPath:new_db_file])
        {
            NSString *og_db_file = [[NSBundle mainBundle] pathForResource:@"DB" ofType:@"rdb"];
            [fm copyItemAtPath:og_db_file toPath:new_db_file error:nil];
        }
        
        __db = [[FMDatabase alloc] initWithPath:new_db_file];
        if(!__db.open)
        {
            [__db open];
        }
    });
}

+ (FMDatabase *)db
{
    return __db;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        _db = __db;
    }
    return self;
}

@end
