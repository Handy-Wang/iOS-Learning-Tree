//
//  NSStringUtils.m
//  iOSDev
//
//  Created by Handy on 11/5/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "NSStringUtils.h"
#import <CoreText/CoreText.h>

@implementation NSStringUtils

+ (CGSize)textSizeWithAttributeString:(NSAttributedString *)attributeString maxSize:(CGSize)maxSize line:(NSInteger)line font:(UIFont *)aFont
{
    if (attributeString.length <= 0) {
        return CGSizeZero;
    }
    NSAttributedString *content = attributeString;
    NSRange range = NSMakeRange(0, attributeString.length);
    NSRangePointer rangePointer = &range;
    NSDictionary * styleDic = [content attributesAtIndex:0 effectiveRange:rangePointer];
    if (aFont == nil) {
        aFont = styleDic[NSFontAttributeName];
    }
    
    NSParagraphStyle * paraStyle = styleDic[NSParagraphStyleAttributeName];
    CTFramesetterRef framesetterRef = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)content);
    
    // 粗略的高度，该高度不准
    CGSize suggestSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetterRef, CFRangeMake(0, content.length), NULL, CGSizeMake(maxSize.width, CGFLOAT_MAX), NULL);
    
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathAddRect(pathRef, NULL, CGRectMake(0, 0, ceil(suggestSize.width), ceil(suggestSize.height)));
    
    CTFrameRef frameRef = CTFramesetterCreateFrame(framesetterRef, CFRangeMake(0, content.length), pathRef, NULL);
    
    CFArrayRef lines = CTFrameGetLines(frameRef);
    CFIndex lineCount = CFArrayGetCount(lines);
    
    if (line == 0 || line > lineCount) {//无限制择计算全部高度
        line = lineCount;
    }
    
    CGPoint lineOrigins[lineCount];
    
    // 把ctFrame里每一行的初始坐标写到数组里，CoreText的坐标是左下角为原点
    CTFrameGetLineOrigins(frameRef, CFRangeMake(0, 0), lineOrigins);
    
    // 总高度 = 每行的高度总和，其中每行的高度为指定的值，不同字体需要微调
    CGFloat accurateHeight = 0;
    
    for (CFIndex i = 0; i < line; i++)
    {
        // 遍历每一行CTLine
        CTLineRef lineRef = CFArrayGetValueAtIndex(lines, i);
        
        CGFloat lineAscent;
        CGFloat lineDescent;
        CGFloat lineLeading; // 行距
        // 该函数除了会设置好ascent,descent,leading之外，还会返回这行的宽度
        CTLineGetTypographicBounds(lineRef, &lineAscent, &lineDescent, &lineLeading);
        // 微调行高
        CGFloat lineHeight = lineAscent + lineDescent + paraStyle.lineSpacing;
        if (lineHeight < aFont.lineHeight + paraStyle.lineSpacing) {
            lineHeight = aFont.lineHeight + paraStyle.lineSpacing;
        }
        accurateHeight += lineHeight;//累加真实行高
    }
    
    //去掉多出来的一行行间距
    CGFloat height = accurateHeight - paraStyle.lineSpacing;
    
    CFRelease(pathRef);
    CFRelease(frameRef);
    CFRelease(framesetterRef);
    return CGSizeMake(ceil(suggestSize.width), ceil(height));
}

@end
