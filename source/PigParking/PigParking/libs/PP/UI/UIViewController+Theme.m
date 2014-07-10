//
//  UIViewController+Theme.m
//  PigParking
//
//  Created by Vincent on 7/7/14.
//  Copyright (c) 2014 VincentStation. All rights reserved.
//

#import "UIViewController+Theme.h"

@implementation UIViewController (Theme)

- (void)setupTheme
{
    UINavigationItem *item = self.navigationItem;
    
    UILabel *title_lab = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 140.0, 44.0)];
    title_lab.tag = 101;
    title_lab.backgroundColor = [UIColor clearColor];
    title_lab.text = self.title;
    title_lab.textAlignment = NSTextAlignmentCenter;
    title_lab.textColor = [UIColor colorWithRed:0.08f green:0.08f blue:0.08f alpha:1.0f];
    title_lab.font = [UIFont boldSystemFontOfSize:20.0f];
    item.titleView = title_lab;
    
    self.view.backgroundColor = [UIColor colorWithRed:0.92f green:0.92f blue:0.92f alpha:1.0f];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        [self setEdgesForExtendedLayout:0];
    }
}

- (void)resetTitle:(NSString *)title
{
    UILabel *lb = (UILabel *)self.navigationItem.titleView;
    lb.text = title;
}

@end
