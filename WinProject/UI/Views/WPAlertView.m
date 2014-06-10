//
//  WPAlertView.m
//  WinProject
//
//  Created by Dean-Z on 14-5-23.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPAlertView.h"
#import "FTAnimationManager.h"

@implementation WPAlertView

-(void)showWithMessage:(NSString*)message
{
    self.app = [AppDelegate shareAppDelegate];
    UIWindow* window = self.app.window;
    
    self.backgroundView = [[UIView alloc]initWithFrame:window.bounds];
    [self.backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)]];
    self.backgroundView.backgroundColor = COLOR(0, 0, 0, 0.5);
    [window addSubview:self.backgroundView];
    
    self.center = window.center;
    [window addSubview:self];
    self.hidden = YES;
    
    CAAnimation* popAnim = [[FTAnimationManager sharedManager]popInAnimationFor:self duration:0.3 delegate:nil startSelector:nil stopSelector:nil];
    [self.layer addAnimation:popAnim forKey:@"POP"];
    
    self.messageLabel.text = message;
}

- (IBAction)close:(id)sender
{
    CAAnimation* popAnim = [[FTAnimationManager sharedManager]popOutAnimationFor:self duration:0.3 delegate:nil startSelector:nil stopSelector:nil];
    [self.layer addAnimation:popAnim forKey:@"POP"];
    
    [self.backgroundView removeFromSuperview];
    self.backgroundView = nil;
    
    [self performSelector:@selector(cleanView) withObject:nil afterDelay:0.5];
}

- (void)dismiss
{
    [self close:nil];
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
