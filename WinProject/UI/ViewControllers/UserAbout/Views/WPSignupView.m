//
//  WPSignupView.m
//  WinProject
//
//  Created by Dean on 14-4-18.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPSignupView.h"

@implementation WPSignupView
{
    CheckItemView* checkItem;
}

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
    [self.phoneTextField setInputAccessoryView:[self inputAccessoryBar]];
    [self prepareCheckItem];
}

-(void) prepareCheckItem
{
    if (checkItem == nil)
    {
        checkItem = [CheckItemView viewFromXib];
        checkItem.delegate = self;
        [self.checkViewContainer addSubview:checkItem];
    }
}

- (void) CheckItemViewisClicked:(BOOL)click
{
    [self.okButton setEnabled:click];
}

- (IBAction)signup:(id)sender
{
    if (![NSString checkTel:self.phoneTextField.text])
    {
        Alert(@"请输入正确的电话号码");
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(signupWithNumber:)])
    {
        [self.delegate signupWithNumber:self.phoneTextField.text];
    }
}

- (IBAction)back:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(signupBackAction)])
    {
        [self.delegate signupBackAction];
    }
}

- (void)dismissKeyBoard
{
    [self.phoneTextField resignFirstResponder];
}

@end
