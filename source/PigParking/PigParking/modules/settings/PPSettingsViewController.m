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

//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self)
//    {
//        self.title = @"设置";
//    }
//    return self;
//}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStylePlain];
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
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (0 == section)
    {
        return 3;
    }
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 17.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cid = @"settings-cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cid];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cid];
    }
    
    if (0 == indexPath.section)
    {
        if (0 == indexPath.row)
        {
            cell.textLabel.text = @"帮助与反馈";
            cell.imageView.image = [UIImage imageNamed:@"st-icon0"];
        }
        else if (1 == indexPath.row)
        {
            cell.textLabel.text = @"历史记录";
            cell.imageView.image = [UIImage imageNamed:@"st-icon1"];
        }
        else
        {
            cell.textLabel.text = @"关于我们";
            cell.imageView.image = [UIImage imageNamed:@"st-icon2"];
        }
        
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell-acc"]];
    }
    else
    {
        cell.textLabel.text = @"保存我的停车记录";
        
        UISwitch *sw = [[UISwitch alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 50.0f, 30.0f)];
        sw.on = [PPUser currentUser].isSaveSearchHistory;
        [sw addTarget:self action:@selector(swSaveHistoryClick:) forControlEvents:UIControlEventValueChanged];
        cell.accessoryView = sw;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
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
        PPHistoryViewController *c = [[PPHistoryViewController alloc] initWithNibName:nil bundle:nil];
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

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (IS_IOS7)
    {
        return;
    }
    
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    
    if (0 == indexPath.row)
    {
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell-bg-top"]];
    }
    else if (2 == indexPath.row)
    {
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell-bg-bot"]];
    }
    else
    {
        cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell-bg-midd"]];
    }
}

#pragma mark -

- (void)btnBackClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)swSaveHistoryClick:(UISwitch *)sender
{
    [PPUser currentUser].isSaveSearchHistory = sender.isOn;
}

@end
