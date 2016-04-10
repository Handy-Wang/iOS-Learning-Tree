//
//  UIFont(extension).h
//  HGShopAssistant
//
//  Created by JiaLei on 15/10/15.
//  Copyright © 2015年 Higegou. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TSFont(fontSize)            [UIFont systemFontOfSizeForTS:fontSize]
#define TSBoldFont(fontSize)        [UIFont boldSystemFontOfSizeForTS:fontSize]
#define TSDigitFont(fontSize)       [UIFont digitAndLetterFontOfSizeForTS:fontSize]
#define TSBoldDigitFont(fontSize)   [UIFont boldDigitAndLetterFontOfSizeForTS:fontSize]

@interface UIFont(TS_FontName)

+ (UIFont *)systemFontOfSizeForTS:(CGFloat)fontSize;
+ (UIFont *)boldSystemFontOfSizeForTS:(CGFloat)fontSize;

+ (UIFont *)digitAndLetterFontOfSizeForTS:(CGFloat)fontSize;
+ (UIFont *)boldDigitAndLetterFontOfSizeForTS:(CGFloat)fontSize;

@end
