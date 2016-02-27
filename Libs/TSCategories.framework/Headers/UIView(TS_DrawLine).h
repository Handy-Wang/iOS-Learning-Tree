//
//  UIView+_TS_DrawLine_.h
//  HGShopAssistant
//
//  Created by XiaoDou on 15/10/16.
//  Copyright © 2015年 Higegou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (TS_DrawLine)

+ (void)ts_drawCellSeperateLine:(CGRect)bounds;
+ (void)ts_drawCellSeperateLine:(CGRect)bounds edgetInsets:(UIEdgeInsets)edgeInsets;
+ (void)ts_drawCellSeperateLine:(CGRect)bounds margin:(float)margin;

@end
