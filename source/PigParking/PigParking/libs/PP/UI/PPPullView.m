//
//  PPPullView.m
//  PigParking
//
//  Created by Vincent on 7/9/14.
//  Copyright (c) 2014 VincentStation. All rights reserved.
//

#import "PPPullView.h"

@interface PPPullView ()

@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIView *parentView;

@end

@implementation PPPullView

- (void)dealloc
{
    self.maskView = nil;
    self.contentView = nil;
    self.parentView = nil;
}

- (id)initWithParentView:(UIView *)parentView contentView:(UIView *)contentView mask:(BOOL)hasMask
{
    self = [super initWithFrame:parentView.bounds];
    if (self)
    {
        self.parentView = parentView;
        
        if (hasMask)
        {
            self.maskView = [[UIView alloc] initWithFrame:self.bounds];
            _maskView.backgroundColor = [UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.8f];
            _maskView.alpha = 0.0f;
            [self addSubview:_maskView];
            
            UITapGestureRecognizer *g = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapMaskGesture:)];
            [_maskView addGestureRecognizer:g];
        }
        
        self.contentView = contentView;
        
        if (999 != contentView.tag)
        {
            _contentView.frame = CGRectMake(0.0f, 0.0f-_contentView.bounds.size.height, _contentView.bounds.size.width, _contentView.bounds.size.height);
        }
        [self addSubview:_contentView];
    }
    return self;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    if (_maskView)
    {
        return [super pointInside:point withEvent:event];
    }
    
    return [_contentView pointInside:point withEvent:event];
}

- (void)show
{
    [self.parentView addSubview:self];
    
    self.contentView.userInteractionEnabled = NO;
    
    [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.maskView.alpha = 1.0f;
                         self.contentView.center = CGPointMake(self.contentView.center.x, self.contentView.center.y+self.contentView.bounds.size.height);
                     }
                     completion:^(BOOL finished) {
                         if (finished)
                         {
                             self.contentView.userInteractionEnabled = YES;
                         }
                     }];
}

- (void)showNoMask
{
    [self.parentView addSubview:self];
    
    [self.maskView removeFromSuperview];
    self.maskView = nil;
    
    self.contentView.userInteractionEnabled = NO;
    
    [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.contentView.center = CGPointMake(self.contentView.center.x, self.contentView.center.y+self.contentView.bounds.size.height);
                     }
                     completion:^(BOOL finished) {
                         if (finished)
                         {
                             self.contentView.userInteractionEnabled = YES;
                         }
                     }];
}

- (void)hide:(BOOL)animated
{
    if (!animated)
    {
        [self removeFromSuperview];
        return;
    }
    
    [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         self.maskView.alpha = 0.0f;
                         self.contentView.center = CGPointMake(self.contentView.center.x, self.contentView.center.y-self.contentView.bounds.size.height);
                     }
                     completion:^(BOOL finished) {
                         if (finished)
                         {
                             [self removeFromSuperview];
                         }
                     }];
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

- (void)onTapMaskGesture:(UIGestureRecognizer *)gesture
{
    [gesture.view removeGestureRecognizer:gesture];
    
    if (_delegate && [_delegate respondsToSelector:@selector(pullViewDidTouchMask:)])
    {
        [_delegate performSelector:@selector(pullViewDidTouchMask:) withObject:self];
    }
}

@end
