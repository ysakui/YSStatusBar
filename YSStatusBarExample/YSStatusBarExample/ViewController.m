//
//  ViewController.m
//  YSStatusBarExample
//
//  Created by levi on 2013/10/29.
//  Copyright (c) 2013年 YoshimitsuSakui. All rights reserved.
//

#import "ViewController.h"
#import "YSStatusBar.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Title";
    
    // Add Button
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(0, 0, 200, 40);
    button.center = self.view.center;
    [button setTitle:@"toggle status bar" forState:UIControlStateNormal];
    button.autoresizingMask =   UIViewAutoresizingFlexibleLeftMargin |
    UIViewAutoresizingFlexibleRightMargin |
    UIViewAutoresizingFlexibleTopMargin |
    UIViewAutoresizingFlexibleBottomMargin;
    [button addTarget:self action:@selector(buttonDidTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
}


#pragma mark - Button Actions

- (void)buttonDidTapped:(id)sender {
    
    if ([YSStatusBar isVisible])
        [YSStatusBar hide];
    else
        [YSStatusBar showWithStatus:@"status bar message ..."];
}

@end
