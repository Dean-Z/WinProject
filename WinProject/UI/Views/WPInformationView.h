//
//  WPInformationView.h
//  WinProject
//
//  Created by Dean-Z on 14-6-4.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBaseView.h"
#import "WPDateSelecter.h"

@interface WPInformationView : WPBaseView<WPDateSelecterDelegate>

@property (nonatomic,weak) IBOutlet UITextField* ageField;
@property (nonatomic,weak) IBOutlet UIButton* mouthButton;
@property (nonatomic,weak) IBOutlet UIButton* dayButton;
@property (nonatomic,weak) IBOutlet UIImageView* girlImageView;
@property (nonatomic,weak) IBOutlet UIImageView* boyImageView;
@property (nonatomic,weak) IBOutlet UIImageView* ageBgImageView;

@property (nonatomic,weak) IBOutlet UIView* ageViewContainer;
@property (nonatomic,weak) IBOutlet UIView* sexViewContainer;
@property (nonatomic,weak) IBOutlet UIView* birthViewContainer;

@property (nonatomic,assign) NSInteger currentMonthIndex;
@property (nonatomic,assign) BOOL isMonth;

@property (nonatomic,assign) NSInteger sexIndex;

@end
