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

#import <UIKit/UIKit.h>

#import "CXTabView.h"

typedef NS_ENUM(NSUInteger, CXTabViewMode) {
    CXTabViewModeEnd,
    CXTabViewModeStart
};

@class CXTabView;

@protocol CXTabViewDelegate <NSObject>

@optional

- (void)tabView:(CXTabView *)tabView didSelectMode:(CXTabViewMode)mode;

@end

@interface CXTabView : UIView <UIGestureRecognizerDelegate>

@property (assign, nonatomic) id<CXTabViewDelegate> delegate;

@property (strong, nonatomic) UIColor *durationEndForegroundColor;
@property (strong, nonatomic) UIColor *durationLabelForegroundColor;
@property (strong, nonatomic) UIColor *durationValueForegroundColor;

@property (strong, nonatomic) NSString *durationLabelEndString;
@property (strong, nonatomic) NSString *durationLabelStartString;

@property (strong, nonatomic) NSString *durationValueEndString;
@property (strong, nonatomic) NSString *durationValueStartString;

@property (strong, nonatomic) NSString *durationEndString __attribute__((deprecated));
@property (strong, nonatomic) NSString *durationStartString __attribute__((deprecated));

@property (nonatomic) CXTabViewMode mode;

@end
