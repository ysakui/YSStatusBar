//
//  YSStatusBar.h
//  YSStatusBar
//
//  Created by Yoshimitsu Sakui on 2013/10/29.
//  Copyright (c) 2013年 Yoshimitsu Sakui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YSStatusBar : UIWindow

+ (void)showWithStatus:(NSString *)status;
+ (void)setStatus:(NSString *)status;
+ (void)hide;
+ (BOOL)isVisible;

@end