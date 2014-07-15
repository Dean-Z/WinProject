//
//  AlipayView.m
//  WinProject
//
//  Created by Dean-Z on 14-6-7.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "AlipayView.h"

@implementation AlipayView

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
    self.passwordContainer.layer.cornerRadius = 3.0f;
    self.passwordContainer.layer.masksToBounds = YES;
    self.coinsContainer.layer.cornerRadius = 3.0f;
    self.coinsContainer.layer.masksToBounds = YES;
    self.alertContainer.layer.cornerRadius = 3.0f;
    self.alertContainer.layer.masksToBounds = YES;
    self.nameContainer.layer.cornerRadius = 3.0f;
    self.nameContainer.layer.masksToBounds = YES;
    self.accountContainer.layer.cornerRadius = 3.0f;
    self.accountContainer.layer.masksToBounds = YES;
    
    UIImage *fieldImage = [UIImage imageNamed:@"icon-info-input-bg.png"];
    fieldImage = [fieldImage resizableImageWithCapInsets:UIEdgeInsetsMake(11, 16, 11, 16)];
    self.passwordBgImageView.image = fieldImage;
    self.accountBgImageView.image = fieldImage;
    self.nameBgImageView.image = fieldImage;
    
    self.accountField.inputAccessoryView = [self inputAccessoryBar];
    self.nameField.inputAccessoryView = [self inputAccessoryBar];
    self.passwordField.inputAccessoryView = [self inputAccessoryBar];
    
    [self drawButtonsWithButton:self.coin1 isSelected:YES];
    [self drawButtonsWithButton:self.coin10 isSelected:NO];
    [self drawButtonsWithButton:self.coin20 isSelected:NO];
    [self drawButtonsWithButton:self.coin50 isSelected:NO];
    
    self.hasCoins.text = [NSString stringWithFormat:@"当前账户：%@金币",self.app.userInfo.coins];
    
    _currentCoins = 1;
}

- (void) drawButtonsWithButton:(UIButton*)button isSelected:(BOOL)selected
{
    if (selected)
    {
        button.layer.borderColor = [UIColor colorWithHexString:@"f18d0c"].CGColor;
    }
    else
    {
        button.layer.borderColor = [UIColor colorWithHexString:@"9d9d9d"].CGColor;
    }
    button.layer.borderWidth = 2.f;
}

- (IBAction)coinSelect:(UIButton*)sender
{
    if (sender == self.coin1)
    {
        [self drawButtonsWithButton:self.coin1 isSelected:YES];
        [self drawButtonsWithButton:self.coin10 isSelected:NO];
        [self drawButtonsWithButton:self.coin20 isSelected:NO];
        [self drawButtonsWithButton:self.coin50 isSelected:NO];
        
        _currentCoins = 1;
    }
    else if (sender == self.coin10)
    {
        [self drawButtonsWithButton:self.coin1 isSelected:NO];
        [self drawButtonsWithButton:self.coin10 isSelected:YES];
        [self drawButtonsWithButton:self.coin20 isSelected:NO];
        [self drawButtonsWithButton:self.coin50 isSelected:NO];
        
        _currentCoins = 10;
    }
    else if (sender == self.coin20)
    {
        [self drawButtonsWithButton:self.coin1 isSelected:NO];
        [self drawButtonsWithButton:self.coin10 isSelected:NO];
        [self drawButtonsWithButton:self.coin20 isSelected:YES];
        [self drawButtonsWithButton:self.coin50 isSelected:NO];
        
        _currentCoins = 20;
    }
    else if (sender == self.coin50)
    {
        [self drawButtonsWithButton:self.coin1 isSelected:NO];
        [self drawButtonsWithButton:self.coin10 isSelected:NO];
        [self drawButtonsWithButton:self.coin20 isSelected:NO];
        [self drawButtonsWithButton:self.coin50 isSelected:YES];
        
        _currentCoins = 50;
    }
    
    self.needCoins.text = [NSString stringWithFormat:@"%d金币",_currentCoins*10];
}

- (IBAction)send:(id)sender
{
    NSUserDefaults* user = [NSUserDefaults standardUserDefaults];
    if (![self.passwordField.text isEqualToString:[user objectForKey:UserPassword]])
    {
        [[WPAlertView viewFromXib] showWithMessage:@"登陆密码错误"];
        return;
    }
    else if ([NSString isNilOrEmpty:self.nameField.text] || [NSString isNilOrEmpty:self.accountField.text])
    {
       [[WPAlertView viewFromXib] showWithMessage:@"请完善信息！"];
        return;
    }
    NSDictionary* parm = @{@"app":@"cash",@"act":@"do",@"email":self.accountField.text,@"name":self.nameField.text,@"coin":[NSString stringWithFormat:@"%d",_currentCoins*10]};
    
    
    __weak AlipayView *alipay = self;
    self.userInteractionEnabled = NO;
    [[WPSyncService alloc]syncWithRoute:parm Block:^(id resp) {
        if (resp)
        {
            WPUserInfo* userInfo = alipay.app.userInfo;
            id data = [NSObject toJSONValue:resp];
            id result = [data objectForKey:@"result"];
            userInfo.coins = [result objectForKey:@"balance"];
            alipay.userInteractionEnabled = YES;
            
            Alert(@"兑换成功");
            [self.delegate alipayDismiss];
        }
    }];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.accountField)
    {
        [self.delegate alipayViewAccountFieldDidBeginEditing];
    }
}

- (IBAction)forgetPassword:(id)sender
{
    
}

- (void)dismissKeyBoard
{
    [self.passwordField resignFirstResponder];
    [self.nameField resignFirstResponder];
    [self.accountField resignFirstResponder];
}

@end
