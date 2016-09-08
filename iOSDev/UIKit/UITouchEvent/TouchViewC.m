//
//  TouchViewC.m
//  iOSDev
//
//  Created by Handy on 9/7/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "TouchViewC.h"

@implementation TouchViewC

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    return [super hitTest:point withEvent:event];
//}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
//    NSLog(@"%@ - %@", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
//    NSLog(@"%@ - %@", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
//    NSLog(@"%@ - %@", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
//    NSLog(@"%@ - %@", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
}

@end
