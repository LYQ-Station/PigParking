//
//  PPParkingFilterView.m
//  PigParking
//
//  Created by VincentLi on 14-7-10.
//  Copyright (c) 2014年 VincentStation. All rights reserved.
//

#import "PPParkingFilterView.h"
#import "PPRadioButtonGroupView.h"

@interface PPParkingFilterView () <RadioButtonGroupViewDelegate>

@property (nonatomic, weak) PPRadioButtonGroupView *optionsView1;
@property (nonatomic, weak) PPRadioButtonGroupView *optionsView2;
@property (nonatomic, weak) PPRadioButtonGroupView *optionsView3;

@end

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
        v.tag = 101;
        v.mode = PPButtonGroupModeSelect;
        v.delegate = self;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0.0f, 0.0f, 167.0f, 37.0f);
        [btn setTitle:@"按车位排序" forState:UIControlStateNormal];
        [v addButton:btn];
        [self addSubview:v];
        self.optionsView1 = v;
        
            //
        v = [[PPRadioButtonGroupView alloc] initWithFrame:CGRectMake(0.0f, v.frame.origin.y+v.frame.size.height, iv.bounds.size.width, 54.0f)];
        v.tag = 102;
        v.mode = PPButtonGroupModeRadio;
        v.delegate = self;
        
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0.0f, 0.0f, 94.0f, 37.0f);
        [btn setTitle:@"300米以内" forState:UIControlStateNormal];
        [v addButton:btn];
        
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0.0f, 0.0f, 94.0f, 37.0f);
        [btn setTitle:@"500米以内" forState:UIControlStateNormal];
        [v addButton:btn];
        
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0.0f, 0.0f, 94.0f, 37.0f);
        [btn setTitle:@"1000米以内" forState:UIControlStateNormal];
        [v addButton:btn];
        
        [self addSubview:v];
        self.optionsView2 = v;
        
            //
        v = [[PPRadioButtonGroupView alloc] initWithFrame:CGRectMake(0.0f, v.frame.origin.y+v.frame.size.height, iv.bounds.size.width, 54.0f)];
        v.tag = 103;
        v.mode = PPButtonGroupModeSelect;
        v.delegate = self;
        
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0.0f, 0.0f, 94.0f, 37.0f);
        [btn setTitle:@"免费" forState:UIControlStateNormal];
        [v addButton:btn];
        
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0.0f, 0.0f, 94.0f, 37.0f);
        [btn setTitle:@"凭购物\n小票免费" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:7.0f];
        btn.titleLabel.numberOfLines = 2;
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        [v addButton:btn];
        
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0.0f, 0.0f, 94.0f, 37.0f);
        [btn setTitle:@"收费" forState:UIControlStateNormal];
        [v addButton:btn];
        
        [self addSubview:v];
        self.optionsView3 = v;
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

- (void)radioButtonGroupViewDidCheckedOption:(PPRadioButtonGroupView *)view buttonIndex:(NSNumber *)index
{
    NSArray *idxs = view.selectedIndexes;
    NSMutableDictionary *d = [NSMutableDictionary dictionary];
    
    idxs = _optionsView1.selectedIndexes;
    if (idxs.count)
    {
        [d setObject:@"desc" forKey:@"order"];
    }
    
    idxs = _optionsView2.selectedIndexes;
    if (idxs.count)
    {
        id p = [@[@"300",@"500",@"1000"] objectAtIndex:[idxs[0] intValue]];
        [d setObject:p forKey:@"distance"];
    }
    
    idxs = _optionsView3.selectedIndexes;
    if (idxs.count)
    {
        id p = [[@[@"free",@"free1",@"nofree"] objectsAtIndexes:[idxs indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {return YES;}]] componentsJoinedByString:@","];
        [d setObject:p forKey:@"price"];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(parkingFilterViewDidSelectOption:options:)])
    {
        [_delegate performSelector:@selector(parkingFilterViewDidSelectOption:options:) withObject:self withObject:d];
    }
}

@end
