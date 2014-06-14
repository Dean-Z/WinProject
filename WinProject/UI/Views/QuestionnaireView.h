//
//  QuestionnaireView.h
//  WinProject
//
//  Created by Dean-Z on 14-6-2.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBaseView.h"
#import "TTTAttributedLabel.h"
#import "WPQuestionInfo.h"
#import "QuestionCell.h"

@protocol QuestionnaireViewDelegate;
@interface QuestionnaireView : WPBaseView<TTTAttributedLabelDelegate,UIScrollViewDelegate,QuestionCellDelegate>

@property(nonatomic,weak) IBOutlet TTTAttributedLabel* rultLabel;
@property(nonatomic,weak) IBOutlet UIScrollView* questionContainer;
@property(nonatomic,weak) IBOutlet UIButton*    finishButton;
@property(nonatomic,strong) NSMutableArray *questionArray;
@property(nonatomic,strong)  QuestionCell* currentCell;

@property(nonatomic,assign) id<QuestionnaireViewDelegate> delegate;

- (void)showInView:(UIView*)view;
- (void) setCellOptionButtonContent:(NSString*)option;
@end

@protocol QuestionnaireViewDelegate <NSObject>

- (void)questionCompletion;
- (void)optionWithOptionInfo:(WPQuestionInfo*)info;
- (void)showOptionsView;

@end
