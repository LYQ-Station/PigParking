//
//  UIBarButtonItem+Theme.h
//  PigParking
//
//  Created by Vincent on 7/7/14.
//  Copyright (c) 2014 VincentStation. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    UIBarButtonThemeItemOK,
    UIBarButtonThemeItemBack,
    UIBarButtonThemeItemSave,
    UIBarButtonThemeItemList,
    UIBarButtonThemeItemFilter,
    UIBarButtonThemeItemUp,
    UIBarButtonThemeItemClear
} UIBarButtonThemeItem;

@interface UIBarButtonItem (Theme)

- (id) initWithBarButtonThemeItem:(UIBarButtonThemeItem)item target:(id)target action:(SEL)action;

@end
