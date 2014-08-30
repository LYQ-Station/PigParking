//
//  PPMapSearchTableViewController.h
//  PigParking
//
//  Created by Vincent on 7/15/14.
//  Copyright (c) 2014 VincentStation. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    PPMapSearchTableViewControllerModeHistory = 1,
    PPMapSearchTableViewControllerModeSearch,
    PPMapSearchTableViewControllerModeMapSDKSearch
} PPMapSearchTableViewControllerMode;

@interface PPMapSearchTableViewController : UITableViewController

@property (nonatomic, assign) id searchDelegate;

@property (nonatomic, readonly) PPMapSearchTableViewControllerMode mode;

- (id)initWithDelegate:(id)delegate;

- (void)clean;

- (void)showHistory;

- (void)filterHistory:(NSString *)keyword;

- (void)doSearch:(NSString *)keyword;

- (void)doMapSDKSearch:(NSString *)keyword;

@end

@protocol PPMapSearchTableViewControllerDelegate <NSObject>

- (void)ppMapSearchTableViewContrllerDidSelectHistory:(PPMapSearchTableViewController *)controller item:(id)item;

- (void)ppMapSearchTableViewContrllerDidSelectSearchResult:(PPMapSearchTableViewController *)controller item:(id)item;

@end
