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
    CGFloat baseOrigY = 25;
    for (WPOptionInfo* info in _options)
    {
        
        UILabel* optionTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, baseOrigY, 250, 30)];
        optionTitleLabel.text = info.title;
        optionTitleLabel.numberOfLines = 0;
        optionTitleLabel.backgroundColor = [UIColor clearColor];
        optionTitleLabel.textColor = [UIColor whiteColor];
        CGSize size = CGSizeMake(optionTitleLabel.sizeW,CGFLOAT_MAX);
        NSDictionary *attribute = @{NSFontAttributeName: optionTitleLabel.font};
        CGSize retSize = [info.title boundingRectWithSize:size
                                                        options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |     NSStringDrawingUsesFontLeading
                                                     attributes:attribute
                                                        context:nil].size;
        optionTitleLabel.sizeH = retSize.height;
        [self addSubview:optionTitleLabel];
        baseOrigY += 5 + retSize.height;
        
        if (i<_options.count-1)
        {
            UIView* line = [[UIView alloc]initWithFrame:CGRectMake(15, baseOrigY, 310, 1)];
            line.backgroundColor = [UIColor whiteColor];
            [self addSubview:line];
            baseOrigY += 5;
        }
        
        UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button addTarget:self action:@selector(optionSelected:) forControlEvents:UIControlEventTouchUpInside];
        [button setFrame:optionTitleLabel.frame];
        button.tag = 100 + i;
        [self addSubview:button];
        
        UIImageView* tagImageView = [[UIImageView alloc]initWithFrame:CGRectMake(290, optionTitleLabel.center.y - 3, 14, 14)];
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
    
    self.sizeH = baseOrigY + 25;
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

- (void) setSelectedOptionsinfo:(WPOptionInfo *)selectedOptionsinfo
{
    if (_selectedOptionsinfo)
    {
        _selectedOptionsinfo = nil;
    }
    
    _selectedOptionsinfo = selectedOptionsinfo;
    
    NSInteger index = 0;
    for (NSInteger i=0; i<self.options.count; i++)
    {
        WPOptionInfo* info = self.options[i];
        
        if ([info.optionId isEqualToString: _selectedOptionsinfo.optionId])
        {
            index = i;
            break;
        }
    }
    
    NSInteger i =0;
    for (UIImageView* tagImageView in self.tagImageViews)
    {
        if (i!=index)
        {
            [tagImageView setImage:[UIImage imageNamed:@"icon-normal.png"]];
        }
        else
        {
            tagImageView.image = [UIImage imageNamed:@"icon-selected.png"];
        }
        i++;
    }
}

@end
