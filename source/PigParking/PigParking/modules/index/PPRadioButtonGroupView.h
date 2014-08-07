//
//  PPRadioButtonGroupView.h
//  PigParking
//
//  Created by Vincent on 7/16/14.
//  Copyright (c) 2014 VincentStation. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    PPButtonGroupModeNone,
    PPButtonGroupModeRadio,
    PPButtonGroupModeSelect
} PPButtonGroupMode;

@interface PPRadioButtonGroupView : UIView

@property (nonatomic, assign) PPButtonGroupMode mode;
@property (nonatomic, assign) id delegate;

@property (nonatomic, readonly) NSArray *selectedIndexes;

- (void)addButton:(UIButton *)button;

@end

@protocol RadioButtonGroupViewDelegate <NSObject>

- (void)radioButtonGroupViewDidCheckedOption:(PPRadioButtonGroupView *)view buttonIndex:(NSNumber *)index;

@end
