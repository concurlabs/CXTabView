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
    
    self.tabView.durationStartString = @"Thu, Dec 5";
    self.tabView.durationEndString = @"Fri, Dec 7";
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

@end
