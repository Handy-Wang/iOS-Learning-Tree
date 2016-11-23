//
//  UITableView(AJXKeyboard).m
//  iOSDev
//
//  Created by Handy on 11/22/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import <objc/runtime.h>
#import "UITableView(AJXKeyboard).h"

static char AjxKeyboardTableViewOldContentInset;

@implementation UITableView(AJXKeyboard)

- (void)cacheContentInset
{
    if (![self ajxKeyboardTableViewOldContentInsetObj]) {
        [self setAjxKeyboardTableViewOldContentInset:self.contentInset];
    }
}

- (void)restoreContentInset
{
    if ([self ajxKeyboardTableViewOldContentInsetObj]) {
        self.contentInset = [self ajxKeyboardTableViewOldContentInset];
    }
    [self resetAjxKeyboardTableViewOldContentInset];
}

#pragma mark - ContentInset

- (void)setAjxKeyboardTableViewOldContentInset:(UIEdgeInsets)contentInset
{
    objc_setAssociatedObject(self, &AjxKeyboardTableViewOldContentInset, NSStringFromUIEdgeInsets(contentInset), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)resetAjxKeyboardTableViewOldContentInset
{
    objc_setAssociatedObject(self, &AjxKeyboardTableViewOldContentInset, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)ajxKeyboardTableViewOldContentInset
{
    return UIEdgeInsetsFromString([self ajxKeyboardTableViewOldContentInsetObj]);
}

- (id)ajxKeyboardTableViewOldContentInsetObj
{
    return objc_getAssociatedObject(self, &AjxKeyboardTableViewOldContentInset);
}

@end
