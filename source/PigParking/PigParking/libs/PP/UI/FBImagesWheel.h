//
//  FBImagesWheel.h
//  
//
//  Created by Vincent on 5/30/13.
//  Copyright (c) 2013 VincentStation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FBImagesWheel : UIView <UIScrollViewDelegate>
{
    UIScrollView *_scorllView;
    UIPageControl *_pageControl;
}

@property (nonatomic, assign) IBOutlet id delegate;
@property (nonatomic, strong) NSArray *images;

@end

@protocol FBImagesWheelDelegate <NSObject>

@optional

- (void)imageWheelDidChangeImage:(FBImagesWheel *)wheel imageView:(UIImageView *)imageView;

@end