//
//  FBImagesWheel.m
//  
//
//  Created by Vincent on 5/30/13.
//  Copyright (c) 2013 VincentStation. All rights reserved.
//

#import "FBImagesWheel.h"

@implementation FBImagesWheel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIScrollView *sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.bounds.size.width-100, self.bounds.size.height)];
        sv.backgroundColor = [UIColor clearColor];
        sv.delegate = self;
        sv.pagingEnabled = YES;
        sv.showsHorizontalScrollIndicator = NO;
        sv.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
        sv.layer.masksToBounds = NO;
        [self addSubview:sv];
        _scorllView = sv;
        
        CALayer *mask = [CALayer layer];
        mask.frame = self.bounds;
        mask.backgroundColor = [UIColor redColor].CGColor;
        self.layer.mask = mask;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)awakeFromNib
{
    UIScrollView *sv = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.bounds.size.width-100, self.bounds.size.height)];
    sv.backgroundColor = [UIColor clearColor];
    sv.delegate = self;
    sv.pagingEnabled = YES;
    sv.showsHorizontalScrollIndicator = NO;
    sv.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    sv.layer.masksToBounds = NO;
    [self addSubview:sv];
    _scorllView = sv;
    
    CALayer *mask = [CALayer layer];
    mask.frame = self.bounds;
    mask.backgroundColor = [UIColor redColor].CGColor;
    self.layer.mask = mask;
    self.layer.masksToBounds = YES;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)setImages:(NSArray *)images
{
    if (0 == images.count)
    {
        return;
    }
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.bounds.size.height-40, self.bounds.size.width, 40)];
    _pageControl.numberOfPages = images.count;
    [self addSubview:_pageControl];
    
    _scorllView.contentSize = CGSizeMake(_scorllView.bounds.size.width * images.count, _scorllView.bounds.size.height);
    
    for (int i=0; i<images.count; i++)
    {
        PPURLImageView *v = [[PPURLImageView alloc] initWithFrame:CGRectMake((_scorllView.bounds.size.width-20)*i+20*i+10, 10, _scorllView.bounds.size.width-20, _scorllView.bounds.size.height-20)];
        v.tag = i;
        v.userInteractionEnabled = YES;
        v.imageUrl = [images[i] hasPrefix:@"http"] ? images[i] : [NSString stringWithFormat:@"http://%@", images[i]];
        v.contentMode = UIViewContentModeScaleAspectFit;
        [v addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onGestureTapImage:)]];
        [_scorllView addSubview:v];
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *v = [super hitTest:point withEvent:event];
    
    if ([v isKindOfClass:[PPURLImageView class]])
    {
        return v;
    }
    
    return _scorllView;
}

#pragma mark - scorll view delegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
     _pageControl.currentPage = (int)(scrollView.contentOffset.x / scrollView.bounds.size.width);
}

#pragma mark -

- (void)onGestureTapImage:(UITapGestureRecognizer *)gesture
{
    if (_delegate && [_delegate respondsToSelector:@selector(imageWheelDidChangeImage:imageView:)])
    {
        [_delegate performSelector:@selector(imageWheelDidChangeImage:imageView:) withObject:self withObject:gesture.view];
    }
}

@end
