//
//  UIWindow(AJXKeyboard).m
//  iOSDev
//
//  Created by Handy on 11/21/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "UIWindow(AJXKeyboard).h"

@implementation UIWindow(AJXKeyboard)

- (UIViewController *)ajxTopestViewController
{
    UIViewController *topController = [self rootViewController];
    
    //  Getting topMost ViewController
    while ([topController presentedViewController]) {
        topController = [topController presentedViewController];
    }
    
    //  Returning topMost ViewController
    return topController;
}

@end
