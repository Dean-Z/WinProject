//
//  WPDatePickView.m
//  WinProject
//
//  Created by Dean-Z on 14-6-17.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPDatePickView.h"

@implementation WPDatePickView

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
    
    self.backgroundView = [[UIView alloc]initWithFrame:self.app.window.bounds];
    self.backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
}

- (IBAction)selectAtIndex:(id)sender
{
    NSDate* date = self.pickView.date;
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY"];
    NSString* year = [formatter stringFromDate:date];
    [formatter setDateFormat:@"MM"];
    NSString* mouth = [formatter stringFromDate:date];
    [formatter setDateFormat:@"dd"];
    NSString* day = [formatter stringFromDate:date];
    
    [self.delegate datePickerDidSelectAt:year mouth:mouth day:day];
    
    [self dismiss];
}

- (IBAction)cancel:(id)sender
{
    [self dismiss];
}

- (void)showInWindow
{
    self.originY = self.app.window.sizeH;
    [self.app.window addSubview:self.backgroundView];
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
        [self.backgroundView removeFromSuperview];
        self.backgroundView = nil;
        [self removeFromSuperview];
    }];
}


@end
