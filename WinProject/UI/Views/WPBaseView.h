//
//  WPBaseView.h
//  WinProject
//
//  Created by Dean on 14-4-18.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WPBaseView : UIView

@property(nonatomic,strong) AppDelegate* app;

- (void) renderView;

@end
