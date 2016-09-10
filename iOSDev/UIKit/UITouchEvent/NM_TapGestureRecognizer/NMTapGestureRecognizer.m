//
//  NMTapGestureRecognizer.m
//  iOSDev
//
//  Created by Handy on 9/10/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "NMTapGestureRecognizer.h"

@implementation NMTapGestureRecognizer

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@ - %@ - Enter", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
    //    [super touchesBegan:touches withEvent:event];
    NSLog(@"%@ - %@ - Exit", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@ - %@ - Enter", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
    //    [super touchesMoved:touches withEvent:event];
    NSLog(@"%@ - %@ - Exit", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@ - %@ - Enter", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
    //    [super touchesEnded:touches withEvent:event];
    NSLog(@"%@ - %@ - Exit", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"%@ - %@ - Enter", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
    //    [super touchesCancelled:touches withEvent:event];
    NSLog(@"%@ - %@ - Exit", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
}

@end
