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
    
    self.optionData = [@{} mutableCopy];
    self.optionResultArray = [@[] mutableCopy];
    
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
        
        WPQuestionInfo* info = [self.questionArray firstObject];
        WPOptionInfo *tmp = [info.options firstObject];
        WPOptionInfo *option = [WPOptionInfo new];
        option.survey_problem_id = tmp.survey_problem_id;
        option.title = @"请选择";
        [self.optionResultArray addObject:option];
    }
}

- (void)questionCompletion
{
    NSMutableDictionary *parm = [@{@"app":@"survey",
                                   @"act":@"submit",
                                   @"id":self.questionId} mutableCopy];
    
    NSMutableArray* resutlArray = [@[] mutableCopy];
    
    for (WPOptionInfo* info in self.optionResultArray)
    {
        if ([info.title isEqualToString:@"请选择"])
        {
            [[WPAlertView viewFromXib] showWithMessage:@"请完成所有题目再提交问卷"];
            return;
        }
    }
    
    for (WPOptionInfo* info in self.optionResultArray)
    {
        NSDictionary* dict = @{info.survey_problem_id:@[info.optionId]};
        [resutlArray addObject:dict];
    }
    
    NSString* resultString = [NSObject toJSONString:resutlArray];
    [parm setObject:resultString forKey:@"params"];
    
    __weak WPQuestionViewController* question = self;
    [[WPSyncService alloc]syncWithRoute:parm Block:^(id resp) {
        if (resp)
        {
            WPUserInfo* userInfo = question.app.userInfo;
            id data = [NSObject toJSONValue:resp];
            id result = [data objectForKey:@"result"];
            userInfo.coins = [result objectForKey:@"balance"];
            
            [[WPAlertView viewFromXib] showWithMessage:@"完成答卷"];
            [self popNavigation:nil];
        }
    }];
}

#pragma mark  QuestionnaireViewDelegate

- (void)optionWithOptionInfo:(WPQuestionInfo *)info
{
    self.optionView.options = info.options;
    self.optionView.originY = -self.optionView.sizeH;
    
    BOOL hasExite = NO;
    for (WPOptionInfo* optionInfo in self.optionResultArray)
    {
        if ([optionInfo.survey_problem_id isEqualToString:info.questionId])
        {
            hasExite = YES;
            self.optionView.selectedOptionsinfo = optionInfo;
            break;
        }
    }
    if (!hasExite)
    {
        WPOptionInfo *tmp = [info.options firstObject];
        WPOptionInfo *option = [WPOptionInfo new];
        option.survey_problem_id = tmp.survey_problem_id;
        option.title = @"请选择";
        [self.optionResultArray addObject:option];
    }
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
    
    for (NSInteger i=0;i<self.optionResultArray.count;i++)
    {
        WPOptionInfo* optionInfo = self.optionResultArray[i];
        if ([optionInfo.survey_problem_id isEqualToString:info.survey_problem_id])
        {
            [self.optionResultArray replaceObjectAtIndex:i withObject:info];
        }
    }
}


- (IBAction)popNavigation:(id)sender
{
    [self.delegate finishQuestion:self.questionId];
    [self.navigationController popViewControllerAnimated:YES];
    [_questionContainer removeFromSuperview];
    _questionContainer = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

@end
