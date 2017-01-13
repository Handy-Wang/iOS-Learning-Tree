//
//  IDCacheItem.m
//  iOSDev
//
//  Created by XiaoShan on 2/27/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "IDCacheItem.h"

@interface IDCacheItem() //<NSDiscardableContent>
@end

@implementation IDCacheItem

- (void)dealloc {
    NSLog(@"dealloc img %@...", self);
}
//
//- (BOOL)beginContentAccess
//{
//    NSLog(@"%@--%@", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
//    return YES;
//}
//
//- (void)endContentAccess
//{
//    NSLog(@"%@--%@", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
//}
//
//- (void)discardContentIfPossible
//{
//    NSLog(@"%@--%@", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
//}
//
//- (BOOL)isContentDiscarded
//{
//    NSLog(@"%@--%@", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
//    return YES;
//}

@end
