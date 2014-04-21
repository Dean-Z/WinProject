//
//  WPSignupView.m
//  WinProject
//
//  Created by Dean on 14-4-18.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPSignupView.h"

@implementation WPSignupView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}


- (void) renderView
{
    
}

- (IBAction)back:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(signupBackAction)])
    {
        [self.phoneTextField resignFirstResponder];
        [self.delegate signupBackAction];
    }
}

@end
