//
//  NSStringUtils.h
//  iOSDev
//
//  Created by Handy on 11/5/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSStringUtils : NSObject

+ (CGSize)textSizeWithAttributeString:(NSAttributedString *)attributeString maxSize:(CGSize)maxSize line:(NSInteger)line font:(UIFont *)aFont;

@end
