//
//  PPImageCache.m
//  PigParking
//
//  Created by VincentLi on 14-7-19.
//  Copyright (c) 2014年 VincentStation. All rights reserved.
//

#import "PPImageCache.h"

@implementation PPImageCache

+ (void)initialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *dir = PATH_IN_DOCUMENTS_DIR(@"cache");
        if (![[NSFileManager defaultManager] fileExistsAtPath:dir])
        {
            [[NSFileManager defaultManager] createDirectoryAtPath:dir
                                      withIntermediateDirectories:NO
                                                       attributes:nil
                                                            error:nil];
        }
    });
}

+ (void)saveToCache:(UIImage *)image fromUrl:(NSString *)url
{
    NSString *c_name = [NSString stringWithFormat:@"%u", [url hash]];
    
    [UIImagePNGRepresentation(image) writeToFile:PATH_IN_CACHE_DIR(c_name) atomically:NO];
}

+ (UIImage *)imageFromCache:(NSString *)url
{
    NSString *c_name = [NSString stringWithFormat:@"%u", [url hash]];
    return [UIImage imageWithContentsOfFile:PATH_IN_CACHE_DIR(c_name)];
}

@end
