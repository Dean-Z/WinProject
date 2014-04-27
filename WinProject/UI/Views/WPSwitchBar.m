//
//  WPSwitchBar.m
//  WinProject
//
//  Created by Dean on 14-4-27.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPSwitchBar.h"
#import <objc/message.h>

@implementation WPSwitchBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)renderBarWithLeftContenct:(NSString*)left RightContent:(NSString*)right action:(SEL)action target:(UIViewController *)target
{
    self.switchLeftLabel.text = left;
    self.switchRightLabel.text = right;
    
    self.action = action;
    self.target = target;
}

- (IBAction)onButtonClick:(id)sender
{
    UIButton* button = (UIButton*)sender;
    
    if (button == self.switchLeftButton)
    {
        self.selectAtIndex = 0;
        [self.switchRightbg setImage:[UIImage imageNamed:@"market_gray"]];
        [self.switchLeftbg setImage:[UIImage imageNamed:@"btn_chayedan_sel"]];
    }
    else if(button == self.switchRightButton)
    {
        self.selectAtIndex = 1;
        [self.switchRightbg setImage:[UIImage imageNamed:@"market_yellow"]];
        [self.switchLeftbg setImage:[UIImage imageNamed:@"btn_chayedan_nol"]];
    }
    
    if (self.action)
    {
        objc_msgSend(self.target, self.action);
    }
}

@end
