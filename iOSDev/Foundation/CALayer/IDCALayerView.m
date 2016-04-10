//
//  IDCALayerView.m
//  iOSDev
//
//  Created by XiaoShan on 2/28/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "IDCALayerView.h"
#import "IDCALayer.h"

@implementation IDCALayerView

+ (Class)layerClass {
    return [IDCALayer class];
}

- (void)setNeedsDisplay {
    [super setNeedsDisplay];
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
    [super drawLayer:layer inContext:ctx];
}

- (void)drawRect:(CGRect)rect {
    NSLog(@"%@", NSStringFromSelector(_cmd));
}

@end
