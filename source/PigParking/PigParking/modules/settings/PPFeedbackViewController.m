//
//  PPFeedbackViewController.m
//  PigParking
//
//  Created by VincentLi on 14-7-6.
//  Copyright (c) 2014年 VincentStation. All rights reserved.
//

#import "PPFeedbackViewController.h"
#import "PPFeedbackModel.h"

@interface PPFeedbackViewController ()

@property (nonatomic, strong) IBOutlet UITextView *tvContent;
@property (nonatomic, strong) IBOutlet UITextField *tfContact;

@property (nonatomic, assign) UIScrollView *scrollView;

@property (nonatomic, strong) NSMutableDictionary *labelsDict;

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
        self.labelsDict = [NSMutableDictionary dictionary];
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
        
        if (101 == sender.tag)
        {
            [_labelsDict removeObjectForKey:@"101"];
        }
        else if (102 == sender.tag)
        {
            [_labelsDict removeObjectForKey:@"102"];
        }
        else if (103 == sender.tag)
        {
            [_labelsDict removeObjectForKey:@"103"];
        }
        else if (104 == sender.tag)
        {
            [_labelsDict removeObjectForKey:@"104"];
        }
    }
    else
    {
        sender.selected = YES;
        
        if (101 == sender.tag)
        {
            [_labelsDict setObject:@"101" forKey:@"地址错误"];
        }
        else if (102 == sender.tag)
        {
            [_labelsDict setObject:@"102" forKey:@"找不到地点"];
        }
        else if (103 == sender.tag)
        {
            [_labelsDict setObject:@"103" forKey:@"软件不稳定"];
        }
        else if (104 == sender.tag)
        {
            [_labelsDict setObject:@"104" forKey:@"改进建议"];
        }
    }
}

- (IBAction)btnSubmitClick:(id)sender
{
    [self postFeedback];
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

#pragma mark -

- (void)postFeedback
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:hud];
    [hud show:YES];
    
    NSDictionary *p = @{@"content": _tvContent.text,
                        @"qq":_tfContact.text,
                        @"labels":[[_labelsDict allKeys] componentsJoinedByString:@","]};
    
    [[PPFeedbackModel model] postFeedback:p
                                 complete:^(NSError *error) {
                                     [hud hide:YES];
                                     
                                     MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self.view];
                                     hud.mode = MBProgressHUDModeText;
                                     [self.view addSubview:hud];
                                     
                                     if (error)
                                     {
                                         hud.labelText = [error.userInfo objectForKey:NSLocalizedDescriptionKey];
                                         [hud show:YES];
                                         [hud hide:YES afterDelay:1.0];
                                         
                                         return ;
                                     }
                                     
                                     hud.labelText = @"谢谢你的意见反馈！";
                                     [hud show:YES];
                                     
                                     [self performSelector:@selector(btnBackClick:) withObject:nil afterDelay:1.0];
                                 }];
}

@end
