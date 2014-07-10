//
//  PPSettingsViewController.m
//  PigParking
//
//  Created by VincentLi on 14-7-5.
//  Copyright (c) 2014年 VincentStation. All rights reserved.
//

#import "PPSettingsViewController.h"
#import "PPFeedbackViewController.h"
#import "PPHistoryViewController.h"
#import "PPSettingViewController.h"
#import "PPAboutViewController.h"

@interface PPSettingsViewController ()

@end

@implementation PPSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = @"设置";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupTheme];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonThemeItem:UIBarButtonThemeItemBack
                                                                                         target:self
                                                                                         action:@selector(btnBackClick:)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cid = @"settings-cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
    }
    
    if (0 == indexPath.row)
    {
        cell.textLabel.text = @"帮助与反馈";
    }
    else if (1 == indexPath.row)
    {
        cell.textLabel.text = @"历史记录";
    }
    else
    {
        cell.textLabel.text = @"关于我们";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (0 == indexPath.row)
    {
        PPFeedbackViewController *c = [[PPFeedbackViewController alloc] initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:c animated:YES];
    }
    else if (1 == indexPath.row)
    {
        PPHistoryViewController *c = [[PPHistoryViewController alloc] initWithStyle:UITableViewStylePlain];
        [self.navigationController pushViewController:c animated:YES];
    }
    else
    {
//        PPSettingViewController *c = [[PPSettingViewController alloc] initWithStyle:UITableViewStylePlain];
//        [self.navigationController pushViewController:c animated:YES];
        
        PPAboutViewController *c = [[PPAboutViewController alloc] initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:c animated:YES];
    }
}

#pragma mark -

- (void)btnBackClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
