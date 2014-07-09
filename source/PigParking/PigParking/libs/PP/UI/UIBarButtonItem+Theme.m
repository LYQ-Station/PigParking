//
//  UIBarButtonItem+Theme.m
//  PigParking
//
//  Created by Vincent on 7/7/14.
//  Copyright (c) 2014 VincentStation. All rights reserved.
//

#import "UIBarButtonItem+Theme.h"

@implementation UIBarButtonItem (Theme)

- (id)initWithBarButtonThemeItem:(UIBarButtonThemeItem)item target:(id)target action:(SEL)action
{
    UIImage *img = nil;
    
    switch (item)
    {
        case UIBarButtonThemeItemOK:
            img = [UIImage imageNamed:@"nav-item-ok"];
            break;
            
        case UIBarButtonThemeItemBack:
            img = [UIImage imageNamed:@"nav-item-back"];
            break;
            
        case UIBarButtonThemeItemSave:
            img = [UIImage imageNamed:@"nav-item-save"];
            break;
            
        case UIBarButtonThemeItemList:
            img = [UIImage imageNamed:@"nav-item-list"];
            break;
            
        case UIBarButtonThemeItemFilter:
            img = [UIImage imageNamed:@"nav-item-filter"];
            break;
    }
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.bounds = CGRectMake(0.0f, 0.0f, img.size.width, img.size.height);
    [btn setImage:img forState:UIControlStateNormal];
    btn.enabled = YES;
    
    self = [self initWithCustomView:btn];
    
    return self;
}

@end
