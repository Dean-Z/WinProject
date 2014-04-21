//
//  WPSignupView.h
//  WinProject
//
//  Created by Dean on 14-4-18.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBaseView.h"

@protocol WPSignupViewDelegate;

@interface WPSignupView : WPBaseView

@property(nonatomic,assign) id<WPSignupViewDelegate> delegate;
@property(nonatomic,weak) IBOutlet UITextField* phoneTextField;

@end

@protocol WPSignupViewDelegate <NSObject>

- (void) signupBackAction;

@end