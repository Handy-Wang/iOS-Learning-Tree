//
//  IDCALayer.m
//  iOSDev
//
//  Created by XiaoShan on 2/27/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "IDCALayer.h"

@implementation IDCALayer

- (void)setNeedsDisplay {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    [super setNeedsDisplay];
}

- (void)display {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    [super display];
}

- (void)drawInContext:(CGContextRef)ctx {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    [super drawInContext:ctx];
}

@end
