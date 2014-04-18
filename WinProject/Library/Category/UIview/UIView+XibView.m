//
//  UIView+XibView.m
//  shopCart
//
//  Created by Dean on 13-10-13.
//  Copyright (c) 2013年 Dean. All rights reserved.
//

#import "UIView+XibView.h"

@implementation UIView (XibView)

+(id)viewFromXib
{
    Class viewClass = [self class];
    
    NSString *viewClassName = [NSString stringWithFormat:@"%@", viewClass];
    
    if (IS_IPHONE())
    {
        NSString *originViewClassName = viewClassName;
        
        viewClassName = [viewClassName stringByAppendingString:@"_iPhone"];
        
        NSString *nibPath = [[NSBundle mainBundle] pathForResource:viewClassName ofType:@"nib"];
        
        if (!nibPath)
        {
            viewClassName = originViewClassName;
        }
    }
    
    UINib *nib = [UINib nibWithNibName:viewClassName bundle:nil];
    return [nib instantiateWithOwner:self options:nil][0];
}

@end
