//
//  RakeView.h
//  WinProject
//
//  Created by Dean-Z on 14-4-29.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBaseView.h"
#import "WPSwitchBar.h"
#import "WPPullView.h"

@interface RakeView : WPBaseView
{
    WPSwitchBar* switchBar;
    WPPullView* pullView;
}

@property(nonatomic,weak) IBOutlet UIView* switchBarContainer;

@end
