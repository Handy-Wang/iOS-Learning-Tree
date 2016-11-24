//
//  UIView(AJXKeyboard).h
//  iOSDev
//
//  Created by Handy on 11/21/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView(AJXKeyboard)

#pragma mark - About keywindow

- (UIWindow *)ajxKeyWindow;

#pragma mark - About looking up superview

- (UIScrollView *)ajxSuperScrollableView;

- (UIView *)ajxSuperVCView;

#pragma mark - About frame

- (void)ajxCacheInitFrame;

- (void)ajxRestoreInitFrame;

- (id)ajxGetInitFrameObj;

@end
