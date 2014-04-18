//
//  UIView+CCAnimation.m
//  AnimationDemo
//
//  Created by Dean on 13-11-21.
//  Copyright (c) 2013年 Dean. All rights reserved.
//

#import "UIView+CCAnimation.h"

@implementation UIView (CCAnimation)

-(void)animationWithPhysicsLevel:(PhysicsLevel)physics ToPoint:(CGPoint)toPoint animationDirection:(FTAnimationDirection)direction
{
    CGPoint fromPoint = self.center;
    UIBezierPath* movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:fromPoint];
    CGPoint point = toPoint;
    
    CGFloat allDisrX = fabsf(self.center.x - point.x);
    CGFloat allDisrY = fabsf(self.center.y - point.y);
    
    switch (direction) {
        case kFTAnimationRight:
        {
            for (NSUInteger i = physics; i>0; i--)
            {
                NSInteger disr = 1<<(5-i);
                CGFloat moveDisrX = allDisrX/disr;
                [movePath addQuadCurveToPoint:toPoint controlPoint:CGPointMake(toPoint.x+moveDisrX, toPoint.y)];
            }
        }
            break;
        case kFTAnimationLeft:
        {
            for (NSUInteger i = physics; i>0; i--)
            {
                NSInteger disr = 1<<(5-i);
                CGFloat moveDisrX = allDisrX/disr;
                [movePath addQuadCurveToPoint:toPoint controlPoint:CGPointMake(toPoint.x-moveDisrX, toPoint.y)];
            }
        }
            break;
        case kFTAnimationTop:
        {
            for (NSUInteger i = 0; i<physics; i++)
            {
                NSInteger disr = 1<<i;
                CGFloat moveDisrY = allDisrY/disr;
                [movePath addQuadCurveToPoint:toPoint controlPoint:CGPointMake(toPoint.x, toPoint.y-moveDisrY)];
            }
        }
            break;
        case kFTAnimationBottom:
        {
            for (NSUInteger i = 0; i<physics; i++)
            {
                NSInteger disr = 1<<i;
                CGFloat moveDisrY = allDisrY/disr;
                [movePath addQuadCurveToPoint:toPoint controlPoint:CGPointMake(toPoint.x, toPoint.y+moveDisrY)];
            }
        }
            break;
        case kFTAnimationTopLeft:
        {
            for (NSUInteger i = 0; i<physics; i++)
            {
                NSInteger disr = 1<<i;
                CGFloat moveDisrX = allDisrX/disr;
                CGFloat moveDisrY = allDisrY/disr;
                [movePath addQuadCurveToPoint:toPoint controlPoint:CGPointMake(toPoint.x-moveDisrX, toPoint.y-moveDisrY)];
            }
        }
            break;
        case kFTAnimationTopRight:
        {
            for (NSUInteger i = 1; i<physics; i++)
            {
                NSInteger disr = 1<<i;
                CGFloat moveDisrX = allDisrX/disr;
                CGFloat moveDisrY = allDisrY/disr;
                [movePath addQuadCurveToPoint:toPoint controlPoint:CGPointMake(toPoint.x+moveDisrX, toPoint.y-moveDisrY)];
            }
        }
            break;
        case kFTAnimationBottomLeft:
        {
            for (NSUInteger i = 1; i<physics; i++)
            {
                NSInteger disr = 1<<i;
                CGFloat moveDisrX = allDisrX/disr;
                CGFloat moveDisrY = allDisrY/disr;
                [movePath addQuadCurveToPoint:toPoint controlPoint:CGPointMake(toPoint.x-moveDisrX, toPoint.y+moveDisrY)];
            }
        }
            break;
        case kFTAnimationBottomRight:
        {
            for (NSUInteger i = 1; i<physics; i++)
            {
                NSInteger disr = 1<<i;
                CGFloat moveDisrX = allDisrX/disr;
                CGFloat moveDisrY = allDisrY/disr;
                [movePath addQuadCurveToPoint:toPoint controlPoint:CGPointMake(toPoint.x+moveDisrX, toPoint.y+moveDisrY)];
            }
        }
            break;
        default:
            break;
    }

    CAKeyframeAnimation *moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveAnim.path = movePath.CGPath;
    moveAnim.removedOnCompletion = NO;

    CAAnimationGroup *animGroup = [CAAnimationGroup animation];
    animGroup.animations = [NSArray arrayWithObjects:moveAnim, nil];
    animGroup.duration = 0.4;
    [self.layer addAnimation:animGroup forKey:nil];
    [self setCenter:toPoint];
}

@end
