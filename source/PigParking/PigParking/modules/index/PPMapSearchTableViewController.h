//
//  PPMapSearchTableViewController.h
//  PigParking
//
//  Created by Vincent on 7/15/14.
//  Copyright (c) 2014 VincentStation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PPMapSearchTableViewController : UITableViewController

@property (nonatomic, assign) id searchDelegate;

- (id)initWithDelegate:(id)delegate;

- (void)clean;

- (void)showHistory;

- (void)doSearch:(NSString *)keyword;

@end

@protocol PPMapSearchTableViewControllerDelegate <NSObject>

- (void)ppMapSearchTableViewContrllerDidSelectHistory:(PPMapSearchTableViewController *)controller item:(id)item;

- (void)ppMapSearchTableViewContrllerDidSelectSearchResult:(PPMapSearchTableViewController *)controller item:(id)item;

@end
