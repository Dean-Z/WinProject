//
//  WPPullView.m
//  WinProject
//
//  Created by Dean-Z on 14-5-8.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPPullView.h"

@implementation WPPullView

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
    [self.firstCellLabel setFont:[UIFont fontWithName:@"DFWaWaSC-W5" size:10]];
    self.firstCellLabel.text = [self.exchangeArray firstObject];
    isPull = YES;
}

- (IBAction)pullAction:(id)sender
{
    isPull  = !isPull;
    
    if (isPull)
    {
        [UIView transitionWithView:self duration:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.sizeH = self.pullViewSelected.sizeH;
        } completion:^(BOOL finished) {
            self.pullViewNormal.hidden = YES;
            self.pullViewSelected.hidden = NO;
        }];
    }
    else
    {
        [UIView transitionWithView:self duration:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.sizeH = self.pullViewNormal.sizeH;
        } completion:^(BOOL finished) {
            self.pullViewNormal.hidden = NO;
            self.pullViewSelected.hidden = YES;    
        }];
    }
}

- (void)fillDate
{
    self.firstCellLabel.text = [NSString stringWithFormat:@"%@兑换了%@金币",self.rakeInfo.nickname,self.rakeInfo.coins];
}

@end
