/*
 * Copyright (C) 2015 Concur Technologies
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "CXTabIndicatorView.h"
#import "UIColor+CXTabViewDefaults.h"
@interface CXTabIndicatorView ()

@property (nonatomic) CAShapeLayer *blip;
@property (nonatomic) CAShapeLayer *background;

@end

@implementation CXTabIndicatorView

#pragma mark - Lifecycle

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];

    if (self) {
        [self setup];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        [self setup];
    }
    
    return self;
}

- (void)setup {

}

#pragma mark - Element creation

-(CAShapeLayer *)createIndicator {
    CAShapeLayer *indicator = [CAShapeLayer layer];
    
    indicator.fillColor = [UIColor whiteColor].CGColor;
    indicator.strokeColor = [UIColor clearColor].CGColor;
    indicator.lineWidth = 0;
    
    CGRect rect = self.bounds;
    
    CGPoint bottomLeft = CGPointMake(rect.size.width/2-7, CGRectGetMaxY(rect));
    CGPoint midTop = CGPointMake(rect.size.width/2, CGRectGetMaxY(rect) - 8);
    CGPoint bottomRight = CGPointMake(rect.size.width/2+7, CGRectGetMaxY(rect));
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:bottomLeft];
    [path addLineToPoint:midTop];
    [path addLineToPoint:bottomRight];
    [path closePath];
    
    indicator.path = path.CGPath;
    
    return indicator;
}

-(CAShapeLayer *)createIndicatorBackground {
    CAShapeLayer *indicator = [CAShapeLayer layer];
    
    indicator.fillColor = (self.activeTabTintColor.CGColor) ?: [[UIColor whiteColor] colorWithAlphaComponent:0.1].CGColor;
    indicator.strokeColor = [UIColor clearColor].CGColor;
    indicator.lineWidth = 0;
    
    CGRect rect = self.bounds;
    
    CGPoint topLeft = rect.origin;
    CGPoint bottomLeft = CGPointMake(rect.origin.x,rect.size.height);
    CGPoint topRight = CGPointMake(rect.size.width,rect.origin.y);
    CGPoint bottomRight = CGPointMake(rect.size.width,rect.size.height);
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:topLeft];
    [path addLineToPoint:topRight];
    [path addLineToPoint:bottomRight];
    [path addLineToPoint:bottomLeft];
    [path closePath];
    
    indicator.path = path.CGPath;
    
    return indicator;
}

- (void)layoutSubviews {
    
    if (self.background && self.blip) return;
    
    self.background = [self createIndicatorBackground];
    self.blip = [self createIndicator];
    [self.layer addSublayer:self.background];
    [self.layer addSublayer:self.blip];
}

- (void)setActiveTabTintColor:(UIColor *)activeTabTintColor {
    _activeTabTintColor = activeTabTintColor;
    
    [self.background removeFromSuperlayer];
    [self.blip removeFromSuperlayer];
    
    self.background = nil;
    self.blip = nil;
}

@end
