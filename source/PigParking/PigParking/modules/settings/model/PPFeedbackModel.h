//
//  PPFeedbackModel.h
//  PigParking
//
//  Created by Vincent on 7/23/14.
//  Copyright (c) 2014 VincentStation. All rights reserved.
//

#import "PPBaseModel.h"

@interface PPFeedbackModel : PPBaseModel

- (void)postFeedback:(id)params complete:(void(^)(NSError *error))complete;

@end
