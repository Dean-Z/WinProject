//
//  QQImageView.h
//  ListDemo
//
//  Created by Dean on 13-10-30.
//  Copyright (c) 2013年 Dean. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIHTTPRequest.h"
#import "ASIDownloadCache.h"

typedef enum {
    IMAGE_NA        = 0,
    IMAGE_LOADING   = 1,
    IMAGE_DONE      = 2,
    IMAGE_LOADFAIL  = 3,
}QQImageViewState;

@interface QQImageView : UIImageView<ASIHTTPRequestDelegate>

@property(nonatomic,strong) NSURL           *imageUrl;

@property(nonatomic,strong) UIImage         *defualtImage;

@property(nonatomic,strong) ASIHTTPRequest  *imageRequest;

@property(nonatomic)QQImageViewState        loadState;

-(void)setImageUrl:(NSURL *)imageUrl DefaultImage:(UIImage*)defaultImage;

@end
