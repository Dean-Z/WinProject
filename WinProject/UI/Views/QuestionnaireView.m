//
//  QuestionnaireView.m
//  WinProject
//
//  Created by Dean-Z on 14-6-2.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "QuestionnaireView.h"

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
}


- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url
{
    if ([label.text isEqualToString:self.rultLabel.text])
    {
        
    }
}


@end
