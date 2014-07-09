//
//  PPMapAnnoation.h
//  PigParking
//
//  Created by Vincent on 7/8/14.
//  Copyright (c) 2014 VincentStation. All rights reserved.
//

#import "BMKShape.h"

typedef enum {
    PPMapAnnoationTypeUser,
    PPMapAnnoationTypeParking
} PPMapAnnoationType;

typedef enum {
    PPMapAnnoationSubTypeFree,
    PPMapAnnoationSubTypeNofree
} PPMapAnnoationSubType;

@interface PPMapAnnoation : BMKPointAnnotation
//{
//	@package
//    CLLocationCoordinate2D _coordinate;
//}

@property (nonatomic, assign) int type;
@property (nonatomic, assign) int subType;
//@property (nonatomic, assign) CLLocationCoordinate2D coordinate;

@end
