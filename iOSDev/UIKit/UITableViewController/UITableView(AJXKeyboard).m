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
static char AjxKeyboardTableViewOldContentOffset;

@implementation UITableView(AJXKeyboard)

- (void)cacheContentInsetAndOffset
{
    if (![self ajxKeyboardTableViewOldContentInsetObj]) {
        [self setAjxKeyboardTableViewOldContentInset:self.contentInset];
    }
    
    if (![self ajxKeyboardTableViewOldContentOffsetObj]) {
        [self setAjxKeyboardTableViewOldContentOffset:self.contentOffset];
    }
}

- (void)restoreContentOffset
{
    if ([self ajxKeyboardTableViewOldContentOffsetObj]) {
        self.contentOffset = CGPointMake(0, 0);//[self ajxKeyboardTableViewOldContentOffset];
    }
    [self resetAjxKeyboardTableViewOldContentOffset];
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

- (id)ajxKeyboardTableViewOldContentInsetObj
{
    return objc_getAssociatedObject(self, &AjxKeyboardTableViewOldContentInset);
}

- (UIEdgeInsets)ajxKeyboardTableViewOldContentInset
{
    return UIEdgeInsetsFromString(objc_getAssociatedObject(self, &AjxKeyboardTableViewOldContentInset));
}

#pragma mark - ContentOffset

- (void)setAjxKeyboardTableViewOldContentOffset:(CGPoint)contentOffset
{
    objc_setAssociatedObject(self, &AjxKeyboardTableViewOldContentOffset, NSStringFromCGPoint(contentOffset), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)resetAjxKeyboardTableViewOldContentOffset
{
    objc_setAssociatedObject(self, &AjxKeyboardTableViewOldContentOffset, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)ajxKeyboardTableViewOldContentOffsetObj
{
    return objc_getAssociatedObject(self, &AjxKeyboardTableViewOldContentOffset);
}

- (CGPoint)ajxKeyboardTableViewOldContentOffset
{
    return CGPointFromString(objc_getAssociatedObject(self, &AjxKeyboardTableViewOldContentOffset));
}

@end
