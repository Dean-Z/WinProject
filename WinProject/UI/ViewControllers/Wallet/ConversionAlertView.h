//
//  ConversionAlertView.h
//  WinProject
//
//  Created by Dean-Z on 14-6-9.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBaseView.h"
#import "WPConversionInfo.h"
#import "WPDateSelecter.h"

@protocol ConversionAlertViewDelegate;

@interface ConversionAlertView : WPBaseView<WPDateSelecterDelegate,UITextFieldDelegate>

@property(nonatomic,weak) IBOutlet UILabel* productName;
@property(nonatomic,weak) IBOutlet UILabel* needCoins;
@property(nonatomic,weak) IBOutlet UILabel* hasCoins;
@property(nonatomic,weak) IBOutlet UIButton* productCount;
@property(nonatomic,weak) IBOutlet UIButton* addressButton;
@property(nonatomic,weak) IBOutlet UIScrollView* mainScrollView;
@property(nonatomic,weak) IBOutlet UIButton* cancelButton;
@property(nonatomic,weak) IBOutlet UIView* addressContainer;
@property(nonatomic,weak) IBOutlet UITextField* addressField;
@property(nonatomic,strong) UIView* backgroundView;
@property(nonatomic,strong) WPConversionInfo* conversionInfo;
@property(nonatomic,assign) id<ConversionAlertViewDelegate> delegate;
@property(nonatomic,assign) NSInteger amount;

- (void)showInWindows;

@end


@protocol ConversionAlertViewDelegate <NSObject>

@end