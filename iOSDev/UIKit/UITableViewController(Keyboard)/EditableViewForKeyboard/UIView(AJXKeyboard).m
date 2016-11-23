//
//  UIView(AJXKeyboard).m
//  iOSDev
//
//  Created by Handy on 11/21/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "UIView(AJXKeyboard).h"

@implementation UIView(AJXKeyboard)

- (UIScrollView *)ajxSuperScrollView
{
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        return (UIScrollView *)(self.superview);
    } else {
        return [self.superview ajxSuperScrollView];
    }
}

- (UITableView *)ajxSuperTableView
{
    if ([self.superview isKindOfClass:[UITableView class]]) {
        return (UITableView *)(self.superview);
    } else {
        return [self.superview ajxSuperTableView];
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
