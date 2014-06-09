//
//  WPDateSelecter.m
//  WinProject
//
//  Created by Dean-Z on 14-6-5.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPDateSelecter.h"

@implementation WPDateSelecter

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
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.rowCount;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%d",row+1];
}

- (IBAction)selectAtIndex:(id)sender
{
    [self.delegate dateSelecterAtIndex:[self.pickView selectedRowInComponent:0]+1];
    [self dismiss];
}

- (IBAction)cancel:(id)sender
{
    [self dismiss];
}

- (void)showInWindow
{
    self.originY = self.app.window.sizeH;
    [self.app.window addSubview:self];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.originY = self.app.window.sizeH - self.sizeH;
    }];
}

- (void)dismiss
{
    [UIView animateWithDuration:0.3 animations:^{
        self.originY = self.app.window.sizeH;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
