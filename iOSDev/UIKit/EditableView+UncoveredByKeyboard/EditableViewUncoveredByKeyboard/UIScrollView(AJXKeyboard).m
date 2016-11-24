//
//  UIScrollView(AJXKeyboard).m
//  iOSDev
//
//  Created by Handy on 11/23/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import <objc/runtime.h>
#import "UIScrollView(AJXKeyboard).h"

static char AjxOldContentInset;

@implementation UIScrollView(AJXKeyboard)

- (void)cacheContentInset
{
    if (![self ajxOldContentInsetObj]) {
        [self setAjxOldContentInset:self.contentInset];
    }
}

- (void)restoreContentInset
{
    if ([self ajxOldContentInsetObj]) {
        self.contentInset = [self ajxOldContentInset];
    }
    [self resetAjxOldContentInset];
}

#pragma mark - ContentInset

- (void)setAjxOldContentInset:(UIEdgeInsets)contentInset
{
    objc_setAssociatedObject(self, &AjxOldContentInset, NSStringFromUIEdgeInsets(contentInset), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)resetAjxOldContentInset
{
    objc_setAssociatedObject(self, &AjxOldContentInset, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)ajxOldContentInset
{
    return UIEdgeInsetsFromString([self ajxOldContentInsetObj]);
}

- (id)ajxOldContentInsetObj
{
    return objc_getAssociatedObject(self, &AjxOldContentInset);
}


@end
