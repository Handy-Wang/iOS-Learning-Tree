//
//  UIScrollView(AJXKeyboard).h
//  iOSDev
//
//  Created by Handy on 11/23/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView(AJXKeyboard)

- (void)cacheContentInset;

- (void)restoreContentInset;

- (UIEdgeInsets)ajxKeyboardOldContentInset;

@end
