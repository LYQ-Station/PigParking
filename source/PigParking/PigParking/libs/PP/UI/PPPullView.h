//
//  PPPullView.h
//  PigParking
//
//  Created by Vincent on 7/9/14.
//  Copyright (c) 2014 VincentStation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PPPullView : UIView

@property (nonatomic, assign) id delegate;
@property (nonatomic, strong) UIView *contentView;

- (id)initWithParentView:(UIView *)parentView contentView:(UIView *)contentView mask:(BOOL)hasMask;

- (void)show;

- (void)showNoMask;

- (void)hide:(BOOL)animated;

@end

@protocol PPPullViewDelegate  <NSObject>

@optional
- (void)pullViewDidTouchMask:(PPPullView *)pullView;

@end
