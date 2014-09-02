//
//  PPIntroView.m
//  PigParking
//
//  Created by m77 on 14-9-2.
//  Copyright (c) 2014年 VincentStation. All rights reserved.
//

#import "PPIntroView.h"

@interface PPIntroView () <UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *imagesName;
@property (nonatomic, assign) UIScrollView *scrollView;
@property (nonatomic, assign) UIImageView *indexImageView;

@end

@implementation PPIntroView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor whiteColor];
        
        self.imagesName = @[@"a0", @"a1", @"a2"];
        UIImage *im = [UIImage imageNamed:_imagesName[0]];
        
        UIScrollView *sv = [[UIScrollView alloc] initWithFrame:frame];
        sv.delegate = self;
        sv.contentSize = CGSizeMake(frame.size.width*_imagesName.count, frame.size.height);
        sv.pagingEnabled = YES;
        [self addSubview:sv];
        self.scrollView = sv;
        
        im = [UIImage imageNamed:[NSString stringWithFormat:@"%@-x", _imagesName[0]]];
        UIImageView *iv = [[UIImageView alloc] initWithImage:im];
        iv.frame = CGRectMake(0, frame.size.height-im.size.height-10.0, im.size.width, im.size.height);
        iv.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight;
        [self addSubview:iv];
        self.indexImageView = iv;
        
        int i=0;
        for (NSString *img in _imagesName)
        {
            im = [UIImage imageNamed:img];
            iv = [[UIImageView alloc] initWithImage:im];
            [_scrollView addSubview:iv];
            
            iv.frame = CGRectMake(i*im.size.width, 0, im.size.width, im.size.height);
            i++;
        }
    }
    return self;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    int i = ceil(scrollView.contentOffset.x/self.bounds.size.width);
    
    UIImage *im = [UIImage imageNamed:[NSString stringWithFormat:@"%@-x", _imagesName[i]]];
    _indexImageView.image = im;
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
