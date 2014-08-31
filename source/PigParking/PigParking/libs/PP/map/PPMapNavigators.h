//
//  PPMapNavigators.h
//  PigParking
//
//  Created by LiYongQiang on 14-8-31.
//  Copyright (c) 2014年 VincentStation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPMapNavigators : NSObject

@property (nonatomic, readonly) NSArray *navigators;

+ (void)navigateFrom:(CLLocationCoordinate2D)from to:(CLLocationCoordinate2D)to destionName:(NSString *)destionName type:(int)type;

+ (PPMapNavigators *)sharedInstance;

- (UIActionSheet *)navigatorsSheet;

@end
