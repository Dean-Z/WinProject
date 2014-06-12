//
//  QuestionnaireView.m
//  WinProject
//
//  Created by Dean-Z on 14-6-2.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "QuestionnaireView.h"
#import "FTAnimationManager.h"
#import "QuestionCell.h"

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
    
    [self prepareData];
}

- (void)prepareData
{
    for (NSInteger i=0; i<3; i++)
    {
        QuestionCell* cell = [QuestionCell viewFromXib];
        cell.originX = QuestionWidth*i;
        [cell renderView];
        [self.questionContainer addSubview:cell];
    }
    
    [self.questionContainer setContentSize:CGSizeMake(QuestionWidth*3, 0)];
}

- (IBAction)completion:(id)sender
{
    [self dismiss];
}

- (void)showInView:(UIView*)view
{
    self.center = view.center;
    self.hidden = YES;
    [view addSubview:self];
    
    CAAnimation* popAnim = [[FTAnimationManager sharedManager]popInAnimationFor:self duration:0.3 delegate:nil startSelector:nil stopSelector:nil];
    [self.layer addAnimation:popAnim forKey:@"POP"];
    
}


- (void)dismiss
{
    CAAnimation* popAnim = [[FTAnimationManager sharedManager]popOutAnimationFor:self duration:0.3 delegate:nil startSelector:nil stopSelector:nil];
    [self.layer addAnimation:popAnim forKey:@"POP"];
    
    [self performSelector:@selector(clean) withObject:nil afterDelay:0.4];
}

- (void)clean
{
    for (UIView* view in self.subviews)
    {
        [view removeFromSuperview];
    }
}

- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url
{
    if ([label.text isEqualToString:self.rultLabel.text])
    {
        
    }
}


@end
