//
//  WPProductDetailView.m
//  WinProject
//
//  Created by Dean-Z on 14-5-26.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPProductDetailView.h"
#import "FTAnimationManager.h"

@implementation WPProductDetailView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)renderView
{
    [super renderView];
    
    self.backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.app.window.sizeW, self.app.window.sizeH)];
    self.backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    
    self.titleLabel.text = self.productInfo.title;
    self.descLabel.text = self.productInfo.description;
    
    self.originY = self.app.window.sizeH/2 - self.sizeH/2;
    self.originX = self.app.window.sizeW/2 - self.sizeW/2;
    
    [self.app.window addSubview:self.backgroundView];
    [self.app.window addSubview:self];
    
    self.hidden = YES;
    
    CAAnimation* popAnim = [[FTAnimationManager sharedManager]popInAnimationFor:self duration:0.3 delegate:nil startSelector:nil stopSelector:nil];
    [self.layer addAnimation:popAnim forKey:@"POP"];
}

- (IBAction)cancel:(id)sender
{
    [self dismiss];
}

- (IBAction)download:(id)sender
{
    [self dismiss];
    
    if ([self.delegate respondsToSelector:@selector(productDownload:)])
    {
        [self.delegate productDownload:self.productInfo];
    }
}

- (void)dismiss
{
    CAAnimation* popAnim = [[FTAnimationManager sharedManager]popOutAnimationFor:self duration:0.3 delegate:nil startSelector:nil stopSelector:nil];
    [self.layer addAnimation:popAnim forKey:@"POP"];
    
    [self.backgroundView removeFromSuperview];
    
    [self performSelector:@selector(removeView) withObject:nil afterDelay:0.4];
}

-(void)removeView
{
    [self removeFromSuperview];
}

@end
