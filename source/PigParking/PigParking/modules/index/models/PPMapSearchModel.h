//
//  PPMapSearchModel.h
//  PigParking
//
//  Created by VincentLi on 14-7-15.
//  Copyright (c) 2014年 VincentStation. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPMapSearchModel : PPBaseModel

+ (id)model;

- (NSArray *)fetchHistoryList;

- (void)doSearch:(NSString *)keyword complete:(void(^)(NSArray *data, NSError *error))complete;

@end
