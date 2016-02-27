//
//  UIColor(TS_HexColor).h
//  HGShopAssistant
//
//  Created by JiaLei on 15/10/14.
//  Copyright © 2015年 Higegou. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TSUIColor(key)      [UIColor ts_colorWithHexColorValue:key]
#define TSUIColorRef(key)   [UIColor ts_colorWithHexColorValue:key].CGColor

@interface UIColor(TS_HexColor)

+ (UIColor *)ts_colorWithHexColorValue:(NSString *)hexValue;

@end
