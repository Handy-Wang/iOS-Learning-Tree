//
//  CALayer(AJX_Border).m
//  iOSDev
//
//  Created by Handy on 5/23/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "CALayer+AJXBorder.h"
#import <objc/runtime.h>

@interface AJXBorderLayer : CAShapeLayer
@end

@implementation AJXBorderLayer
@end

//####################################################################

static char AjxBorderWidthAndColorLayerAssObj;
static char AjxBorderColorAssObj;
static char AjxBorderWidthAssObj;
static char AjxBorderCornerRadiusLayerAssObj;

@implementation CALayer(AJX_Border)

- (void)ajx_setBorderWidth:(CGFloat)borderWidth {
    AJXBorderLayer *ajxBorderWidthAndColorLayer = [self ajxBorderWidthAndColorLayer];
    AJXBorderLayer *ajxBorderCornerRadiusLayer = [self ajxBorderCornerRadiusLayer];
    CGColorRef borderColor = [self ajxBorderColor];
    [self setAjxBorderWidth:borderWidth*0.5];
    
    if (!ajxBorderWidthAndColorLayer) {
        ajxBorderWidthAndColorLayer = [AJXBorderLayer new];
        [self setAjxBorderWidthAndColorLayer:ajxBorderWidthAndColorLayer];
        [self addSublayer:ajxBorderWidthAndColorLayer];
        ajxBorderWidthAndColorLayer.fillColor = nil;
        
        if (!borderColor) {
            borderColor = [UIColor blackColor].CGColor;
        }
    }
    
    CGPathRef pathRef = nil;
    if (ajxBorderCornerRadiusLayer) {
        pathRef = CGPathRetain(ajxBorderCornerRadiusLayer.path);
        
    } else {
        pathRef = CGPathCreateWithRect(self.bounds, NULL);
    }
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, [self ajxBorderWidth]);
    CGContextSetStrokeColorWithColor(context, borderColor);
    CGContextSetFillColor(context, nil);
    CGContextAddPath(context, pathRef);
    CGContextDrawPath(context, kCGPathStroke);
    UIImage *borderImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    ajxBorderWidthAndColorLayer.frame = self.bounds;
    ajxBorderWidthAndColorLayer.contents = (__bridge id _Nullable)(borderImg.CGImage);//关键
    self.masksToBounds = YES;//关键
    
    CGPathRelease(pathRef);
}

- (void)ajx_setBorderColor:(CGColorRef)borderColor {
    if (!borderColor) {
        borderColor = [UIColor blackColor].CGColor;
    }
    [self setAjxBorderColor:borderColor];
    
    AJXBorderLayer *ajxBorderWidthAndColorLayer = [self ajxBorderWidthAndColorLayer];
    if (ajxBorderWidthAndColorLayer) {
        [self ajx_setBorderWidth:[self ajxBorderWidth]];
    }
    //todo 为什么边框偏细？？？
}

- (void)ajx_setCornerRadius:(UIEdgeInsets)cornerRadius {
    AJXBorderLayer *ajxBorderCornerRadiusLayer = [self ajxBorderCornerRadiusLayer];
    AJXBorderLayer *ajxBorderWidthAndColorLayer = [self ajxBorderWidthAndColorLayer];
    
    CGMutablePathRef pathRef = CGPathCreateMutable();
    if (cornerRadius.top > 0) {
        CGFloat startAngle = -M_PI;
        CGFloat endAngle = -M_PI/2.0f;
        CGPathAddArc(pathRef, NULL, cornerRadius.top*0.5, cornerRadius.top*0.5, cornerRadius.top*0.5, startAngle, endAngle, NO);
    } else {
        CGPathMoveToPoint(pathRef, NULL, 0, 0);
    }
    
    if (cornerRadius.right > 0) {
        CGPathAddLineToPoint(pathRef, NULL, self.bounds.size.width-cornerRadius.right*0.5, 0);
        CGFloat startAngle = -M_PI/2.0f;
        CGFloat endAngle = 0.0f;
        CGPathAddArc(pathRef, NULL, self.bounds.size.width-cornerRadius.right*0.5, cornerRadius.right*0.5, cornerRadius.right*0.5, startAngle, endAngle, NO);
    } else {
        CGPathAddLineToPoint(pathRef, NULL, self.bounds.size.width, 0);
    }
    
    if (cornerRadius.bottom > 0) {
        CGPathAddLineToPoint(pathRef, NULL, self.bounds.size.width, self.bounds.size.height-cornerRadius.bottom*0.5);
        CGFloat startAngle = 0.0f;
        CGFloat endAngle = M_PI/2.0f;
        CGPathAddArc(pathRef, NULL, self.bounds.size.width-cornerRadius.bottom*0.5, self.bounds.size.height-cornerRadius.bottom*0.5, cornerRadius.bottom*0.5, startAngle, endAngle, NO);
    } else {
        CGPathAddLineToPoint(pathRef, NULL, self.bounds.size.width, self.bounds.size.height);
    }
    
    if (cornerRadius.left > 0) {
        CGPathAddLineToPoint(pathRef, NULL, cornerRadius.left*0.5, self.bounds.size.height);
        CGFloat startAngle = M_PI/2.0f;
        CGFloat endAngle = M_PI;
        CGPathAddArc(pathRef, NULL, cornerRadius.left*0.5, self.bounds.size.height-cornerRadius.left*0.5, cornerRadius.left*0.5, startAngle, endAngle, NO);
    } else {
        CGPathAddLineToPoint(pathRef, NULL, 0, self.bounds.size.height);
    }
    CGPathCloseSubpath(pathRef);
    
    if (!ajxBorderCornerRadiusLayer) {
        ajxBorderCornerRadiusLayer = [AJXBorderLayer new];
        [self setAjxBorderCornerRadiusLayer:ajxBorderCornerRadiusLayer];
    }
    ajxBorderCornerRadiusLayer.path = pathRef;
    
    if (ajxBorderWidthAndColorLayer) {
        ajxBorderWidthAndColorLayer.path = pathRef;
        [self ajx_setBorderWidth:[self ajxBorderWidth]];
    }
    
    self.mask = ajxBorderCornerRadiusLayer;
    self.masksToBounds = YES;
    
    CGPathRelease(pathRef);
}

#pragma mark - ====================Getter & Setter methods====================

- (void)setAjxBorderWidthAndColorLayer:(AJXBorderLayer *)ajxBorderWidthAndColorLayer {
    objc_setAssociatedObject(self, &AjxBorderWidthAndColorLayerAssObj, ajxBorderWidthAndColorLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (AJXBorderLayer *)ajxBorderWidthAndColorLayer {
    return objc_getAssociatedObject(self, &AjxBorderWidthAndColorLayerAssObj);
}

- (void)setAjxBorderColor:(CGColorRef)color {
    objc_setAssociatedObject(self, &AjxBorderColorAssObj, (__bridge id)(color), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGColorRef)ajxBorderColor {
    return (__bridge CGColorRef)(objc_getAssociatedObject(self, &AjxBorderColorAssObj));
}

- (void)setAjxBorderWidth:(CGFloat)width {
    objc_setAssociatedObject(self, &AjxBorderWidthAssObj, @(width), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)ajxBorderWidth {
    return [objc_getAssociatedObject(self, &AjxBorderWidthAssObj) floatValue];
}

- (void)setAjxBorderCornerRadiusLayer:(AJXBorderLayer *)ajxBorderCornerRadiusLayer {
    objc_setAssociatedObject(self, &AjxBorderCornerRadiusLayerAssObj, ajxBorderCornerRadiusLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (AJXBorderLayer *)ajxBorderCornerRadiusLayer {
    return objc_getAssociatedObject(self, &AjxBorderCornerRadiusLayerAssObj);
}

@end
