//
//  UIView(AJXKeyboard).m
//  iOSDev
//
//  Created by Handy on 11/21/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "UIView(AJXKeyboard).h"

@implementation UIView(AJXKeyboard)

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
        nextResponder = nextResponder.nextResponder;
    }
    
    if (nextResponder && [nextResponder isKindOfClass:[UIViewController class]]) {
        UIViewController *vc = (UIViewController *)nextResponder;
        return vc.view;
    } else {
        return self.superview;
    }
}

- (UIViewController *)ajxTopestViewController
{
    NSMutableArray *controllersHierarchy = [[NSMutableArray alloc] init];
    
    UIViewController *topController = self.window.rootViewController;
    
    if (topController)
    {
        [controllersHierarchy addObject:topController];
    }
    
    while ([topController presentedViewController]) {
        
        topController = [topController presentedViewController];
        [controllersHierarchy addObject:topController];
    }
    
    UIResponder *matchController = [self viewController];
    
    while (matchController != nil && [controllersHierarchy containsObject:matchController] == NO)
    {
        do
        {
            matchController = [matchController nextResponder];
            
        } while (matchController != nil && [matchController isKindOfClass:[UIViewController class]] == NO);
    }
    
    return (UIViewController*)matchController;
}

-(UIViewController*)viewController
{
    UIResponder *nextResponder =  self;
    
    do
    {
        nextResponder = [nextResponder nextResponder];
        
        if ([nextResponder isKindOfClass:[UIViewController class]])
            return (UIViewController*)nextResponder;
        
    } while (nextResponder != nil);
    
    return nil;
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

@end
