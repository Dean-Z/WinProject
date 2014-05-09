//
//  WPNickName.m
//  WinProject
//
//  Created by Dean-Z on 14-5-9.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPNickName.h"

@implementation WPNickName

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
    [self.nickTextField setValue:[UIColor colorWithHexString:@"584f4a"]
                       forKeyPath:@"_placeholderLabel.textColor"];
}

- (IBAction)complation:(id)sender
{
    [self.nickTextField resignFirstResponder];
    if ([self.delegate respondsToSelector:@selector(nickNameCompliation)])
    {
        [self.delegate nickNameCompliation];
    }
}

- (IBAction)back:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(nickNameBack)])
    {
        [self.delegate nickNameBack];
    }
}

@end
