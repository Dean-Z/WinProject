//
//  WPInviteView.m
//  WinProject
//
//  Created by Dean-Z on 14-6-5.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPInviteView.h"
#import "FTAnimationManager.h"

@implementation WPInviteView

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
    
    self.phoneTextField.inputAccessoryView = [self inputAccessoryBar];
    
    self.backgroundView = [[UIView alloc]initWithFrame:self.app.window.bounds];
    [self.backgroundView setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.5]];
    
    UITapGestureRecognizer* tap =  [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
    [self.backgroundView addGestureRecognizer:tap];
    tap = nil;
    
    [self.app.window addSubview:self.backgroundView];
    [self showInWindow];
}

- (void)showInWindow
{
    self.originX = (self.app.window.sizeW - self.sizeW)/2;
    if (IS_IPHONE_5)
    {
        self.originY = (self.app.window.sizeH - self.sizeH)/2;
    }
    else
    {
        self.originY = (self.app.window.sizeH - self.sizeH)/2 - 40;
    }
    self.hidden = YES;
    [self.app.window addSubview:self];
    CAAnimation* popAnim = [[FTAnimationManager sharedManager]popInAnimationFor:self duration:0.3 delegate:nil startSelector:nil stopSelector:nil];
    [self.layer addAnimation:popAnim forKey:@"POP"];
}

- (void)dismiss
{
    [self.phoneTextField resignFirstResponder];
    CAAnimation* popAnim = [[FTAnimationManager sharedManager]popOutAnimationFor:self duration:0.3 delegate:nil startSelector:nil stopSelector:nil];
    [self.layer addAnimation:popAnim forKey:@"POP"];
    
    [self performSelector:@selector(removeFromWindow) withObject:nil afterDelay:0.5];
    
    [self.backgroundView removeFromSuperview];
}

- (void)removeFromWindow
{
    for (UIView* view in self.subviews)
    {
        [view removeFromSuperview];
    }
    [self removeFromSuperview];
}

- (IBAction)invite:(id)sender
{
    if (![NSString checkTel:self.phoneTextField.text])
    {
        [[WPAlertView viewFromXib] showWithMessage:@"请输入正确的电话号码"];
        return;
    }
    
    NSDictionary *parm = @{@"app":@"user",@"act":@"recom",@"phone":self.phoneTextField.text};
    
    [[WPSyncService alloc]syncWithRoute:parm Block:^(id resp) {
        if (resp)
        {
            [self.delegate inviteSucceed];
            [[WPAlertView viewFromXib] showWithMessage:@"发送成功"];
            [self dismiss];
        }
    }];
}

- (void)dismissKeyBoard
{
    [self.phoneTextField resignFirstResponder];
}


@end
