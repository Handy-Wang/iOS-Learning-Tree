//
//  CALayer(AJX_Border).m
//  iOSDev
//
//  Created by Handy on 5/23/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import <objc/runtime.h>
#import "CALayer+AJXBorder.h"

@interface AJXBorderLayer : CAShapeLayer
@end

@implementation AJXBorderLayer
@end

//####################################################################

static char AjxBorderWidthAndColorLayerAssObj;
static char AjxBorderColorAssObj;
static char AjxBorderWidthAssObj;

static char AjxBorderCornerRadiusLayerAssObj;
static char AjxBorderCornerRadiusAssObj;

static char NeedRedrawAll;

static char AjxBorderObserver;

@implementation CALayer(AJX_Border)

//TODO 为什么边框偏细？目前解决方法是：上层调用时按：setBorderColor/setBorderWidth/setCornerRadius的顺序

- (void)ajx_setBorderWidth:(CGFloat)borderWidth {
    if ([self ajxBorderWidth] != borderWidth*0.5 || [self needRedrawAll]) {
    
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
        
        if (self.bounds.size.height != 0 && self.bounds.size.width != 0) {
            UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextSetLineWidth(context, [self ajxBorderWidth]);
            CGContextSetStrokeColorWithColor(context, borderColor);
            CGContextAddPath(context, pathRef);
            CGContextDrawPath(context, kCGPathStroke);
            UIImage *borderImg = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            ajxBorderWidthAndColorLayer.frame = self.bounds;
            ajxBorderWidthAndColorLayer.contents = (__bridge id _Nullable)(borderImg.CGImage);//关键
            self.masksToBounds = YES;//关键
        }
        
        CGPathRelease(pathRef);
        
        [self observeBoundsChangeIfNeeded];
    }
}

- (void)ajx_setBorderColor:(CGColorRef)borderColor {
    if (!CGColorEqualToColor([self ajxBorderColor], borderColor) || [self needRedrawAll]) {
    
        if (!borderColor) {
            borderColor = [UIColor blackColor].CGColor;
        }
        [self setAjxBorderColor:borderColor];
        
        AJXBorderLayer *ajxBorderWidthAndColorLayer = [self ajxBorderWidthAndColorLayer];
        if (ajxBorderWidthAndColorLayer) {
            [self ajx_setBorderWidth:[self ajxBorderWidth]];
        }
        
        [self observeBoundsChangeIfNeeded];
    }
}

- (void)ajx_setCornerRadius:(UIEdgeInsets)cornerRadius {
    if (!UIEdgeInsetsEqualToEdgeInsets([self ajxBorderCornerRadius], cornerRadius) || [self needRedrawAll]) {
    
        [self setAjxBorderCornerRadius:cornerRadius];
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
        //注意：千万不要给maskLayer设置frame或bounds
        
        if (ajxBorderWidthAndColorLayer) {
            ajxBorderWidthAndColorLayer.path = pathRef;
            [self ajx_setBorderWidth:[self ajxBorderWidth]];
        }
        
        self.mask = ajxBorderCornerRadiusLayer;
        self.masksToBounds = YES;
        self.shouldRasterize = YES;
        self.rasterizationScale = [UIScreen mainScreen].scale;
        
        CGPathRelease(pathRef);
        
        [self observeBoundsChangeIfNeeded];
    }
}

#pragma mark - ====================Private methods====================

#pragma mark - Observe bounds change
- (void)observeBoundsChangeIfNeeded {
    if (![self ajxBorderObserver]) {
        CALayerAJXBorderObserver *ob = [[CALayerAJXBorderObserver alloc] initWithLayer:self andDeallocBlock:^(CALayer *layer, CALayerAJXBorderObserver *ob) {
            [layer removeObserver:ob forKeyPath:kObservedFrameKeyPath];
//            NSLog(@"deallocing CALayerAJXBorderObserver %@", layer);
        }];
        [self setAjxBorderObserver:ob];
        [self addObserver:ob forKeyPath:kObservedFrameKeyPath options:NSKeyValueObservingOptionNew+NSKeyValueObservingOptionOld context:NULL];
    }
}

- (void)ajx_observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object
                            change:(nullable NSDictionary<NSString*, id> *)change context:(nullable void *)context
{
    id oldValue = [change objectForKey:NSKeyValueChangeOldKey];
    id newValue = [change objectForKey:NSKeyValueChangeNewKey];
    
    if (oldValue && newValue && oldValue != [NSNull null] && newValue != [NSNull null]) {
        CGRect oldFrame = CGRectZero;
        [oldValue getValue:&oldFrame];
        
        CGRect newFrame = CGRectZero;
        [newValue getValue:&newFrame];
        
        if ([keyPath isEqualToString:kObservedFrameKeyPath] && !CGRectEqualToRect(oldFrame, newFrame)) {
//            NSLog(@"%@", NSStringFromSelector(_cmd));
            [self setNeedRedrawAll:YES];
            
            [CATransaction begin];
            [CATransaction setValue:@(YES) forKey:kCATransactionDisableActions];
            [self ajx_setBorderColor:[self ajxBorderColor]];
            [self ajx_setBorderWidth:[self ajxBorderWidth]];
            [self ajx_setCornerRadius:[self ajxBorderCornerRadius]];
            [CATransaction commit];
            
            [self setNeedRedrawAll:NO];
        }
    }
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

- (void)setAjxBorderCornerRadius:(UIEdgeInsets)cornerRadius {
    objc_setAssociatedObject(self, &AjxBorderCornerRadiusAssObj, NSStringFromUIEdgeInsets(cornerRadius), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)ajxBorderCornerRadius {
    return UIEdgeInsetsFromString(objc_getAssociatedObject(self, &AjxBorderCornerRadiusAssObj));
}

- (void)setNeedRedrawAll:(BOOL)need {
    objc_setAssociatedObject(self, &NeedRedrawAll, @(need), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)needRedrawAll {
    return [objc_getAssociatedObject(self, &NeedRedrawAll) boolValue];
}

- (void)setAjxBorderObserver:(CALayerAJXBorderObserver *)borderGC {
    objc_setAssociatedObject(self, &AjxBorderObserver, borderGC, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CALayerAJXBorderObserver *)ajxBorderObserver {
    return objc_getAssociatedObject(self, &AjxBorderObserver);
}

@end
