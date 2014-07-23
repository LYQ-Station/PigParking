//
//  PPParkingModel.h
//  PigParking
//
//  Created by VincentLi on 14-7-16.
//  Copyright (c) 2014年 VincentStation. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPParkingModel : PPBaseModel

- (void)fetchAroundParking:(id)params complete:(void(^)(id data, NSError *error))complete;

- (void)fetchParkingDetails:(id)params complete:(void(^)(id data, NSError *error))complete;

@end
