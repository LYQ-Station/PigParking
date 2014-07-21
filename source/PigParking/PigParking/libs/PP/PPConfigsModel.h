//
//  PPConfigsModel.h
//  PigParking
//
//  Created by Vincent on 7/21/14.
//  Copyright (c) 2014 VincentStation. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPConfigsModel : PPBaseModel

- (void)fetchConfigs:(void(^)(id json, NSError *))complete;

@end
