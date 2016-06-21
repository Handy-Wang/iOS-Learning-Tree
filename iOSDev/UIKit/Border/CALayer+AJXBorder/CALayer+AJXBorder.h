//
//  CALayer(AJX_Border).h
//  iOSDev
//
//  Created by Handy on 5/23/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "CALayerAJXBorderObserver.h"

@interface CALayer(AJXBorder) <CALayerAJXBorderObserverDelegate>

- (void)ajx_setBorderWidth:(CGFloat)borderWidth;

- (void)ajx_setBorderColor:(CGColorRef)borderColor;

- (void)ajx_setCornerRadius:(UIEdgeInsets)cornerRadius;

@end