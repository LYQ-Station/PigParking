//
//  PPImageCache.h
//  PigParking
//
//  Created by VincentLi on 14-7-19.
//  Copyright (c) 2014年 VincentStation. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPImageCache : NSObject

+ (void)saveToCache:(UIImage *)image fromUrl:(NSString *)url;

+ (UIImage *)imageFromCache:(NSString *)url;

@end
