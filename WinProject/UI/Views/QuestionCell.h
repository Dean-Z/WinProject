//
//  QuestionCell.h
//  WinProject
//
//  Created by Dean-Z on 14-6-12.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBaseView.h"
#import "WPQuestionInfo.h"

@protocol QuestionCellDelegate;

@interface QuestionCell : WPBaseView

@property(nonatomic,weak) IBOutlet UILabel *questionTitle;
@property(nonatomic,weak) IBOutlet UILabel *optionLabel;
@property(nonatomic,weak) IBOutlet UIButton *answerButton;

@property(nonatomic,strong) WPQuestionInfo* questionInfo;
@property(nonatomic,assign) id<QuestionCellDelegate> deleagte;

@end

@protocol QuestionCellDelegate <NSObject>

- (void)showOptions;

@end