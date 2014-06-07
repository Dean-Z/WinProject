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
    
    self.ageViewContainer.layer.cornerRadius = 3.0f;
    self.ageViewContainer.layer.masksToBounds = YES;
    self.sexViewContainer.layer.cornerRadius = 3.0f;
    self.sexViewContainer.layer.masksToBounds = YES;
    self.birthViewContainer.layer.cornerRadius = 3.0f;
    self.birthViewContainer.layer.masksToBounds = YES;
    
    self.mouthButton.layer.borderColor = [UIColor colorWithHexString:@"acacac"].CGColor;
    self.mouthButton.layer.borderWidth = 1.0f;
    self.dayButton.layer.borderColor = [UIColor colorWithHexString:@"acacac"].CGColor;
    self.dayButton.layer.borderWidth = 1.0f;
    
    self.girlImageView.layer.borderWidth = 2.f;
    self.girlImageView.layer.borderColor = [UIColor colorWithHexString:@"f28c0c"].CGColor;
    self.boyImageView.layer.borderWidth = 2.f;
    self.boyImageView.layer.borderColor = [UIColor colorWithHexString:@"d9d9d9"].CGColor;
    
    UIImage *fieldImage = [UIImage imageNamed:@"icon-info-input-bg.png"];
    fieldImage = [fieldImage resizableImageWithCapInsets:UIEdgeInsetsMake(11, 16, 11, 16)];
    self.ageBgImageView.image = fieldImage;
    self.ageField.inputAccessoryView = [self inputAccessoryBar];
    
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

- (IBAction)selectMouth:(id)sender
{
    self.isMonth = YES;
    WPDateSelecter* selecter = [WPDateSelecter viewFromXib];
    selecter.delegate = self;
    selecter.rowCount = 12;
    [selecter renderView];
    [selecter showInWindow];
}

- (IBAction)selectDay:(id)sender
{
    self.isMonth = NO;
    NSInteger a = self.currentMonthIndex;
    BOOL is31 = a==1||a==3||a==5||a==7||a==8||a==10||a==12;
    WPDateSelecter* selecter = [WPDateSelecter viewFromXib];
    selecter.delegate = self;
    if (is31)
    {
        selecter.rowCount = 31;
    }
    else if(a==2)
    {
        selecter.rowCount = 29;
    }
    else
    {
        selecter.rowCount = 30;
    }
    [selecter renderView];
    [selecter showInWindow];
}


- (void)dateSelecterAtIndex:(NSInteger)index
{
    self.currentMonthIndex = index;
    
    if(self.isMonth)
        [self.mouthButton setTitle:[NSString stringWithFormat:@"%d",index] forState:UIControlStateNormal];
    else
        [self.dayButton setTitle:[NSString stringWithFormat:@"%d",index] forState:UIControlStateNormal];
}

- (IBAction)send:(id)sender
{
    if ([NSString isNilOrEmpty:self.ageField.text])
    {
        [[WPAlertView viewFromXib]showWithMessage:@"年龄不能为空"];
        return;
    }
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy"];
    
    NSInteger year = [[formatter stringFromDate:[NSDate date]] integerValue]-[self.ageField.text integerValue];
    NSInteger mon = [self.mouthButton.titleLabel.text integerValue];
    NSInteger day = [self.dayButton.titleLabel.text integerValue];
    NSString* date = [NSString stringWithFormat:@"%d-%d-%d",year,mon,day];
    
    NSDictionary* parm = @{@"app":@"user",@"act":@"complete",@"age":date,@"sex":[NSString stringWithFormat:@"%d",self.sexIndex]};
    
    [[WPSyncService alloc]syncWithRoute:parm Block:^(id resp) {
        if (resp)
        {
            [[WPAlertView viewFromXib]showWithMessage:@"任务完成"];
        }
    }];
}

- (void)dismissKeyBoard
{
    [self.ageField resignFirstResponder];
}

@end
