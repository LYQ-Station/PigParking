//
//  PPMapSearchModel.m
//  PigParking
//
//  Created by VincentLi on 14-7-15.
//  Copyright (c) 2014年 VincentStation. All rights reserved.
//

#import "PPMapSearchModel.h"
#import "PPHistoryDB.h"

@interface PPMapSearchModel ()

@property (nonatomic, strong) PPHistoryDB *historyDb;

@end

@implementation PPMapSearchModel

+ (id)model
{
    return [[PPMapSearchModel alloc] init];
}

- (id)init
{
    self = [super init];
    if (self)
    {
        self.historyDb = [PPHistoryDB db];
    }
    return self;
}

- (NSArray *)fetchHistoryList
{
    return [_historyDb fetchAll];
}

- (NSArray *)filterHistoryList:(NSString *)keyword
{
    return [_historyDb search:keyword];
}

- (void)doSearch:(NSString *)keyword complete:(void(^)(NSArray *data, NSError *error))complete
{
    NSDictionary *p = @{
                        @"keyWord":keyword,
                        @"distance":@"500",
                        @"uid":[PPUser currentUser].uid
                        };
    
    NSData *jd = [AFQueryStringFromParametersWithEncoding(p, NSUTF8StringEncoding) dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *url = [PPBaseService apiForKey:kApiSearch];
    NSMutableURLRequest *req = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [req setHTTPMethod:@"POST"];
    [req setHTTPBody:jd];
    
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:req];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSError *err = nil;
        id j = [self parseResponseData:responseObject error:&err];
        
        if (err)
        {
            complete(nil, err);
            return ;
        }
        
        NSMutableArray *a = [NSMutableArray array];
        for (NSDictionary *d in j)
        {
            [a addObject:@{@"id":d[@"id"],
                           @"title":d[@"name"],
                           @"lat":d[@"lat"],
                           @"lon":d[@"lng"],
                           @"parkingCount":d[@"carNum"],
                           @"address":d[@"addr"],
                           @"charge":d[@"price"],
                           @"flag":d[@"type"]
                           }];
        }
        
        complete(a, nil);
    }
                              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                  complete(nil, error);
                              }];
    
    [op start];
    
    
//    NSMutableArray *a = [NSMutableArray array];
//    
//    for (int i=0; i<20; i++)
//    {
//        [a addObject:@{@"id": @1,
//                       @"title":[NSString stringWithFormat:@"南山地点 ＃%d", i],
//                       @"lat":@(30.691393),
//                       @"lon":@(104.085264),
//                       @"parkingCount":@"200",
//                       @"address":@"深圳市南山松坪村"
//                       }];
//    }
//    
//    complete(a, nil);
}

@end
