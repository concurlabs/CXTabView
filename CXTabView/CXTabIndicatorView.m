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
    [self.layer addSublayer:[self createIndicator]];
}

#pragma mark - Element creation

-(CAShapeLayer *)createIndicator {
    CAShapeLayer *indicator = [CAShapeLayer layer];
    
    indicator.fillColor = [UIColor whiteColor].CGColor;
    indicator.strokeColor = [UIColor clearColor].CGColor;
    indicator.lineWidth = 0;
    
    CGRect rect = self.bounds;
    
    CGPoint bottomLeft = CGPointMake(CGRectGetMinX(rect), CGRectGetMaxY(rect));
    CGPoint midTop = CGPointMake(7, CGRectGetMaxY(rect) - 8);
    CGPoint bottomRight = CGPointMake(14, CGRectGetMaxY(rect));
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    [path moveToPoint:bottomLeft];
    [path addLineToPoint:midTop];
    [path addLineToPoint:bottomRight];
    [path closePath];
    
    indicator.path = path.CGPath;
    
    return indicator;
}

@end
