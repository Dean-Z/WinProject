//
//  WPRegisterAlert.m
//  WinProject
//
//  Created by Dean-Z on 14-5-12.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPRegisterAlert.h"
#import "FTAnimationManager.h"

@implementation WPRegisterAlert

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


- (void)renderView
{
    [super renderView];
    UIWindow* window = self.app.window;
    
    UIView* view = [[UIView alloc]initWithFrame:window.bounds];
    view.backgroundColor = COLOR(0, 0, 0, 0.5);
    view.tag = 9999;
    [window addSubview:view];
    
    self.center = window.center;
    [window addSubview:self];
    self.hidden = YES;
    
    CAAnimation* popAnim = [[FTAnimationManager sharedManager]popInAnimationFor:self duration:0.3 delegate:nil startSelector:nil stopSelector:nil];
    [self.layer addAnimation:popAnim forKey:@"POP"];
}

- (IBAction)sure:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(registerSucceed)])
    {
        [self.delegate registerSucceed];
    }
    
    CAAnimation* popAnim = [[FTAnimationManager sharedManager]popOutAnimationFor:self duration:0.3 delegate:nil startSelector:nil stopSelector:nil];
    [self.layer addAnimation:popAnim forKey:@"POP"];
    
    UIWindow* window = self.app.window;
    UIView *view = [window viewWithTag:9999];
    [view removeFromSuperview];
    view = nil;
    
    [self performSelector:@selector(cleanView) withObject:nil afterDelay:0.5];
}

-(void)cleanView
{
    for (UIView* view in self.subviews)
    {
        [view removeFromSuperview];
    }
    [self removeFromSuperview];
}

@end
