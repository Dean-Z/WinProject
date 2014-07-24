//
//  QuestionnaireView.m
//  WinProject
//
//  Created by Dean-Z on 14-6-2.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "QuestionnaireView.h"
#import "FTAnimationManager.h"
#import "WPRultView.h"

#define QuestionWidth 268.0f

@implementation QuestionnaireView


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
    
    NSMutableDictionary *linkAttributes = [NSMutableDictionary dictionary];
    [linkAttributes setValue:[NSNumber numberWithBool:YES] forKey:(NSString *)kCTUnderlineStyleAttributeName];
    self.rultLabel.linkAttributes = linkAttributes;
    
    NSMutableDictionary *mutableActiveLinkAttributes = [NSMutableDictionary dictionary];
    [mutableActiveLinkAttributes setValue:[NSNumber numberWithBool:NO] forKey:(NSString *)kCTUnderlineStyleAttributeName];
    self.rultLabel.activeLinkAttributes = mutableActiveLinkAttributes;
    
    self.rultLabel.delegate = self;
    
    [self.rultLabel setText:self.rultLabel.text afterInheritingLabelAttributesAndConfiguringWithBlock:^NSMutableAttributedString *(NSMutableAttributedString *mutableAttributedString) {
        return mutableAttributedString;
    }];
    
    NSRange range = NSMakeRange(0, [self.rultLabel.text length]);
    NSURL *url = [NSURL URLWithString:@"http://LookRult"];
    [self.rultLabel addLinkToURL:url withRange:range];
    
    self.canFinish = YES;
    if (self.questionArray.count > 1)
    {
        self.canFinish = NO;
        [self.finishButton setTitle:@"下一题" forState:UIControlStateNormal];
    }
    
    self.currentPage = 1;
    self.countLabel.text = [NSString stringWithFormat:@"1/%d",self.questionArray.count];
    
    [self prepareData];
}

- (void)prepareData
{
    for (NSInteger i=0; i<self.questionArray.count; i++)
    {
        QuestionCell* cell = [QuestionCell viewFromXib];
        cell.deleagte = self;
        cell.questionCount = i+1;
        cell.questionInfo = self.questionArray[i];
        cell.tag = 100+i;
        cell.originX = QuestionWidth*i;
        [cell renderView];
        [self.questionContainer addSubview:cell];
        if (i==0)
        {
            self.currentCell = cell;
        }
    }
    
    [self.questionContainer setContentSize:CGSizeMake(QuestionWidth*self.questionArray.count, 0)];
}

- (IBAction)completion:(id)sender
{
    if (self.canFinish)
    {
        [self.delegate questionCompletion];
    }
    else
    {
        [self setUserInteractionEnabled:NO];
        [self.questionContainer setContentOffset:CGPointMake(self.questionContainer.contentOffset.x + QuestionWidth , 0) animated:YES];
    }
}

- (void)showInView:(UIView*)view
{
    self.center = view.center;
    if (!IS_IPHONE_5)
    {
        self.centerY -= 30;
    }
    [view addSubview:self];
}

- (void)showOptions
{
    [self.delegate showOptionsView];
}

- (void) prepareOptionsViewWithOptionInfo:(WPQuestionInfo*)question
{
    [self.delegate optionWithOptionInfo:question];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x/QuestionWidth;
    WPQuestionInfo* question = self.questionArray[index];
    [self prepareOptionsViewWithOptionInfo:question];
    
    self.currentCell = (QuestionCell*)[scrollView viewWithTag:100+index];
    if (index+1>self.currentPage)
    {
        self.currentPage = index + 1;
        self.countLabel.text = [NSString stringWithFormat:@"%d/%d",self.currentPage,self.questionArray.count];
    }
    
    if (index == self.questionArray.count -1)
    {
        self.canFinish = YES;
        [self.finishButton setTitle:@"完成" forState:UIControlStateNormal];
    }
    else
    {
        self.canFinish = NO;
        [self.finishButton setTitle:@"下一题" forState:UIControlStateNormal];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x/QuestionWidth;
    WPQuestionInfo* question = self.questionArray[index];
    [self prepareOptionsViewWithOptionInfo:question];
    
    self.currentCell = (QuestionCell*)[scrollView viewWithTag:100+index];

    if (index == self.questionArray.count -1)
    {
        self.canFinish = YES;
        [self.finishButton setTitle:@"完成" forState:UIControlStateNormal];
    }
    else
    {
        self.canFinish = NO;
        [self.finishButton setTitle:@"下一题" forState:UIControlStateNormal];
    }
    [self setUserInteractionEnabled:YES];
}

- (void) setCellOptionButtonContent:(NSString*)option
{
    self.currentCell.optionLabel.text = option;
}

- (void)dismiss
{
//    CAAnimation* popAnim = [[FTAnimationManager sharedManager]popOutAnimationFor:self duration:0.3 delegate:nil startSelector:nil stopSelector:nil];
//    [self.layer addAnimation:popAnim forKey:@"POP"];
//    
//    [self performSelector:@selector(clean) withObject:nil afterDelay:0.4];
}

- (void)clean
{
    for (UIView* view in self.subviews)
    {
        [view removeFromSuperview];
    }
    
    [self removeFromSuperview];
}

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url
{
    if ([label.text isEqualToString:self.rultLabel.text])
    {
        [[WPRultView viewFromXib]showWithMessage:@"gygyguyyugyuguygyugyuguyguyuygyugyugyuguygyugyuguyguygyuguyguyguygyuguyguyguyguyguyguybiuibbjkbkjbkjbjbkjbbkjbkjbkjbkjbkjbkjvyuvyjhfyucucuycuyuyuycuycuycuyucucucuycuy" title:@"条款协议"];
    }
}


@end
