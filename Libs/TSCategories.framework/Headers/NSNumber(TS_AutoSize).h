//
//  CGSize(TS_AutoSize).h
//  HGShopAssistant
//
//  Created by JiaLei on 15/10/13.
//  Copyright © 2015年 Higegou. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ts_autoAdjustSize(size)  [NSNumber ts_autoAdjustSize:size]

@interface NSNumber(TS_AutoSize)

+ (CGFloat)ts_autoAdjustSize:(CGFloat)size;

@end