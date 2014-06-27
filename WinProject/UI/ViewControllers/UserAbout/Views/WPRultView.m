//
//  WPRultView.m
//  WinProject
//
//  Created by Dean-Z on 14-5-12.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPRultView.h"
#import "FTAnimationManager.h"

@implementation WPRultView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(void)showWithMessage:(NSString*)message title:(NSString*)title
{
    self.app = [AppDelegate shareAppDelegate];
    UIWindow* window = self.app.window;
    
    self.titleLabel.text = title;
    
    self.messageLabel.text = [NSString stringWithFormat:@"%@",message];
    
    CGSize size = [self.messageLabel.text sizeWithFont:self.messageLabel.font constrainedToSize:CGSizeMake(190, 2000) lineBreakMode:self.messageLabel.lineBreakMode];
    
    self.messageLabel.numberOfLines = 0;
    self.messageLabel.sizeH = size.height;
    
    self.containScrollView.contentSize = CGSizeMake(0, self.messageLabel.height);
    
    UIView* view = [[UIView alloc]initWithFrame:window.bounds];
    view.backgroundColor = COLOR(0, 0, 0, 0.5);
    view.tag = 10001;
    [window addSubview:view];
    
    self.center = window.center;
    [window addSubview:self];
    self.hidden = YES;
    
    CAAnimation* popAnim = [[FTAnimationManager sharedManager]popInAnimationFor:self duration:0.3 delegate:nil startSelector:nil stopSelector:nil];
    [self.layer addAnimation:popAnim forKey:@"POP"];
    
}

- (IBAction)close:(id)sender
{
    CAAnimation* popAnim = [[FTAnimationManager sharedManager]popOutAnimationFor:self duration:0.3 delegate:nil startSelector:nil stopSelector:nil];
    [self.layer addAnimation:popAnim forKey:@"POP"];
    
    UIWindow* window = self.app.window;
    UIView *view = [window viewWithTag:10001];
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
    UIView *view = [window viewWithTag:10001];
    [view removeFromSuperview];
    view = nil;
    
    [self removeFromSuperview];
}

@end
