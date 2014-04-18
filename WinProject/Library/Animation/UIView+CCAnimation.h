//
//  UIView+CCAnimation.h
//  AnimationDemo
//
//  Created by Dean on 13-11-21.
//  Copyright (c) 2013年 Dean. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FTAnimationManager.h"

typedef enum
{
    PHYSICAL_LEVEL_1 = 1,
    PHYSICAL_LEVEL_2 = 2,
    PHYSICAL_LEVEL_3 = 3,
    PHYSICAL_LEVEL_4 = 4,
    PHYSICAL_LEVEL_5 = 5,
    PHYSICAL_LEVEL_6 = 6,
    PHYSICAL_LEVEL_7 = 7,
}PhysicsLevel;


@interface UIView (CCAnimation)

-(void)animationWithPhysicsLevel:(PhysicsLevel)physics ToPoint:(CGPoint)toPoint animationDirection:(FTAnimationDirection)direction;

@end
