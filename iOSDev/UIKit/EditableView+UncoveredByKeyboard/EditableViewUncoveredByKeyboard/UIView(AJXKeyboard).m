//
//  UIView(AJXKeyboard).m
//  iOSDev
//
//  Created by Handy on 11/21/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import <objc/runtime.h>
#import "UIView(AJXKeyboard).h"

static char AjxInitFrame;

@implementation UIView(AJXKeyboard)

/**
 * UITableView和UIScrollView同时查找，
 * 但先看有没有找到UITableView，因为当输入框在cell里时，输入框的super view会有UITableView和UITableWrapperView，
 * UITableWrapperView是UITableView的sub view，查找时先会找到UITableWrapperView，但我们实际想要的是UITableView，
 * 这种情况下是把UITableWrapper当成UIScrollView给忽略了。这种场景与在UITableView的Cell里套UIScrollView也是一回事儿。
 */
- (UIScrollView *)ajxSuperScrollableView
{
    UIScrollView *scrollableView = nil;
    UIScrollView *scrollView = nil;
    UIView *superView = self.superview;
    while (superView) {
        if ([superView isKindOfClass:[UITableView class]]) {
            scrollableView = (UITableView *)superView;
            break;
        } else if (!scrollView && [superView isKindOfClass:[UIScrollView class]]) {
            scrollView = (UIScrollView *)superView;
            superView = superView.superview;
        } else {
            superView = superView.superview;
        }
    }
    
    if (!scrollableView && scrollView) {
        scrollableView = scrollView;
    }
    return scrollableView;
}

- (UIView *)ajxSuperVCView
{
    UIResponder *nextResponder = self.nextResponder;
    while (nextResponder && ![nextResponder isKindOfClass:[UIViewController class]]) {
        //优化：在找到VC view之前，如果找到一个高度与屏幕高度一样的super view，那么则返回此super view
        if ([nextResponder isKindOfClass:[UIView class]]) {
            UIView *superView = (UIView *)nextResponder;
            if (CGRectGetHeight(superView.frame) == CGRectGetHeight([UIScreen mainScreen].bounds)) {
                return superView;
            }
        }
        nextResponder = nextResponder.nextResponder;
    }
    
    if (nextResponder && [nextResponder isKindOfClass:[UIViewController class]]) {
        UIViewController *vc = (UIViewController *)nextResponder;
        return vc.view;
    } else {
        return self.superview;
    }
}

- (UIWindow *)ajxKeyWindow
{
    UIWindow *keyWindow = nil;
    if (self.window) {
        keyWindow = self.window;
    } else {
        static UIWindow *__keyWindow = nil;
        UIWindow *latestKeyWindow = [[UIApplication sharedApplication] keyWindow];
        if (latestKeyWindow && __keyWindow != latestKeyWindow) {
            keyWindow = latestKeyWindow;
        }
    }
    return keyWindow;
}

#pragma mark - 最初frame的缓存与恢复

- (void)ajxCacheInitFrame
{
    if (![self ajxGetInitFrameObj]) {
        [self setAjxInitFrame:self.frame];
    }
}

- (void)ajxRestoreInitFrame
{
    if ([self ajxGetInitFrameObj]) {
        self.frame = [self ajxGetInitFrame];
    }
    [self resetAjxInitFrame];
}

- (void)setAjxInitFrame:(CGRect)viewInitFrame
{
    objc_setAssociatedObject(self, &AjxInitFrame, NSStringFromCGRect(viewInitFrame), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)resetAjxInitFrame
{
    objc_setAssociatedObject(self, &AjxInitFrame, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGRect)ajxGetInitFrame
{
    return CGRectFromString([self ajxGetInitFrameObj]);
}

- (id)ajxGetInitFrameObj
{
    return objc_getAssociatedObject(self, &AjxInitFrame);
}

@end
