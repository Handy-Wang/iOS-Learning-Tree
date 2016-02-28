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
    [super setNeedsDisplay];
    NSLog(@"%@", NSStringFromSelector(_cmd));    
}

- (void)display {
    [super display];
    NSLog(@"%@", NSStringFromSelector(_cmd));    
}

- (void)drawInContext:(CGContextRef)ctx {
    [super drawInContext:ctx];
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

@end
