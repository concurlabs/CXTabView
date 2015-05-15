//
//  ViewController.h
//  CXTabViewDemo
//
//  Created by Richard Puckett on 5/12/15.
//  Copyright (c) 2015 Concur Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CXTabView.h"

@interface ViewController : UIViewController <CXTabViewDelegate>

@property (weak, nonatomic) IBOutlet CXTabView *tabView;

@end

