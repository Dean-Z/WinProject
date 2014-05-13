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
    [self.phoneTextField setValue:[UIColor colorWithHexString:@"584f4a"]
                                forKeyPath:@"_placeholderLabel.textColor"];
    [self.passwordTextField setValue:[UIColor colorWithHexString:@"584f4a"]
                                forKeyPath:@"_placeholderLabel.textColor"];
#ifdef DEBUG
    [self.phoneTextField setText:@"rirny"];
    [self.passwordTextField setText:@"123123"];
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
    
}

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url
{
    if ([label.text isEqualToString:self.forgotPasswordLabel.text])
    {
        DLog(@"Forgot password!!");
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
        [dict setValue:self.phoneTextField.text forKey:@"Phone"];
        [dict setValue:[self.passwordTextField.text MD5] forKey:@"Password"];
        [[WPSyncService alloc]syncWithRoute:dict Block:^(id resp) {
            
        }];
    }
    else
    {
        Alert(@"手机号或密码不能为空!");
    }
}

@end
