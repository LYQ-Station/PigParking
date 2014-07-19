//
//  PPConfigs.h
//  PigParking
//
//  Created by VincentLi on 14-7-5.
//  Copyright (c) 2014年 VincentStation. All rights reserved.
//

#pragma mark - device

#define IS_SCREEN568        (568.0f==[UIScreen mainScreen].bounds.size.height)
#define IS_IOS7             ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define LESS_THAN_IOS6      ([[[UIDevice currentDevice] systemVersion] floatValue] < 6.0)

#pragma mark - map

#define BAIDU_MAP_KEY       @"fxQ5FtFisHAqeCkhDWNIrDGA"

#pragma mark - URLs

#define PP_BASE_DOMAIN      @"pig-parking.com"
#define PP_API_URL          @"http://pig-parking.com/apis"

#define PATH_IN_DOCUMENTS_DIR(f) ([NSString stringWithFormat:@"%@/Documents/%@", NSHomeDirectory(),f])
#define PATH_IN_CACHE_DIR(f) ([NSString stringWithFormat:@"%@/Documents/cache/%@", NSHomeDirectory(),f])