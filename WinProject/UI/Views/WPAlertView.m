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
    
    UIView* view = [[UIView alloc]initWithFrame:window.bounds];
    view.backgroundColor = COLOR(0, 0, 0, 0.5);
    view.tag = 10000;
    [window addSubview:view];
    
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
    
    UIWindow* window = self.app.window;
    UIView *view = [window viewWithTag:10000];
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
    
    UIWindow* window = self.app.window;
    UIView *view = [window viewWithTag:10000];
    [view removeFromSuperview];
    view = nil;
    
    [self removeFromSuperview];
}
@end
