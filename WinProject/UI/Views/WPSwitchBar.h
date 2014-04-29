//
//  WPSwitchBar.h
//  WinProject
//
//  Created by Dean on 14-4-27.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBaseView.h"

@interface WPSwitchBar : WPBaseView

@property(nonatomic,weak) IBOutlet UIImageView* switchLeftbg;
@property(nonatomic,weak) IBOutlet UIImageView* switchRightbg;
@property(nonatomic,weak) IBOutlet UILabel*    switchLeftLabel;
@property(nonatomic,weak) IBOutlet UILabel*    switchRightLabel;
@property(nonatomic,weak) IBOutlet UIButton*    switchLeftButton;
@property(nonatomic,weak) IBOutlet UIButton*    switchRightButton;
@property(nonatomic,assign) SEL  action;
@property(nonatomic,assign) NSInteger selectAtIndex;
@property(nonatomic,strong) id target;

-(void)renderBarWithLeftContenct:(NSString*)left RightContent:(NSString*)right action:(SEL)action target:(id)target;

@end
