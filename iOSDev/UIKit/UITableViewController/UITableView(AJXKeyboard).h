//
//  UITableView(AJXKeyboard).h
//  iOSDev
//
//  Created by Handy on 11/22/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView(AJXKeyboard)

- (void)cacheContentInsetAndOffset;

- (void)restoreContentInsetAndOffset;

- (UIEdgeInsets)ajxKeyboardTableViewOldContentInset;

- (CGPoint)ajxKeyboardTableViewOldContentOffset;

@end
