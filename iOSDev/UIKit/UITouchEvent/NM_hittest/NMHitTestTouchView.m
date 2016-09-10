//
//  NMHitTestTouchView.m
//  iOSDev
//
//  Created by Handy on 9/7/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "NMHitTestTouchView.h"

@implementation NMHitTestTouchView

/* 下面两个原生方法的日志是为了验证nm_hitTest的逻辑正确性
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    NSLog(@"%@ -- %@", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
    UIView *v = [super hitTest:point withEvent:event];
    NSLog(@"%@ -- %@, return view %@", NSStringFromClass(self.class), NSStringFromSelector(_cmd), NSStringFromClass(v.class));
    return v;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL inSide = [super pointInside:point withEvent:event];
    NSString *inSideStr = inSide ? @"YES" : @"NO";
    NSLog(@"%@ -- %@, inSide %@", NSStringFromClass(self.class), NSStringFromSelector(_cmd), inSideStr);
    return inSide;
}
*/

#pragma mark - UIView(UIViewGeometry) - hitTest:withEvent:

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    return [self nm_hitTest:point withEvent:event];
}

- (NMHitTestTouchView *)nm_hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    NSLog(@"%@ -- %@", NSStringFromClass(self.class), NSStringFromSelector(_cmd));

    NMHitTestTouchView *responsedView = nil;
    BOOL inSide = [self nm_pointInside:point withEvent:event];
    
    if (inSide) {
        responsedView = self;
        NSArray *subviews = self.subviews;
        for (NSInteger i = (subviews.count - 1); i >= 0; i--) {
            NMHitTestTouchView *v = subviews[i];
            point = [v convertPoint:point fromView:self];
            NMHitTestTouchView *subResponsedView = [v nm_hitTest:point withEvent:event];
            if (subResponsedView) {
                responsedView = subResponsedView;
                break;
            }
        }
    }
    
    NSLog(@"%@ -- %@, return view %@", NSStringFromClass(self.class), NSStringFromSelector(_cmd), NSStringFromClass(responsedView.class));
    
    return responsedView;
}

- (BOOL)nm_pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL inSide = !(self.hidden) && self.alpha >= 0.01 && self.userInteractionEnabled && CGRectContainsPoint(self.bounds, point);
    NSString *inSideStr = inSide ? @"YES" : @"NO";
    NSLog(@"%@ -- %@, inSide %@", NSStringFromClass(self.class), NSStringFromSelector(_cmd), inSideStr);
    
    return inSide;
}

#pragma mark - UIResponder

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
