//
//  PPURLImageView.h
//  PigParking
//
//  Created by Vincent on 7/18/14.
//  Copyright (c) 2014 VincentStation. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PPURLImageView : UIImageView
{
    AFHTTPRequestOperation *_requestOperation;
}

@property (nonatomic, assign) NSString *imageUrl;

@end
