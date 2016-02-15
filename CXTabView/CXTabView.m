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
#import "CXTabView.h"
#import "UIColor+CXTabViewDefaults.h"

@interface CXTabView ()
@property (strong, nonatomic) UIView *durationStartContainer;
@property (strong, nonatomic) UIView *durationEndContainer;
@property (strong, nonatomic) UILabel *durationStartLabel;
@property (strong, nonatomic) UILabel *durationStartValue;
@property (strong, nonatomic) UILabel *durationEndLabel;
@property (strong, nonatomic) UILabel *durationEndValue;
@property (strong, nonatomic) CXTabIndicatorView *indicator;
@property (strong, nonatomic) UIView *separator;
@property (nonatomic) NSUInteger indicatorIndex;
@end

@implementation CXTabView

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

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self layoutContainers];
    [self layoutIndicator];
    [self layoutSeparator];
}

#pragma mark - Element setup

- (void)setup {
    self.indicatorIndex = 0;
    
    self.backgroundColor = [UIColor defaultBackgroundColor];
    self.durationLabelForegroundColor = [UIColor defaultDurationLabelForegroundColor];
    self.durationValueForegroundColor = [UIColor defaultDurationValueForegroundColor];
    
    [self setupDurationContainers];
    
    [self setupDurationStartLabel];
    [self setupDurationEndLabel];
    
    [self setupDurationStartValue];
    [self setupDurationEndValue];
    
    [self setupIndicator];
    
    [self setupSeparator];
}

- (void)setupDurationContainers {
    [self setupDurationStartContainer];
    [self setupDurationEndContainer];
}

- (void)setupDurationEndContainer {
    self.durationEndContainer = [UIView new];
    [self addSubview:self.durationEndContainer];
    
    UITapGestureRecognizer *g = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapEnd:)];
    g.numberOfTapsRequired = 1;
    [self.durationEndContainer addGestureRecognizer:g];
    
    [self layoutDurationEndContainer];
}

- (void)setupDurationStartContainer {
    self.durationStartContainer = [UIView new];
    [self addSubview:self.durationStartContainer];
    
    UITapGestureRecognizer *g = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapStart:)];
    g.numberOfTapsRequired = 1;
    [self.durationStartContainer addGestureRecognizer:g];
    
    [self layoutDurationStartContainer];
}

- (void)setupDurationEndLabel {
    self.durationEndLabel = [UILabel new];

    self.durationEndLabel.text = @"Check-out Date";
    self.durationEndLabel.textAlignment = NSTextAlignmentCenter;
    self.durationEndLabel.textColor = self.durationLabelForegroundColor;
    self.durationEndLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];

    [self addSubview:self.durationEndLabel];
    
    [self layoutDurationEndLabel];
}

- (void)setupDurationStartLabel {
    self.durationStartLabel = [UILabel new];
    
    self.durationStartLabel.text = @"Check-in Date";
    self.durationStartLabel.textAlignment = NSTextAlignmentCenter;
    self.durationStartLabel.textColor = self.durationLabelForegroundColor;
    self.durationStartLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    
    [self addSubview:self.durationStartLabel];
    
    [self layoutDurationStartLabel];
}

- (void)setupDurationEndValue {
    self.durationEndValue = [UILabel new];
    self.durationEndValue.accessibilityIdentifier = @"durationEndValueLabel";
    
    self.durationEndValue.text = @"";
    self.durationEndValue.textAlignment = NSTextAlignmentCenter;
    self.durationEndValue.textColor = self.durationValueForegroundColor;
    self.durationEndValue.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    
    [self addSubview:self.durationEndValue];
    
    [self layoutDurationEndValue];
}

- (void)setupDurationStartValue {
    self.durationStartValue = [UILabel new];
    self.durationStartValue.accessibilityIdentifier = @"durationStartValueLabel";
    
    self.durationStartValue.text = @"";
    self.durationStartValue.textAlignment = NSTextAlignmentCenter;
    self.durationStartValue.textColor = self.durationValueForegroundColor;
    self.durationStartValue.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    
    [self addSubview:self.durationStartValue];
    
    [self layoutDurationStartValue];
}

- (void)setupIndicator {
    self.indicator = [CXTabIndicatorView new];
    
    [self addSubview:self.indicator];
    
    [self layoutIndicator];
}

- (void)setupSeparator {
    self.separator = [UIView new];
    
    self.separator.backgroundColor = [UIColor colorWithWhite:1 alpha:0.25];
    
    [self addSubview:self.separator];
    
    [self layoutSeparator];
}

#pragma mark - Element layout

- (void)layoutContainers {
    [self layoutDurationStartContainer];
    [self layoutDurationEndContainer];
}

- (void)layoutDurationEndContainer {
    self.durationEndContainer.frame = [self half:1];

    [self layoutDurationEndLabel];
    [self layoutDurationEndValue];
}

- (void)layoutDurationEndLabel {
    [self.durationEndLabel sizeToFit];
    
    CGRect origFrame = self.durationEndLabel.frame;
    
    CGFloat xOffset = (self.durationEndContainer.bounds.size.width - origFrame.size.width) / 2;
    CGFloat yOffset = 10;
    
    CGRect newFrame = CGRectMake(self.durationEndContainer.frame.origin.x + xOffset, yOffset,
                                 origFrame.size.width, origFrame.size.height);
    
    self.durationEndLabel.frame = newFrame;
}

- (void)layoutDurationEndValue {
    [self.durationEndValue sizeToFit];
    
    CGRect origFrame = self.durationEndValue.frame;
    
    CGFloat xOffset = (self.durationEndContainer.bounds.size.width - origFrame.size.width) / 2;
    CGFloat yOffset = self.durationEndLabel.frame.origin.y + 20;
    
    CGRect newFrame = CGRectMake(self.durationEndContainer.frame.origin.x + xOffset, yOffset,
                                 origFrame.size.width, origFrame.size.height);
    
    self.durationEndValue.frame = newFrame;
}

- (void)layoutDurationStartContainer {
    self.durationStartContainer.frame = [self half:0];
    
    [self layoutDurationStartLabel];
    [self layoutDurationStartValue];
}

- (void)layoutDurationStartLabel {
    [self.durationStartLabel sizeToFit];
    
    CGRect origFrame = self.durationStartLabel.frame;
    
    CGFloat xOffset = (self.durationStartContainer.bounds.size.width - origFrame.size.width) / 2;
    CGFloat yOffset = 10;
    
    CGRect newFrame = CGRectMake(self.durationStartContainer.frame.origin.x + xOffset, yOffset,
                                 origFrame.size.width, origFrame.size.height);
    
    self.durationStartLabel.frame = newFrame;
}

- (void)layoutDurationStartValue {
    [self.durationStartValue sizeToFit];
    
    CGRect origFrame = self.durationStartValue.frame;
    
    CGFloat xOffset = (self.durationStartContainer.bounds.size.width - origFrame.size.width) / 2;
    CGFloat yOffset = self.durationStartLabel.frame.origin.y + 20;
    
    CGRect newFrame = CGRectMake(self.durationStartContainer.frame.origin.x + xOffset, yOffset,
                                 origFrame.size.width, origFrame.size.height);
    
    self.durationStartValue.frame = newFrame;
}

- (void)layoutIndicator {
    CGFloat indicatorWidth = 14;
    CGFloat indicatorHeight = 8;
    
    UIView *containerView;
    
    if (self.indicatorIndex == 0) {
        containerView = self.durationStartContainer;
    } else {
        containerView = self.durationEndContainer;
    }
    
    CGRect rect = containerView.bounds;
    
    CGFloat halfBoundsWidth = rect.size.width / 2;
    CGFloat halfIndicatorWidth = indicatorWidth / 2;
    
    CGFloat xOffset = (rect.size.width * self.indicatorIndex) + halfBoundsWidth - halfIndicatorWidth;
    CGFloat yOffset = containerView.bounds.size.height;
    CGFloat width = indicatorWidth;
    CGFloat height = indicatorHeight;
    
    CGRect indicatorFrame = CGRectMake(xOffset, yOffset, width, height);
    
    self.indicator.frame = indicatorFrame;
}

- (void)layoutSeparator {
    CGFloat separatorWidth = 1;
    
    CGRect rect = self.bounds;
    
    CGFloat halfBoundsWidth = rect.size.width / 2;
    CGFloat halfSeparatorWidth = separatorWidth / 2;
    
    CGFloat xOffset = halfBoundsWidth - halfSeparatorWidth;
    CGFloat yOffset = 10;
    CGFloat width = separatorWidth;
    CGFloat height = rect.size.height - 20;
    
    CGRect separatorFrame = CGRectMake(xOffset, yOffset, width, height);
    
    self.separator.frame = separatorFrame;
}

#pragma mark - Indicator movements

- (void)moveIndicatorToEnd {
    if (self.indicatorIndex == 1) {
        return;
    }
    
    CGPoint newCenter = CGPointMake(self.durationEndContainer.center.x,
                                    self.indicator.center.y);
    
    [UIView animateWithDuration:0.25 animations:^{
        self.indicator.center = newCenter;
    }];
    
    self.indicatorIndex = 1;
}

- (void)moveIndicatorToStart {
    if (self.indicatorIndex == 0) {
        return;
    }
    
    CGPoint newCenter = CGPointMake(self.durationStartContainer.center.x,
                                    self.indicator.center.y);
    
    [UIView animateWithDuration:0.25 animations:^{
        self.indicator.center = newCenter;
    }];
    
    self.indicatorIndex = 0;
}

#pragma mark - Gesture recognizers

- (void)didTapStart:(id)sender {
    [self setStartMode];
}

- (void)didTapEnd:(id)sender {
    [self setEndMode];
}

#pragma mark - Utilities

- (CGRect)half:(NSUInteger)index {
    CGRect rect = self.bounds;
    
    CGFloat halfWidth = rect.size.width / 2;
    
    CGRect half = CGRectMake(halfWidth * index, 0, halfWidth, rect.size.height);
    
    return half;
}

- (void)setEndMode {
    [self moveIndicatorToEnd];
    
    if ([self.delegate respondsToSelector:@selector(tabView:didSelectMode:)]) {
        [self.delegate tabView:self didSelectMode:CXTabViewModeEnd];
    }
}

- (void)setStartMode {
    [self moveIndicatorToStart];
    
    if ([self.delegate respondsToSelector:@selector(tabView:didSelectMode:)]) {
        [self.delegate tabView:self didSelectMode:CXTabViewModeStart];
    }
}

#pragma mark - API

- (void)setDurationLabelEndString:(NSString *)str {
    self.durationEndLabel.text = str;
}

- (void)setDurationLabelStartString:(NSString *)str {
    self.durationStartLabel.text = str;
}

- (void)setDurationValueEndString:(NSString *)str {
    self.durationEndValue.text = str;
    [self layoutDurationEndValue];
}

- (void)setDurationValueStartString:(NSString *)str {
    self.durationStartValue.text = str;
    [self layoutDurationStartValue];
}

- (void)setDurationEndString:(NSString *)str {
    self.durationEndValue.text = str;
    [self layoutDurationEndValue];
}

- (void)setDurationStartString:(NSString *)str {
    self.durationStartValue.text = str;
    [self layoutDurationStartValue];
}

- (void)setMode:(CXTabViewMode)mode {
    switch (mode) {
        case CXTabViewModeStart:
            [self setStartMode];
            break;
        case CXTabViewModeEnd:
            [self setEndMode];
            break;
    }
}

@end
