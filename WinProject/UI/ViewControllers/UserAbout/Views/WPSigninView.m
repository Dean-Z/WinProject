//
//  WPSigninView.m
//  WinProject
//
//  Created by Dean on 14-4-18.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPSigninView.h"
#import "NSString+Extention.h"

@implementation WPSigninView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void) renderView
{
    [super renderView];
    [self.phoneTextField setValue:[UIColor colorWithHexString:@"584f4a"]
                                forKeyPath:@"_placeholderLabel.textColor"];
    [self.passwordTextField setValue:[UIColor colorWithHexString:@"584f4a"]
                                forKeyPath:@"_placeholderLabel.textColor"];
#ifdef DEBUG
    [self.phoneTextField setText:@"18217144855"];
    [self.passwordTextField setText:@"123456"];
#endif
    
    NSMutableDictionary *linkAttributes = [NSMutableDictionary dictionary];
    [linkAttributes setValue:[NSNumber numberWithBool:YES] forKey:(NSString *)kCTUnderlineStyleAttributeName];
    self.forgotPasswordLabel.linkAttributes = linkAttributes;
    
    NSMutableDictionary *mutableActiveLinkAttributes = [NSMutableDictionary dictionary];
    [mutableActiveLinkAttributes setValue:[NSNumber numberWithBool:NO] forKey:(NSString *)kCTUnderlineStyleAttributeName];
    self.forgotPasswordLabel.activeLinkAttributes = mutableActiveLinkAttributes;
    
    self.forgotPasswordLabel.delegate = self;
    
    [self.forgotPasswordLabel setText:self.forgotPasswordLabel.text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        return mutableAttributedString;
    }];
    
    NSRange range = NSMakeRange(0, [self.forgotPasswordLabel.text length]);
    NSURL *url = [NSURL URLWithString:@"http://forgotpassword"];
    [self.forgotPasswordLabel addLinkToURL:url withRange:range];
    
    ValidationBlock validatedFieldBlock = ^(ValidationResult result, BOOL isEditing)
    {
        switch (result) {
            case ValidationPassed:
                DLog(@"Field is valid.");
                break;
                
            case ValidationFailed:
                DLog(@"Field is invalid.");
                break;
                
            case ValueTooShortToValidate:
                DLog(@"Value too short to validate. Type longer");
                break;
        }
    };
    
    self.phoneTextField.validatedFieldBlock = validatedFieldBlock;
    self.phoneTextField.inputAccessoryView = [self inputAccessoryBar];
    self.passwordTextField.validatedFieldBlock = validatedFieldBlock;
    self.passwordTextField.inputAccessoryView = [self inputAccessoryBar];
}

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url
{
    if ([label.text isEqualToString:self.forgotPasswordLabel.text])
    {
        if ([self.delegate respondsToSelector:@selector(findPassword)])
        {
            [self.delegate findPassword];
        }
    }
}

- (IBAction)registerAction:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(signRegister)])
    {
        [self.delegate signRegister];
    }
}

- (IBAction)login:(id)sender
{
    if (![NSString isNilOrEmpty:self.phoneTextField.text] && ![NSString isNilOrEmpty:self.passwordTextField.text])
    {
        NSMutableDictionary* dict = [@{@"app":@"index",@"act":@"login"} mutableCopy];
        [dict setValue:self.phoneTextField.text forKey:@"account"];
        [dict setValue:[self.passwordTextField.text MD5] forKey:@"password"];
        [[WPSyncService alloc]loginWithRoute:dict Block:^(id resp)
        {
            if (resp)
            {
                if ([self.delegate respondsToSelector:@selector(signinSucceed)])
                {
                    
                    Alert(@"登陆成功");
                    self.app.phoneNumber = self.phoneTextField.text;
                    [self.app.userInfo setRowDate:resp];
                    [self.app.userInfo save:USER_INFO_ROWDATA];
                    
                    [self.delegate signinSucceed];
                }
            }
        }];
    }
    else
    {
        Alert(@"手机号或密码不能为空!");
    }
}

- (void)dismissKeyBoard
{
    [self.phoneTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}


@end
