//
//  WPSignupView.h
//  WinProject
//
//  Created by Dean on 14-4-18.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBaseView.h"
#import "CheckItemView.h"

@protocol WPSignupViewDelegate;

@interface WPSignupView : WPBaseView<CheckItemViewDelegate>

@property(nonatomic,assign) id<WPSignupViewDelegate> delegate;
@property(nonatomic,weak) IBOutlet UITextField* phoneTextField;
@property(nonatomic,weak) IBOutlet UIView* checkViewContainer;
@property(nonatomic,weak) IBOutlet UIButton* okButton;
@property(nonatomic,assign) BOOL isFindPassword;
@property(nonatomic,weak) IBOutlet UIView* signupAlertContainer;
@property(nonatomic,weak) IBOutlet UILabel* titleLabel;
@end

@protocol WPSignupViewDelegate <NSObject>

- (void) signupBackAction;

- (void) signupWithNumber:(NSString*)number;

@end