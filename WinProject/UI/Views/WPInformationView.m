//
//  WPInformationView.m
//  WinProject
//
//  Created by Dean-Z on 14-6-4.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPInformationView.h"

@implementation WPInformationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)renderView
{
    [super renderView];
    
    self.sexViewContainer.layer.cornerRadius = 3.0f;
    self.sexViewContainer.layer.masksToBounds = YES;
    self.birthViewContainer.layer.cornerRadius = 3.0f;
    self.birthViewContainer.layer.masksToBounds = YES;
    
    self.mouthButton.layer.borderColor = [UIColor colorWithHexString:@"acacac"].CGColor;
    self.mouthButton.layer.borderWidth = 1.0f;
    self.dayButton.layer.borderColor = [UIColor colorWithHexString:@"acacac"].CGColor;
    self.dayButton.layer.borderWidth = 1.0f;
    self.yearButton.layer.borderColor = [UIColor colorWithHexString:@"acacac"].CGColor;
    self.yearButton.layer.borderWidth = 1.0f;
    
    self.girlImageView.layer.borderWidth = 2.f;
    self.girlImageView.layer.borderColor = [UIColor colorWithHexString:@"f28c0c"].CGColor;
    self.boyImageView.layer.borderWidth = 2.f;
    self.boyImageView.layer.borderColor = [UIColor colorWithHexString:@"d9d9d9"].CGColor;
    
    
    self.currentMonthIndex = 1;
    self.sexIndex = 1;
}

- (IBAction)sexAction:(UIButton*)sender
{
    if (sender.tag == 100) {
        self.girlImageView.layer.borderWidth = 2.f;
        self.girlImageView.layer.borderColor = [UIColor colorWithHexString:@"f28c0c"].CGColor;
        self.boyImageView.layer.borderWidth = 2.f;
        self.boyImageView.layer.borderColor = [UIColor colorWithHexString:@"d9d9d9"].CGColor;
        self.sexIndex = 1;
    }
    else
    {
        self.girlImageView.layer.borderWidth = 2.f;
        self.girlImageView.layer.borderColor = [UIColor colorWithHexString:@"d9d9d9"].CGColor;
        self.boyImageView.layer.borderWidth = 2.f;
        self.boyImageView.layer.borderColor = [UIColor colorWithHexString:@"f28c0c"].CGColor;
        self.sexIndex = 0;
    }
}

- (IBAction)selectYear:(id)sender
{
    WPDatePickView* pickerView = [WPDatePickView viewFromXib];
    pickerView.delegate = self;
    [pickerView renderView];
    [pickerView showInWindow];
}


- (void)datePickerDidSelectAt:(NSString *)year mouth:(NSString *)mouth day:(NSString *)day
{
    [self.yearButton setTitle:year forState:UIControlStateNormal];
    [self.mouthButton setTitle:mouth forState:UIControlStateNormal];
    [self.dayButton setTitle:day forState:UIControlStateNormal];
}

- (IBAction)send:(id)sender
{
    NSInteger year = [self.yearButton.titleLabel.text integerValue];
    NSInteger mon = [self.mouthButton.titleLabel.text integerValue];
    NSInteger day = [self.dayButton.titleLabel.text integerValue];
    NSString* date = [NSString stringWithFormat:@"%d-%d-%d",year,mon,day];
    
    NSDictionary* parm = @{@"app":@"user",@"act":@"complete",@"age":date,@"sex":[NSString stringWithFormat:@"%d",self.sexIndex]};
    
    [[WPSyncService alloc]syncWithRoute:parm Block:^(id resp) {
        if (resp)
        {
            [[WPAlertView viewFromXib]showWithMessage:@"任务完成"];
        }
        [self.delegate completeInformation];
    }];
}


@end
