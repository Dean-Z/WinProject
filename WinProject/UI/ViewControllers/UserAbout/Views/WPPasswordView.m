//
//  WPPasswordView.m
//  WinProject
//
//  Created by Dean-Z on 14-5-9.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPPasswordView.h"

@implementation WPPasswordView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void) renderView
{
    [self.password_1 setValue:[UIColor colorWithHexString:@"584f4a"]
                       forKeyPath:@"_placeholderLabel.textColor"];
    [self.password_2 setValue:[UIColor colorWithHexString:@"584f4a"]
                          forKeyPath:@"_placeholderLabel.textColor"];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.password_1)
    {
        if ([textField.text length]<6)
        {
            [self.errorLabel_1 setText:@"密码不能少于6位数"];
        }
        else
        {
            [self.errorLabel_1 setHidden:YES];
        }
    }
}


- (IBAction)back:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(passwordBack)])
    {
        [self.delegate passwordBack];
    }
}

- (IBAction)passwordSetSucceed:(id)sender
{
    if (![self.password_1.text isEqualToString:self.password_2.text])
    {
        [self.errorLabel_2 setText:@"2次输入的密码不一致"];
    }
    
    if ([self.delegate respondsToSelector:@selector(passwordSucceed)])
    {
        [self.delegate passwordSucceed];
    }
}

@end
