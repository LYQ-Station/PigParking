//
//  PPRadioButtonGroupView.m
//  PigParking
//
//  Created by Vincent on 7/16/14.
//  Copyright (c) 2014 VincentStation. All rights reserved.
//

#import "PPRadioButtonGroupView.h"

@interface PPRadioButtonGroupView ()

@property (nonatomic, strong) NSMutableArray *buttons;

@end

@implementation PPRadioButtonGroupView

- (void)dealloc
{
    self.buttons = nil;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _mode = PPButtonGroupModeNone;
        self.buttons = [NSMutableArray array];
    }
    return self;
}

- (void)addButton:(UIButton *)button
{
    button.titleLabel.font = [UIFont systemFontOfSize:14.5];
    
    [button setTitleColor:[UIColor colorWithRed:0.08f green:0.08f blue:0.08f alpha:1.0f] forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    
    [button setBackgroundImage:[[UIImage imageNamed:@"btn-bg-white"] resizableImageWithCapInsets:UIEdgeInsetsMake(22.0f, 18.0f, 18.0f, 22.0f)] forState:UIControlStateNormal];
//    [button setBackgroundImage:[[UIImage imageNamed:@"btn-bg-blue"] resizableImageWithCapInsets:UIEdgeInsetsMake(22.0f, 18.0f, 18.0f, 22.0f)] forState:UIControlStateHighlighted];
    [button setBackgroundImage:[[UIImage imageNamed:@"btn-bg-blue"] resizableImageWithCapInsets:UIEdgeInsetsMake(22.0f, 18.0f, 18.0f, 22.0f)] forState:UIControlStateSelected];
    
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:button];
    [self.buttons addObject:button];
}

- (void)layoutSubviews
{
    if (0 == _buttons)
    {
        return;
    }
    
    UIButton *btn = nil;
    
    if (1 == _buttons.count)
    {
        btn = _buttons[0];
        btn.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        
        return;
    }
    
    UIView *v = nil;
    
    for (int i=0; i<_buttons.count; i++)
    {
        btn = _buttons[i];
        
        if (!v)
        {
            btn.center = CGPointMake(13.0+btn.bounds.size.width/2, self.bounds.size.height/2);
        }
        else
        {
            btn.center = CGPointMake(v.center.x+v.bounds.size.width/2+6.0+btn.bounds.size.width/2, self.bounds.size.height/2);
        }
        
        v = btn;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark -

- (void)btnClick:(UIButton *)sender
{
    if (_mode == PPButtonGroupModeNone)
    {
        return;
    }
    
    if (_mode == PPButtonGroupModeRadio)
    {
        for (UIButton *btn in _buttons)
        {
            btn.selected = NO;
        }
        
        sender.selected = YES;
    }
    else if (_mode == PPButtonGroupModeSelect)
    {
        sender.selected = !sender.selected;
    }
}

@end
