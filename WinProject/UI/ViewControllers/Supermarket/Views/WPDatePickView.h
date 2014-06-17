//
//  WPDatePickView.h
//  WinProject
//
//  Created by Dean-Z on 14-6-17.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBaseView.h"

@protocol WPDatePickViewDelegate;

@interface WPDatePickView : WPBaseView

@property(nonatomic,strong) IBOutlet UIDatePicker* pickView;
@property(nonatomic,strong) UIView* backgroundView;
@property(nonatomic,assign) NSInteger rowCount;

@property(nonatomic,assign) id<WPDatePickViewDelegate> delegate;

- (void)showInWindow;
- (void)dismiss;

@end

@protocol WPDatePickViewDelegate <NSObject>

- (void)datePickerDidSelectAt:(NSString*)year mouth:(NSString*)mouth day:(NSString*)day;

@end