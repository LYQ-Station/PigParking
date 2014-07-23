//
//  PPIndexModel.h
//  PigParking
//
//  Created by Vincent on 7/8/14.
//  Copyright (c) 2014 VincentStation. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPIndexModel : PPBaseModel

- (void)cancel;

- (void)fetchAroundParking:(CLLocationCoordinate2D)coordinate block:(void(^)(NSArray *data, NSError *error))complete;

@end
