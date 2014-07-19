//
//  PPURLImageView.m
//  PigParking
//
//  Created by Vincent on 7/18/14.
//  Copyright (c) 2014 VincentStation. All rights reserved.
//

#import "PPURLImageView.h"

@implementation PPURLImageView

- (void)dealloc
{
    [_requestOperation cancel];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor blackColor];
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

- (void)setImageUrl:(NSString *)imageUrl
{
    {
        UIImage *im = [PPImageCache imageFromCache:imageUrl];
        if (im)
        {
            self.image = im;
            return;
        }
    }
    
    __weak PPURLImageView *myself = self;
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    [self addSubview:hud];
    [hud show:YES];
    
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]];
    _requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:req];
    [_requestOperation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        hud.progress = (float)totalBytesRead / (float)totalBytesExpectedToRead;
    }];
    
    [_requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [hud hide:YES];
        
        UIImage *im = [UIImage imageWithData:responseObject];
        if (!im)
        {
            return ;
        }
        myself.image = im;
        
        [PPImageCache saveToCache:im fromUrl:imageUrl];
    }
                              failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                  
                              }];
    [_requestOperation start];
}

- (void)setImageUrl:(NSString *)imageUrl complete:(void(^)(UIImage *image))complete
{
    {
        UIImage *im = [PPImageCache imageFromCache:imageUrl];
        if (im)
        {
            self.image = im;
            complete(im);
            return;
        }
    }
    
    __weak PPURLImageView *myself = self;
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self];
    hud.mode = MBProgressHUDModeAnnularDeterminate;
    [self addSubview:hud];
    [hud show:YES];
    
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]];
    _requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:req];
    [_requestOperation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        hud.progress = (float)totalBytesRead / (float)totalBytesExpectedToRead;
    }];
    
    [_requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        [hud hide:YES];
        
        UIImage *im = [UIImage imageWithData:responseObject];
        if (!im)
        {
            complete(nil);
            return ;
        }
        myself.image = im;
        [PPImageCache saveToCache:im fromUrl:imageUrl];
        complete(im);
    }
                                             failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                 complete(nil);
                                             }];
    [_requestOperation start];
}

@end
