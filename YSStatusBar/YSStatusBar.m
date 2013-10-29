//
//  YSStatusBar.m
//  YSStatusBar
//
//  Created by Yoshimitsu Sakui on 2013/10/29.
//  Copyright (c) 2013年 Yoshimitsu Sakui. All rights reserved.
//

#import "YSStatusBar.h"
#import <QuartzCore/QuartzCore.h>

#define ScreenWidth   [UIScreen mainScreen].bounds.size.width
#define ScreenHeight  [UIScreen mainScreen].bounds.size.height

#define StatusBarFontSize  12.0f
#define StatusBarHeight    20.0f
#define StatusBarBackgroundColor [UIColor whiteColor]
#define StatusBarTextColor [UIColor blackColor]


@interface YSStatusBar ()

@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIImageView *captureImageView;
@property (nonatomic, strong) UILabel *statusLabel;

+ (YSStatusBar *)sharedInstance;

@end

@implementation YSStatusBar

static YSStatusBar *sharedInstance = nil;
CGImageRef UIGetScreenImage(void);


#pragma mark - Class methods

+ (void)showWithStatus:(NSString *)status {
    YSStatusBar *instance = [self sharedInstance];
    [instance showWithStatus:status];
}

+ (void)hide {
    YSStatusBar *instance = [self sharedInstance];
    [instance hide];
}

+ (void)setStatus:(NSString *)status {
    YSStatusBar *instance = [self sharedInstance];
    instance.statusLabel.text = status;
}

+ (BOOL)isVisible {
    YSStatusBar *instance = [self sharedInstance];
    return !instance.hidden;
}

+ (YSStatusBar *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


#pragma mark -

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.windowLevel = UIWindowLevelStatusBar + 1;
        self.frame = [[UIApplication sharedApplication] statusBarFrame];
        self.hidden = YES;
        
        // Add Subviews
        [self addSubview:self.backgroundView];
        [self.backgroundView addSubview:self.captureImageView];
        [self.backgroundView addSubview:self.statusLabel];
        
        
        // Observing Notifications
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didChangeStatusBarFrame:)
                                                     name:UIApplicationDidChangeStatusBarFrameNotification
                                                   object:nil];
        
        [self rotateStatusBarFrameWithAnimate:NO];
    }
    return self;
}


#pragma mark - Notifications

- (void)didChangeStatusBarFrame:(NSNotification *)notification {
    [self rotateStatusBarFrameWithAnimate:YES];
}


#pragma mark - Private methods

- (void)rotateStatusBarFrameWithAnimate:(BOOL)animate {
    
    float duration = (animate) ? 0.3f : 0.0f;
    
    [UIView animateWithDuration:duration animations:^{
        
        UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
        CGFloat pi = (CGFloat)M_PI;
        
        if (orientation == UIDeviceOrientationPortrait) {
            self.transform = CGAffineTransformIdentity;
            self.frame = CGRectMake(0, 0, ScreenWidth, StatusBarHeight);
        } else if (orientation == UIDeviceOrientationLandscapeLeft) {
            self.transform = CGAffineTransformMakeRotation(pi * (90.0f) / 180.0f);
            self.frame = CGRectMake(ScreenWidth - StatusBarHeight, 0, StatusBarHeight, ScreenHeight);
        } else if (orientation == UIDeviceOrientationLandscapeRight) {
            self.transform = CGAffineTransformMakeRotation(pi * (-90.0f) / 180.0f);
            self.frame = CGRectMake(0, 0, StatusBarHeight, ScreenHeight);
        } else if (orientation == UIDeviceOrientationPortraitUpsideDown) {
            self.transform = CGAffineTransformMakeRotation(pi);
            self.frame = CGRectMake(0, ScreenHeight - StatusBarHeight, ScreenWidth, StatusBarHeight);
        }
        
        if (!UIInterfaceOrientationIsLandscape(orientation)) {
            self.backgroundView.frame = CGRectMake(0, 0, ScreenWidth, StatusBarHeight);
        } else {
            self.backgroundView.frame = CGRectMake(0, 0, ScreenHeight, StatusBarHeight);
        }
    }];
}

- (void)showWithStatus:(NSString *)status {
    self.statusLabel.text = status;
    [self show];
}

- (void)takeCaptureOfStatusBar {
    CGImageRef screen = UIGetScreenImage();
    UIImage *image = [UIImage imageWithCGImage:screen];
    CGImageRelease(screen);
    
    
    CGRect trimArea = CGRectMake(0, 0, 640, 40);
    CGImageRef trimmedImageRef = CGImageCreateWithImageInRect(image.CGImage, trimArea);
    UIImage *trimImage = [UIImage imageWithCGImage:trimmedImageRef];
    
    self.captureImageView.image = trimImage;
}

- (void)show {
    if (!self.hidden)
        return;
    
    self.hidden = NO;
    [self takeCaptureOfStatusBar];
    
    CGRect captureFrame = self.captureImageView.frame;
    captureFrame.origin.y = self.bounds.origin.y;
    self.captureImageView.frame = captureFrame;
    
    CGRect statusFrame = self.statusLabel.frame;
    statusFrame.origin.y = self.bounds.origin.y + self.frame.size.height;
    self.statusLabel.frame = statusFrame;
    
    
    captureFrame.origin.y -= StatusBarHeight;
    statusFrame.origin.y -= StatusBarHeight;
    
    [UIView animateWithDuration:0.4f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.captureImageView.frame = captureFrame;
        self.statusLabel.frame = statusFrame;
        
    } completion:^(BOOL finished) {
    }];
}

- (void)hide {
    if (self.hidden)
        return;
    
    CGRect captureFrame = self.captureImageView.frame;
    captureFrame.origin.y = self.bounds.origin.y - self.frame.size.height;
    self.captureImageView.frame = captureFrame;
    
    CGRect statusFrame = self.statusLabel.frame;
    statusFrame.origin.y = self.bounds.origin.y;
    self.statusLabel.frame = statusFrame;
    
    
    captureFrame.origin.y += StatusBarHeight;
    statusFrame.origin.y += StatusBarHeight;
    
    [UIView animateWithDuration:0.4f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.captureImageView.frame = captureFrame;
        self.statusLabel.frame = statusFrame;
        
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}


#pragma mark - Accessor

- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        _backgroundView.backgroundColor = StatusBarBackgroundColor;
        _backgroundView.clipsToBounds = YES;
        _backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _backgroundView;
}

- (UIImageView *)captureImageView {
    if (!_captureImageView) {
        _captureImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _captureImageView.backgroundColor = [UIColor clearColor];
        _captureImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _captureImageView;
}

- (UILabel *)statusLabel {
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _statusLabel.font = [UIFont boldSystemFontOfSize:StatusBarFontSize];
        _statusLabel.textColor = StatusBarTextColor;
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        _statusLabel.backgroundColor = [UIColor clearColor];
        _statusLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return _statusLabel;
}

@end
