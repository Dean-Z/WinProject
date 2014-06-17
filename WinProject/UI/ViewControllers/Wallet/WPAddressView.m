//
//  WPAddressView.m
//  WinProject
//
//  Created by Dean-Z on 14-6-17.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPAddressView.h"
#import "FTAnimationManager.h"

@implementation WPAddressView

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
    
    self.backgroundView = [[UIView alloc]initWithFrame:self.app.window.bounds];
    self.backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5f];
    [self.backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)]];
    
    self.addressField.inputAccessoryView = [self inputAccessoryBar];
}

- (void)showInWindow
{
    [self.app.window addSubview:self.backgroundView];
    
    self.center = self.app.window.center;
    if (!IS_IPHONE_5)
    {
        self.centerY -= 40.0f;
    }
    else
    {
        self.centerY -= 20;
    }
    self.hidden = YES;
    [self.app.window addSubview:self];
    
    CAAnimation* popAnim = [[FTAnimationManager sharedManager]popInAnimationFor:self duration:0.3 delegate:nil startSelector:nil stopSelector:nil];
    [self.layer addAnimation:popAnim forKey:@"POP"];
}

- (void)dismiss
{
    [self.addressField resignFirstResponder];
    
    CAAnimation* popAnim = [[FTAnimationManager sharedManager]popOutAnimationFor:self duration:0.3 delegate:nil startSelector:nil stopSelector:nil];
    [self.layer addAnimation:popAnim forKey:@"POP"];
    
    [self.backgroundView removeFromSuperview];
    [self performSelector:@selector(removerSuberViews) withObject:nil afterDelay:0.5];
}

- (void) removerSuberViews
{
    for (UIView* view in self.subviews)
    {
        [view removeFromSuperview];
    }
    [self removeFromSuperview];
}


- (IBAction)addAddress:(id)sender
{
    if ([NSString isNilOrEmpty:self.addressField.text]) {
        [[WPAlertView viewFromXib] showWithMessage:@"地址不能为空"];
        return;
    }
    
    [self.addressField resignFirstResponder];
    
    NSDictionary* parm = @{@"app":@"address",
                          @"act":@"add",
                          @"address":self.addressField.text,
                          @"default":@"1"};
    [[WPSyncService alloc]syncWithRoute:parm Block:^(id resp) {
        if (resp)
        {
            [self.delegate addAddressDone];
            [[WPAlertView viewFromXib] showWithMessage:@"添加成功"];
            [self dismiss];
        }
    }];
}

- (IBAction)cancel:(id)sender
{
    [self dismiss];
}

- (void)dismissKeyBoard
{
     [self.addressField resignFirstResponder];
}


@end
