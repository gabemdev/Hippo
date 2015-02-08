//
//  Circle.m
//  Goal
//
//  Created by Rockstar. on 1/15/15.
//  Copyright (c) 2015 Gabe Morales. All rights reserved.
//

#import "Circle.h"
#import "AppDelegate.h"

@interface Circle()
- (void)resizeLayer:(CALayer *)layer to:(CGSize)size;
@end

@implementation Circle
{
    float diameter;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        diameter = frame.size.width - 2;
        
        self.ring = [CALayer layer];
        self.ring.frame = CGRectMake(1.0, 1.0, diameter, frame.size.height - 2);
        self.ring.borderColor = [[UIColor GMDColorWithHex:[[NSUserDefaults standardUserDefaults] stringForKey:textColorPrefsKey]] CGColor];
        self.ring.borderWidth = 2.0f;
        self.ring.cornerRadius = diameter / 2;
        self.ring.masksToBounds = YES;
        
        self.fill = [CALayer layer];
        self.fill.anchorPoint = CGPointMake(0, 1);
        self.fill.frame = CGRectMake(0, _ring.bounds.size.height - _ring.borderWidth, diameter, 0.0);
        self.fill.backgroundColor = [[UIColor GMDColorWithHex:[[NSUserDefaults standardUserDefaults] stringForKey:textColorPrefsKey]] CGColor];
        
        [_ring addSublayer:_fill];
        [self.layer addSublayer: _ring];
    }
    return self;
}

- (void)updateFillFrom:(float)fromValue to:(float)toValue {
    self.fill.frame = CGRectMake(1.0, _ring.bounds.size.height - _ring.borderWidth, diameter, - toValue * (diameter - 4.0f));
    [self resizeLayer:self.fill to: CGSizeMake(diameter, - fromValue * (diameter - 4.0f))];
}

- (void)resizeLayer:(CALayer *)layer to:(CGSize)size {
    
    // Prepare the animation from the old size to the new size
    CGRect oldBounds = layer.bounds;
    oldBounds.size = size;
    CGRect newBounds = layer.bounds;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"bounds"];
    animation.duration = animationDuration;
    animation.fromValue = [NSValue valueWithCGRect:oldBounds];
    animation.toValue = [NSValue valueWithCGRect:newBounds];
    animation.timingFunction = [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseOut];
    
    // Update the layer's bounds so the layer doesn't snap back when the animation completes.
    layer.bounds = newBounds;
    
    // Add the animation, overriding the implicit animation.
    [layer addAnimation:animation forKey:@"bounds"];
}

- (void)changeColor:(UIColor *)newColor {
    self.ring.borderColor = [newColor CGColor];
    self.fill.backgroundColor = [newColor CGColor];
}

@end
