//
//  WPOptionView.m
//  WinProject
//
//  Created by Dean-Z on 14-6-14.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPOptionView.h"
#import "WPOptionInfo.h"

@implementation WPOptionView

@synthesize options = _options;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)renderView
{
    [super renderView];
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.95];
    self.tagImageViews = [@[] mutableCopy];
}

- (void)setOptions:(NSMutableArray *)options
{
    if (_options)
    {
        _options = nil;
        
        for (UIView* view in self.subviews)
        {
            [view removeFromSuperview];
        }
    }
    _options = options;
    [self.tagImageViews removeAllObjects];
    
    NSInteger i=0;
    for (WPOptionInfo* info in _options)
    {
        
        UILabel* optionTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 15+35*i, 300, 30)];
        optionTitleLabel.text = info.title;
        optionTitleLabel.backgroundColor = [UIColor clearColor];
        optionTitleLabel.textColor = [UIColor whiteColor];
        [self addSubview:optionTitleLabel];
        
        if (i<_options.count-1)
        {
            UIView* line = [[UIView alloc]initWithFrame:CGRectMake(15, 15+35*i+30, 310, 1)];
            line.backgroundColor = [UIColor whiteColor];
            [self addSubview:line];
        }
        
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(optionSelected:) forControlEvents:UIControlEventTouchUpInside];
        [button setFrame:optionTitleLabel.frame];
        button.tag = 100 + i;
        [self addSubview:button];
        
        UIImageView* tagImageView = [[UIImageView alloc]initWithFrame:CGRectMake(290, 25+35*i, 14, 14)];
        if (i!=0)
        {
            tagImageView.image = [UIImage imageNamed:@"icon-normal.png"];
        }
        else
        {
            tagImageView.image = [UIImage imageNamed:@"icon-selected.png"];
        }
        [self addSubview:tagImageView];
        [self.tagImageViews addObject:tagImageView];
        
        i++;
    }
    
    self.sizeH = 35*i + 25;
}

- (void)optionSelected:(UIButton*)sender
{
    NSInteger tag = sender.tag - 100;
    
    NSInteger i =0;
    for (UIImageView* tagImageView in self.tagImageViews)
    {
        if (i!=tag)
        {
            [tagImageView setImage:[UIImage imageNamed:@"icon-normal.png"]];
        }
        else
        {
            tagImageView.image = [UIImage imageNamed:@"icon-selected.png"];
        }
        i++;
    }
    
    [self.delegate optionViewDidSelected:self.options[tag] optionView:self];
}

@end
