//
//  WPDateSelecter.h
//  WinProject
//
//  Created by Dean-Z on 14-6-5.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBaseView.h"

@protocol WPDateSelecterDelegate;

@interface WPDateSelecter : WPBaseView<UIPickerViewDataSource,UIPickerViewDelegate>

@property(nonatomic,strong) IBOutlet UIPickerView* pickView;
@property(nonatomic,assign) NSInteger rowCount;

@property(nonatomic,assign) id<WPDateSelecterDelegate> delegate;

- (void)showInWindow;
- (void)dismiss;

@end


@protocol WPDateSelecterDelegate <NSObject>

- (void)dateSelecterAtIndex:(NSInteger)index;

@end