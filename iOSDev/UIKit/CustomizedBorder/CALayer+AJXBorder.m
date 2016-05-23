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
static char AjxBorderCornerRadiusLayerAssObj;

@implementation CALayer(AJX_Border)

- (void)ajx_setBorderWidth:(CGFloat)borderWidth {
    AJXBorderLayer *ajxBorderWidthAndColorLayer = [self ajxBorderWidthAndColorLayer];
    AJXBorderLayer *ajxBorderCornerRadiusLayer = [self ajxBorderCornerRadiusLayer];
    
    if (!ajxBorderWidthAndColorLayer) {
        ajxBorderWidthAndColorLayer = [AJXBorderLayer new];
        [self setAjxBorderWidthAndColorLayer:ajxBorderWidthAndColorLayer];
        [self addSublayer:ajxBorderWidthAndColorLayer];
        ajxBorderWidthAndColorLayer.fillColor = nil;
        
        if (!(ajxBorderWidthAndColorLayer.strokeColor)) {
            ajxBorderWidthAndColorLayer.strokeColor = [UIColor blackColor].CGColor;
        }
    }
    
    if (ajxBorderCornerRadiusLayer) {
        //        self.borderWidth = 0;
        
        ajxBorderWidthAndColorLayer.path = ajxBorderCornerRadiusLayer.path;
        
    } else {
        CGRect pathRect = CGRectInset(self.bounds, borderWidth/2.0f, borderWidth/2.0f);
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:pathRect
                                                         byRoundingCorners:0
                                                               cornerRadii:CGSizeZero];
        [bezierPath closePath];
        ajxBorderWidthAndColorLayer.path = bezierPath.CGPath;
        //        [ajxBorderWidthAndColorLayer removeFromSuperlayer];
        //        [self setAjxBorderWidthAndColorLayer:nil];
        //        self.borderWidth = borderWidth;
    }
    
    ajxBorderWidthAndColorLayer.frame = self.bounds;
    ajxBorderWidthAndColorLayer.lineWidth = borderWidth;
}

- (void)ajx_setBorderColor:(CGColorRef)borderColor {
    AJXBorderLayer *ajxBorderWidthAndColorLayer = [self ajxBorderWidthAndColorLayer];
    
    if (ajxBorderWidthAndColorLayer) {
        ajxBorderWidthAndColorLayer.strokeColor = borderColor;
    }
}

- (void)ajx_setCornerRadius:(CGFloat)cornerRadius andRectCorner:(UIRectCorner)rectCorner {
    AJXBorderLayer *ajxBorderCornerRadiusLayer = [self ajxBorderCornerRadiusLayer];
    AJXBorderLayer *ajxBorderWidthAndColorLayer = [self ajxBorderWidthAndColorLayer];
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                     byRoundingCorners:rectCorner
                                                           cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    [bezierPath closePath];
    
    if (!ajxBorderCornerRadiusLayer) {
        ajxBorderCornerRadiusLayer = [AJXBorderLayer new];
        [self setAjxBorderCornerRadiusLayer:ajxBorderCornerRadiusLayer];
    }
    ajxBorderCornerRadiusLayer.path = bezierPath.CGPath;
    ajxBorderCornerRadiusLayer.frame = self.bounds;
    
    if (ajxBorderWidthAndColorLayer) {
        ajxBorderWidthAndColorLayer.path = bezierPath.CGPath;
        ajxBorderWidthAndColorLayer.lineWidth = ajxBorderWidthAndColorLayer.lineWidth;
        ajxBorderWidthAndColorLayer.strokeColor = ajxBorderWidthAndColorLayer.strokeColor;
    }
    
    self.mask = ajxBorderCornerRadiusLayer;
    self.masksToBounds = YES;
}

#pragma mark - ====================Getter & Setter methods====================

- (void)setAjxBorderWidthAndColorLayer:(AJXBorderLayer *)ajxBorderWidthAndColorLayer {
    objc_setAssociatedObject(self, &AjxBorderWidthAndColorLayerAssObj, ajxBorderWidthAndColorLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (AJXBorderLayer *)ajxBorderWidthAndColorLayer {
    return objc_getAssociatedObject(self, &AjxBorderWidthAndColorLayerAssObj);
}

- (void)setAjxBorderCornerRadiusLayer:(AJXBorderLayer *)ajxBorderCornerRadiusLayer {
    objc_setAssociatedObject(self, &AjxBorderCornerRadiusLayerAssObj, ajxBorderCornerRadiusLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (AJXBorderLayer *)ajxBorderCornerRadiusLayer {
    return objc_getAssociatedObject(self, &AjxBorderCornerRadiusLayerAssObj);
}

@end
