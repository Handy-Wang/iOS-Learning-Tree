//
//  IDCAAnimationTestLayer.m
//  iOSDev
//
//  Created by XiaoShan on 2/29/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "IDCAAnimationTestLayer.h"

@implementation IDCAAnimationTestLayer


- (void)setNeedsDisplay {
    NSLog(@"DEBUG::::::::::%@", NSStringFromSelector(_cmd));
    [super setNeedsDisplay];
}

- (void)display {
    NSLog(@"DEBUG::::::::::%@", NSStringFromSelector(_cmd));
    [super display];
}

- (void)drawInContext:(CGContextRef)ctx {
    NSLog(@"DEBUG::::::::::%@", NSStringFromSelector(_cmd));
    [super drawInContext:ctx];
}


@end
