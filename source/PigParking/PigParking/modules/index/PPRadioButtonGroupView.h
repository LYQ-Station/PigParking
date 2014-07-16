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

- (void)addButton:(UIButton *)button;

@end
