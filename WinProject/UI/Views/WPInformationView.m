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
    
    self.currentMonthIndex = 1;
}

- (IBAction)sexAction:(UIButton*)sender
{
    if (sender.tag == 100) {
        self.girlImageView.layer.borderWidth = 2.f;
        self.girlImageView.layer.borderColor = [UIColor colorWithHexString:@"f28c0c"].CGColor;
        self.boyImageView.layer.borderWidth = 2.f;
        self.boyImageView.layer.borderColor = [UIColor colorWithHexString:@"d9d9d9"].CGColor;
    }
    else
    {
        self.girlImageView.layer.borderWidth = 2.f;
        self.girlImageView.layer.borderColor = [UIColor colorWithHexString:@"d9d9d9"].CGColor;
        self.boyImageView.layer.borderWidth = 2.f;
        self.boyImageView.layer.borderColor = [UIColor colorWithHexString:@"f28c0c"].CGColor;
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

@end
