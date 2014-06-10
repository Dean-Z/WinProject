//
//  ConversionAlertView.m
//  WinProject
//
//  Created by Dean-Z on 14-6-9.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "ConversionAlertView.h"
#import "FTAnimationManager.h"

@implementation ConversionAlertView

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
    
    self.addressButton.layer.cornerRadius = 3.0f;
    self.addressButton.layer.masksToBounds = YES;
    self.cancelButton.layer.cornerRadius = 3.0f;
    self.cancelButton.layer.masksToBounds = YES;
    self.addressField.inputAccessoryView = [self inputAccessoryBar];
    
    self.backgroundView = [[UIView alloc]initWithFrame:self.app.window.bounds];
    self.backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5f];
    [self.backgroundView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiass)]];
    
    self.productName.text = self.conversionInfo.title;
    self.needCoins.text = [NSString stringWithFormat:@"%@金币",self.conversionInfo.coins];
    
    WPUserInfo* userInfo = self.app.userInfo;
    NSInteger coins = [userInfo.coins integerValue] - [self.conversionInfo.coins integerValue];
    self.hasCoins.text = [NSString stringWithFormat:@"%d金币",coins];
}

- (void)showInWindows
{
    [self.app.window addSubview:self.backgroundView];
    
    self.center = self.app.window.center;
    self.hidden = YES;
    [self.app.window addSubview:self];
    
    CAAnimation* popAnim = [[FTAnimationManager sharedManager]popInAnimationFor:self duration:0.3 delegate:nil startSelector:nil stopSelector:nil];
    [self.layer addAnimation:popAnim forKey:@"POP"];
}

- (IBAction)selectCount:(id)sender
{
    WPDateSelecter* selecter = [WPDateSelecter viewFromXib];
    selecter.delegate = self;
    selecter.rowCount = 9;
    [selecter renderView];
    [selecter showInWindow];
}

- (IBAction)sure:(id)sender
{
    [self dismiass];
}

- (IBAction)addressContainerHidden:(id)sender
{
    self.addressContainer.hidden = YES;
    self.addressButton.hidden = NO;
}

- (IBAction)addAddress:(id)sender
{
    self.addressContainer.hidden = NO;
    self.addressButton.hidden = YES;
}

- (void)dateSelecterAtIndex:(NSInteger)index
{
    [self.productCount setTitle:[NSString stringWithFormat:@"%d",index] forState:UIControlStateNormal];
    self._count = index;
    
    self.needCoins.text = [NSString stringWithFormat:@"%d金币",[self.conversionInfo.coins integerValue]*index];
    
    WPUserInfo* userInfo = self.app.userInfo;
    NSInteger coins = [userInfo.coins integerValue] - [self.conversionInfo.coins integerValue]*index;
    self.hasCoins.text = [NSString stringWithFormat:@"%d金币",coins];
}

- (void)dismiass
{
    [self.addressField resignFirstResponder];
    
    CAAnimation* popAnim = [[FTAnimationManager sharedManager]popOutAnimationFor:self duration:0.3 delegate:nil startSelector:nil stopSelector:nil];
    [self.layer addAnimation:popAnim forKey:@"POP"];
    
    [self.backgroundView removeFromSuperview];
    [self performSelector:@selector(removerSuberViews) withObject:nil afterDelay:0.5];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.4 animations:^{
        self.originY = 0;
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.4 animations:^{
        self.centerY = self.app.window.centerY;
    }];
}

- (void)dismissKeyBoard
{
    [self.addressField resignFirstResponder];
}

- (void) removerSuberViews
{
    for (UIView* view in self.subviews)
    {
        [view removeFromSuperview];
    }
    [self removeFromSuperview];
}


@end
