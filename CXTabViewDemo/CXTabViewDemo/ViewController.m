//
//  ViewController.m
//  CXTabViewDemo
//
//  Created by Richard Puckett on 5/12/15.
//  Copyright (c) 2015 Concur Labs. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabView.delegate = self;
    
    self.tabView.durationLabelStartString = @"Check In";
    self.tabView.durationLabelEndString = @"Check Out";
    
    self.tabView.durationValueStartString = @"Thu, Dec 5";
    self.tabView.durationValueEndString = @"Fri, Dec 7";
}

- (void)tabView:(CXTabView *)tabView didSelectMode:(CXTabViewMode)mode {
    switch (mode) {
        case CXTabViewModeStart:
            NSLog(@"Selected start mode");
            break;
        case CXTabViewModeEnd:
            NSLog(@"Selected end mode");
            break;
    }
}

- (IBAction)didSetStartMode:(id)sender {
    self.tabView.mode = CXTabViewModeStart;
}

- (IBAction)didSetEndMode:(id)sender {
    self.tabView.mode = CXTabViewModeEnd;
}

@end
