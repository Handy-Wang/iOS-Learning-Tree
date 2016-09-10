//
//  TouchView.m
//  iOSDev
//
//  Created by Handy on 9/7/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "TouchView.h"

typedef NS_ENUM(NSInteger, TouchState) {
    TouchState_Begin,
    TouchState_LongPress,
    TouchState_Moving,
    TouchState_Ended,
    TouchState_Cancelled
};


@interface TouchView () {
    TouchState _state;
    BOOL _existsLongPressListner;
    NSTimer *_longPressTimer;
}
@end

@implementation TouchView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _existsLongPressListner = YES;
    }
    return self;
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSLog(@"%@ - %@", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
//    _state = TouchState_Begin;
//    _longPressTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self
//                       selector:@selector(fireLongPress:) userInfo:nil repeats:NO];
//}
//
//- (void)fireLongPress:(NSTimer *)timer {
//    if (_state != TouchState_Moving && _state != TouchState_Ended &&
//        _state != TouchState_Cancelled && _existsLongPressListner) {
//        _state = TouchState_LongPress;
//        NSLog(@"long click ...");
//    }
//}
//
//- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    if (_state != TouchState_LongPress && _state != TouchState_Ended && _state != TouchState_Cancelled) {
//        _state = TouchState_Moving;
//        NSLog(@"%@ - %@", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
//    }
//}
//
//- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    if (_state != TouchState_Ended && _state != TouchState_Cancelled) {
//        TouchState oldState = _state;
//        _state = TouchState_Ended;
//        if (oldState == TouchState_Moving) {
//            NSLog(@"move end ...");
//            
//        } else if (oldState == TouchState_LongPress) {
//            NSLog(@"long press end ...");
//            
//        } else {
//            NSLog(@"click ...");
//        }
//    }
//    
//    if ([_longPressTimer isValid]) {
//        [_longPressTimer invalidate];
//        _longPressTimer = nil;
//    }
//    NSLog(@"%@ - %@", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
//}
//
//- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    if (_state != TouchState_Ended && _state != TouchState_Cancelled) {
//        _state = TouchState_Cancelled;
//    }
//    NSLog(@"%@ - %@", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
//}

@end
