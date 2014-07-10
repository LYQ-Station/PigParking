//
//  UINavigationBar+Theme.m
//  PigParking
//
//  Created by Vincent on 7/7/14.
//  Copyright (c) 2014 VincentStation. All rights reserved.
//

#import "UINavigationBar+Theme.h"

@implementation UINavigationBar (Theme)

- (void)setupTheme
{
//    [self setBarStyle:UIBarStyleBlackTranslucent];
    
    if ([self respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)])
    {
        [self setBackgroundImage:[UIImage imageNamed:@"nav-bar-bg"] forBarMetrics:UIBarMetricsDefault];
    }
}

@end
