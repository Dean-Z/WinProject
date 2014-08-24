//
//  WPGoodsViewController.m
//  WinProject
//
//  Created by Dean-Z on 14-8-22.
//  Copyright (c) 2014年 Dean. All rights reserved.
//

#import "WPGoodsViewController.h"
#import "WPGoodsInfo.h"
#import "RPJSONMapper.h"
#import "ConversionAlertView.h"

#define Marrgin 13.0f
#define Marrgin_Label 10.0f

@interface WPGoodsViewController ()

@property (nonatomic, strong) NSMutableArray *detailArray;
@property (nonatomic, strong) NSMutableArray *termArray;

@end

@implementation WPGoodsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.scrollview.contentInset = UIEdgeInsetsMake(0, 0, 44, 0);
    [self prepareData];
}

- (void)prepareData
{
    NSDictionary *dict = @{@"app":@"exchange",@"act":@"info",@"id":self.conversionInfo.producId};
    
    [[WPSyncService alloc]syncWithRoute:dict Block:^(id resp)
    {
        if (resp)
        {
            [self prepareDetailView:(NSDictionary*)[NSObject toJSONValue:resp]];
        }
    }];
}

- (void)mockDetail
{
    self.detailArray = [@[@{@"商品名":@"新时期烤肉 代金券"},@{@"品牌":@"新时期烤肉"},
                         @{@"使用范围":@"全场通用"}] mutableCopy];
    
    self.termArray = [@[@{@"有效期":@"2014.7.4至2014.9.3"},@{@"不可用日期":@"2014年7月3号"},
                        @{@"使用时间":@"10:00-22:00，已店内营业时间为准"},@{@"预约提醒":@"无需预约，消费时间高峰时可能需要定位"},@{@"限购使用提醒":@"可叠加使用，不兑换，不找零"}] mutableCopy];
}

- (void) prepareDetailView:(NSDictionary *)dataDict
{
    WPGoodsInfo *goodInfo = [WPGoodsInfo new];
    
    [[RPJSONMapper sharedInstance] mapJSONValuesFrom:dataDict[@"result"] toInstance:goodInfo usingMapping:goodInfo.goodsMapping];
    
    self.titlelabe.text = goodInfo.title;
    
    UIView *basicView = [[UIView alloc]initWithFrame:CGRectMake(10, 74, 306, 100)];
    basicView.backgroundColor = [UIColor whiteColor];
    basicView.layer.cornerRadius = 5.0f;
    basicView.layer.masksToBounds = YES;
    [self.scrollview addSubview:basicView];
    
    CGFloat baseSizeH = 0.0f;
    
    //  -------------------------- spece 01
    UIImageView *goodsImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 290, 135)];
    goodsImage.contentMode = UIViewContentModeScaleAspectFill;
    goodsImage.clipsToBounds = YES;
    [goodsImage setImageWithURL:[NSURL URLWithString:goodInfo.logo]];
    [basicView addSubview:goodsImage];
    
    baseSizeH += goodsImage.sizeH + goodsImage.originY;
    baseSizeH += Marrgin;
    
    UILabel *price = [[UILabel alloc]initWithFrame:CGRectMake(10, baseSizeH, 290.0f, 14)];
    price.textColor = [UIColor colorWithHexString:@"ee9f90"];
    price.backgroundColor = [UIColor clearColor];
    price.font = [UIFont fontWithName:@"Heiti SC" size:14.0f];
    price.text = [NSString stringWithFormat:@"疯狂价: %@",goodInfo.coins];
    price.textAlignment = NSTextAlignmentLeft;
    [basicView addSubview:price];
    
    baseSizeH += price.sizeH + Marrgin;
    
    if (![NSString isNilOrEmpty:goodInfo.description])
    {
        UILabel *descLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, baseSizeH, 290.0f, 14)];
        descLabel.textColor = [UIColor colorWithHexString:@"ee9f90"];
        descLabel.backgroundColor = [UIColor clearColor];
        descLabel.font = [UIFont fontWithName:@"Heiti SC" size:14.0f];
        descLabel.text = goodInfo.description;
        descLabel.textAlignment = NSTextAlignmentLeft;
        descLabel.numberOfLines = 0;
        [basicView addSubview:descLabel];
        
        NSString* followCount = descLabel.text;
        CGSize size = CGSizeMake(descLabel.sizeW,CGFLOAT_MAX);
        NSDictionary *attribute = @{NSFontAttributeName: descLabel.font};
        CGSize retSize = [followCount boundingRectWithSize:size
                                                   options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |     NSStringDrawingUsesFontLeading
                                                attributes:attribute
                                                   context:nil].size;
        if (retSize.height > 14.0f)
        {
            descLabel.sizeH = retSize.height;
        }
        baseSizeH += descLabel.sizeH + Marrgin;
    }
    //  -------------------------- spece 02
    
    UIView *space02 = [[UIView alloc]initWithFrame:CGRectMake(0, baseSizeH, 306, 40)];
    space02.backgroundColor = [UIColor colorWithHexString:@"eaeaea"];
    [basicView addSubview:space02];
    
    UILabel *spaceDescLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 200, 30)];
    spaceDescLabel.textColor = [UIColor blackColor];
    spaceDescLabel.backgroundColor = [UIColor clearColor];
    spaceDescLabel.text = @"商品详情";
    spaceDescLabel.font = [UIFont fontWithName:@"Heiti SC" size:18.0f];
    [space02  addSubview:spaceDescLabel];
    baseSizeH += space02.sizeH + Marrgin;
    
    NSArray *detail = dataDict[@"result"][@"details"];
    
    for (NSDictionary *dest in detail)
    {
        UILabel *descLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, baseSizeH, 290.0f, 15.0f)];
        descLabel.textColor = [UIColor colorWithHexString:@"444444"];
        descLabel.backgroundColor = [UIColor clearColor];
        descLabel.font = [UIFont fontWithName:@"Heiti SC" size:15.0f];
        descLabel.text = [NSString stringWithFormat:@"【%@】 ：%@",dest[@"key"],dest[@"content"]];
        descLabel.textAlignment = NSTextAlignmentLeft;
        descLabel.numberOfLines = 0;
        [basicView addSubview:descLabel];
        
        NSString* followCount = descLabel.text;
        CGSize size = CGSizeMake(descLabel.sizeW,CGFLOAT_MAX);
        NSDictionary *attribute = @{NSFontAttributeName: descLabel.font};
        CGSize retSize = [followCount boundingRectWithSize:size
                                                   options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |     NSStringDrawingUsesFontLeading
                                                attributes:attribute
                                                   context:nil].size;
        if (retSize.height > 14.0f)
        {
            descLabel.sizeH = retSize.height;
        }
        baseSizeH += descLabel.sizeH + Marrgin_Label;
    }
    
    //  -------------------------- spece 03
    UIView *space03 = [[UIView alloc]initWithFrame:CGRectMake(0, baseSizeH, 306, 40)];
    space03.backgroundColor = [UIColor colorWithHexString:@"eaeaea"];
    [basicView addSubview:space03];
    
    UILabel *space03DescLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 200, 30)];
    space03DescLabel.textColor = [UIColor blackColor];
    space03DescLabel.backgroundColor = [UIColor clearColor];
    space03DescLabel.text = @"兑换须知";
    space03DescLabel.font = [UIFont fontWithName:@"Heiti SC" size:17.0f];
    [space03  addSubview:space03DescLabel];
    baseSizeH += space03.sizeH + Marrgin;
    
    NSArray *instruction = dataDict[@"result"][@"instructions"];
    
    for (NSDictionary *dest in instruction)
    {
        UILabel *descLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, baseSizeH, 290.0f, 15.0f)];
        descLabel.textColor = [UIColor colorWithHexString:@"444444"];
        descLabel.backgroundColor = [UIColor clearColor];
        descLabel.font = [UIFont fontWithName:@"Heiti SC" size:15.0f];
        descLabel.text = [NSString stringWithFormat:@"【%@】 ：%@",dest[@"key"],dest[@"content"]];
        descLabel.textAlignment = NSTextAlignmentLeft;
        descLabel.numberOfLines = 0;
        [basicView addSubview:descLabel];
        
        NSString* followCount = descLabel.text;
        CGSize size = CGSizeMake(descLabel.sizeW,CGFLOAT_MAX);
        NSDictionary *attribute = @{NSFontAttributeName: descLabel.font};
        CGSize retSize = [followCount boundingRectWithSize:size
                                                   options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin |     NSStringDrawingUsesFontLeading
                                                attributes:attribute
                                                   context:nil].size;
        if (retSize.height > 14.0f)
        {
            descLabel.sizeH = retSize.height;
        }
        baseSizeH += descLabel.sizeH + Marrgin_Label;
    }
    
    //  -------------------------- spece 04
    
    NSArray *images = dataDict[@"result"][@"img"];
    for (NSString *imageUrl in images)
    {
        UIImageView *goodsImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, baseSizeH, 290, 135)];
        goodsImage.contentMode = UIViewContentModeScaleAspectFill;
        goodsImage.clipsToBounds = YES;
        [goodsImage setImageWithURL:[NSURL URLWithString:imageUrl]];
        [basicView addSubview:goodsImage];
        
        baseSizeH += 135 + Marrgin_Label;
    }
    
    baseSizeH += 5;
    UIButton *buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    buyButton.frame = CGRectMake(36, baseSizeH, 230, 53);
    [buyButton setTitle:@"立即兑换" forState:UIControlStateNormal];
    [buyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [buyButton setTitleShadowColor:[UIColor colorWithHexString:@"26469b"] forState:UIControlStateNormal];
    [buyButton addTarget:self action:@selector(buy:) forControlEvents:UIControlEventTouchUpInside];
    [buyButton setBackgroundImage:[UIImage imageNamed:@"button-blue"] forState:UIControlStateNormal];
    [basicView addSubview:buyButton];
    
    baseSizeH += 53 + Marrgin;
    
    basicView.sizeH = baseSizeH;
    [self.scrollview setContentSize:CGSizeMake(0,baseSizeH + 50)];
}

- (void)buy:(id)sender
{
    ConversionAlertView* alertView = [ConversionAlertView viewFromXib];
    alertView.conversionInfo = self.conversionInfo;
    [alertView renderView];
    [alertView showInWindows];
}

- (IBAction)dismiss:(id)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        self.view.originX = self.view.sizeW;
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
