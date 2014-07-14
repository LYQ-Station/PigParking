//
//  PPFeedbackViewController.m
//  PigParking
//
//  Created by VincentLi on 14-7-6.
//  Copyright (c) 2014年 VincentStation. All rights reserved.
//

#import "PPFeedbackViewController.h"

@interface PPFeedbackViewController ()

@property (nonatomic, strong) IBOutlet UITextView *tvContent;
@property (nonatomic, strong) IBOutlet UITextField *tfContact;

@property (nonatomic, assign) UIScrollView *scrollView;

@end

@implementation PPFeedbackViewController

- (void)dealloc
{
    self.tvContent = nil;
    self.tfContact = nil;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = @"意见反馈";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupTheme];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonThemeItem:UIBarButtonThemeItemBack
                                                                                         target:self
                                                                                         action:@selector(btnBackClick:)];
    
    _scrollView = (UIScrollView *)self.view;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    UITapGestureRecognizer *g = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapGesture:)];
    [self.view addGestureRecognizer:g];
    
    [UIView animateWithDuration:0.25f animations:^{
        _scrollView.contentInset = UIEdgeInsetsMake(-230.0f, 0.0f, 0.0f, 0.0f);
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.25f animations:^{
        _scrollView.contentInset = UIEdgeInsetsZero;
    }];
}

#pragma mark -

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    UITapGestureRecognizer *g = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapGesture:)];
    [self.view addGestureRecognizer:g];
    
    return YES;
}

#pragma mark -

- (IBAction)btnSuggestionClick:(UIButton *)sender
{
    if (sender.selected)
    {
        sender.selected = NO;
    }
    else
    {
        sender.selected = YES;
    }
}

- (IBAction)btnSubmitClick:(id)sender
{
    
}

- (void)onTapGesture:(UITapGestureRecognizer *)g
{
    [self.view removeGestureRecognizer:g];
    
    [_tvContent resignFirstResponder];
    [_tfContact resignFirstResponder];
}

- (void)btnBackClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
