//
//  WPAuthView.m
//  WinProject
//
//  Created by Dean-Z on 14-5-8.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPAuthView.h"

@implementation WPAuthView

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
    [self.authCodeTextField setValue:[UIColor colorWithHexString:@"584f4a"]
                          forKeyPath:@"_placeholderLabel.textColor"];
    self.phoneNumber.text = self.phoneNumebrString;
    
    count = 60;
    [self performSelector:@selector(downcount) withObject:nil afterDelay:1.0f];
}


- (void) downcount
{
    count--;
    self.downcountLabel.text = [NSString stringWithFormat:@"验证倒计时：%d秒",count];
    if (count > 0)
    {
        [self performSelector:@selector(downcount) withObject:nil afterDelay:1.0f];
    }
}

- (IBAction)back:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(authBack)])
    {
        [self.delegate authBack];
    }
}

@end
