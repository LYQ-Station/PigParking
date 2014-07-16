//
//  PPParkingModel.h
//  PigParking
//
//  Created by VincentLi on 14-7-16.
//  Copyright (c) 2014年 VincentStation. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPParkingModel : PPBaseModel

+ (id)model;

- (void)fetchAroundParking:(id)params complete:(void(^)(id data, NSError *error))complete;

@end
