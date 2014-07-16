//
//  PPParkingFilterView.m
//  PigParking
//
//  Created by VincentLi on 14-7-10.
//  Copyright (c) 2014年 VincentStation. All rights reserved.
//

#import "PPParkingFilterView.h"
#import "PPRadioButtonGroupView.h"

@implementation PPParkingFilterView

- (id)initWithDelegate:(id)delegate
{
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"idx-filter-bg"]];
    
    self = [super initWithFrame:iv.bounds];
    if (self)
    {
        _delegate = delegate;
        
        [self addSubview:iv];
        
            //
        PPRadioButtonGroupView *v = [[PPRadioButtonGroupView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, iv.bounds.size.width, 54.0f)];
        v.mode = PPButtonGroupModeSelect;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0.0f, 0.0f, 167.0f, 37.0f);
        [btn setTitle:@"按车位排序" forState:UIControlStateNormal];
        [v addButton:btn];
        [self addSubview:v];
        
            //
        v = [[PPRadioButtonGroupView alloc] initWithFrame:CGRectMake(0.0f, v.frame.origin.y+v.frame.size.height, iv.bounds.size.width, 54.0f)];
        v.mode = PPButtonGroupModeRadio;
        
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0.0f, 0.0f, 94.0f, 37.0f);
        [btn setTitle:@"300米以内" forState:UIControlStateNormal];
        [v addButton:btn];
        
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0.0f, 0.0f, 94.0f, 37.0f);
        [btn setTitle:@"700米以内" forState:UIControlStateNormal];
        [v addButton:btn];
        
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0.0f, 0.0f, 94.0f, 37.0f);
        [btn setTitle:@"10000米以内" forState:UIControlStateNormal];
        [v addButton:btn];
        
        [self addSubview:v];
        
            //
        v = [[PPRadioButtonGroupView alloc] initWithFrame:CGRectMake(0.0f, v.frame.origin.y+v.frame.size.height, iv.bounds.size.width, 54.0f)];
        v.mode = PPButtonGroupModeSelect;
        
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0.0f, 0.0f, 94.0f, 37.0f);
        [btn setTitle:@"免费" forState:UIControlStateNormal];
        [v addButton:btn];
        
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0.0f, 0.0f, 94.0f, 37.0f);
        [btn setTitle:@"凭购物\n小票免费" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:10.0f];
        btn.titleLabel.numberOfLines = 2;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [v addButton:btn];
        
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0.0f, 0.0f, 94.0f, 37.0f);
        [btn setTitle:@"收费" forState:UIControlStateNormal];
        [v addButton:btn];
        
        [self addSubview:v];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
