//
//  QuestionCell.m
//  WinProject
//
//  Created by Dean-Z on 14-6-12.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "QuestionCell.h"

@implementation QuestionCell

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
    
    self.questionTitle.text = self.questionInfo.questionTitle;
    
    WPOptionInfo* option = [self.questionInfo.options firstObject];
    self.optionLabel.text = option.title;
}

- (IBAction)showOptionsView:(id)sender
{
    [self.deleagte showOptions];
}

@end
