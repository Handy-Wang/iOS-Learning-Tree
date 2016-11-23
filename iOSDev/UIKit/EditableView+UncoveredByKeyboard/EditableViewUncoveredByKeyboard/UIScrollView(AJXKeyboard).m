//
//  UIScrollView(AJXKeyboard).m
//  iOSDev
//
//  Created by Handy on 11/23/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import <objc/runtime.h>
#import "UIScrollView(AJXKeyboard).h"

static char AjxKeyboardOldContentInset;

@implementation UIScrollView(AJXKeyboard)

- (void)cacheContentInset
{
    if (![self ajxKeyboardOldContentInsetObj]) {
        [self setAjxKeyboardOldContentInset:self.contentInset];
    }
}

- (void)restoreContentInset
{
    if ([self ajxKeyboardOldContentInsetObj]) {
        self.contentInset = [self ajxKeyboardOldContentInset];
    }
    [self resetAjxKeyboardOldContentInset];
}

#pragma mark - ContentInset

- (void)setAjxKeyboardOldContentInset:(UIEdgeInsets)contentInset
{
    objc_setAssociatedObject(self, &AjxKeyboardOldContentInset, NSStringFromUIEdgeInsets(contentInset), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)resetAjxKeyboardOldContentInset
{
    objc_setAssociatedObject(self, &AjxKeyboardOldContentInset, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)ajxKeyboardOldContentInset
{
    return UIEdgeInsetsFromString([self ajxKeyboardOldContentInsetObj]);
}

- (id)ajxKeyboardOldContentInsetObj
{
    return objc_getAssociatedObject(self, &AjxKeyboardOldContentInset);
}


@end
