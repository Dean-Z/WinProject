//
//  QuestionnaireView.h
//  WinProject
//
//  Created by Dean-Z on 14-6-2.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPBaseView.h"
#import "TTTAttributedLabel.h"

@interface QuestionnaireView : WPBaseView<TTTAttributedLabelDelegate>

@property(nonatomic,weak) IBOutlet TTTAttributedLabel* rultLabel;
@property(nonatomic,weak) IBOutlet UIScrollView* questionContainer;

- (void)showInView:(UIView*)view;

@end
