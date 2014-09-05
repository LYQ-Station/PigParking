//
//  PPAppDelegate.m
//  PigParking
//
//  Created by VincentLi on 14-7-5.
//  Copyright (c) 2014年 VincentStation. All rights reserved.
//

#import "PPAppDelegate.h"
#import "PPIndexViewController.h"
#import "PPMapView.h"
#import "PPIntroView.h"

@interface PPAppDelegate ()

@end

@implementation PPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.mapManager = [[BMKMapManager alloc] init];
    BOOL ret = [_mapManager start:BAIDU_MAP_KEY generalDelegate:nil];
    if (!ret)
    {
        NSLog(@"BaiduMap manager start failed!");
    }
    
    _window.rootViewController = [PPIndexViewController navController];
    
    [self.window makeKeyAndVisible];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if (![ud objectForKey:@"isUsed"])
    {
        PPIntroView *intro_view = [[PPIntroView alloc] initWithFrame:_window.bounds];
        [_window addSubview:intro_view];
        
        [ud setObject:@"1" forKey:@"isUsed"];
        [ud synchronize];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
