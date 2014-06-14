//
//  WPQuestionViewController.m
//  WinProject
//
//  Created by Dean-Z on 14-6-13.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPQuestionViewController.h"
#import "QuestionnaireView.h"
#import "WPQuestionInfo.h"

@interface WPQuestionViewController ()<QuestionnaireViewDelegate>

@property(nonatomic,strong) QuestionnaireView* questionContainer;
@property(nonatomic,strong) NSMutableArray* questionArray;

@end

@implementation WPQuestionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self prepareData];
    [self showQusetionContainer];
    [self prepareOptionData];
    
}

- (void)prepareData
{
    NSArray* data = [self.requestResult objectForKey:@"problem"];
    self.questionArray = [@[] mutableCopy];
    for (NSDictionary* dict in data)
    {
        WPQuestionInfo* question = [[WPQuestionInfo alloc]init];
        question.data = dict;
        [self.questionArray addObject:question];
        question = nil;
    }
}

- (void)prepareOptionData
{
    if (self.optionView == nil)
    {
        self.optionView = [WPOptionView viewFromXib];
        [self.optionView renderView];
        self.optionView.delegate = self;
        WPQuestionInfo* info = [self.questionArray firstObject];
        self.optionView.options = info.options;
        self.optionView.originY = -self.optionView.sizeH;
        [self.view addSubview:self.optionView];
    }
}

- (void)showQusetionContainer
{
    if (_questionContainer == nil)
    {
        _questionContainer = [QuestionnaireView viewFromXib];
        _questionContainer.questionArray = self.questionArray;
        _questionContainer.delegate = self;
        [_questionContainer renderView];
        [_questionContainer showInView:self.view];
    }
}

- (void)questionCompletion
{
    [self popNavigation:nil];
}

#pragma mark  QuestionnaireViewDelegate

- (void)optionWithOptionInfo:(WPQuestionInfo *)info
{
    self.optionView.options = info.options;
    self.optionView.originY = -self.optionView.sizeH;
}

- (void)showOptionsView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.optionView.originY = 0;
    }];
}

- (void)optionViewDidSelected:(WPOptionInfo *)info optionView:(WPOptionView *)optionView
{
    [UIView animateWithDuration:0.3 animations:^{
        self.optionView.originY = -self.optionView.sizeH;
    }];
    
    _questionContainer.currentCell.optionLabel.text = info.title;
}


- (IBAction)popNavigation:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    [_questionContainer removeFromSuperview];
    _questionContainer = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

@end
