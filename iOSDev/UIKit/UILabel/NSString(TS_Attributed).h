//
//  NSString(TS_Attributed).h
//  HGShopAssistant
//
//  Created by Handy.Wang on 15/10/13.
//  Copyright © 2015年 Higegou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString(TS_Attributed)

- (NSAttributedString *)getAttributedStringAndItsSize:(NSDictionary *)attributes
                                            lineSpace:(CGFloat)lineSpace
                                            breakMode:(NSLineBreakMode)lineBreakMode
                                            alignment:(NSTextAlignment)textAlignment
                                      constrainedSize:(CGSize)constrainedSize
                                             textSize:(CGSize *)textSize;


@end
