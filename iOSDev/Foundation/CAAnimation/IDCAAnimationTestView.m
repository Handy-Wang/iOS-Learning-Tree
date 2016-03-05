//
//  IDCAAnimationTestView.m
//  iOSDev
//
//  Created by XiaoShan on 2/29/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "IDCAAnimationTestView.h"
#import "IDCAAnimationTestLayer.h"

@implementation IDCAAnimationTestView

+ (Class)layerClass {
    NSLog(@"DEBUG::::::::::%@", NSStringFromSelector(_cmd));
    return [IDCAAnimationTestLayer class];
}

- (void)setNeedsDisplay {
    NSLog(@"DEBUG::::::::::%@", NSStringFromSelector(_cmd));
    [super setNeedsDisplay];
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    NSLog(@"DEBUG::::::::::%@", NSStringFromSelector(_cmd));
    [super drawLayer:layer inContext:ctx];
}

- (void)drawRect:(CGRect)rect {
    NSLog(@"DEBUG::::::::::%@", NSStringFromSelector(_cmd));
    [super drawRect:rect];
}

- (nullable id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)event {
    NSLog(@"DEBUG::::::::::%@", NSStringFromSelector(_cmd));
    id<CAAction> action = [super actionForLayer:layer forKey:event];
    return action;
}

@end
