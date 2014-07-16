//
//  PPHistoryModel.h
//  PigParking
//
//  Created by VincentLi on 14-7-16.
//  Copyright (c) 2014年 VincentStation. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPHistoryModel : PPBaseModel

+ (id)model;

- (NSArray *)fetchHistory;

@end
