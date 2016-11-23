//
//  KBScrollView.m
//  iOSDev
//
//  Created by Handy on 11/23/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "KBScrollView.h"
#import "AJXKBTextView.h"

#define kTextViewHeight             (200.0f)
#define kTextViewWidth              (400)

@implementation KBScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        float r = arc4random()%255/255.0f;
        float g = arc4random()%255/255.0f;
        float b = arc4random()%255/255.0f;
        UIColor *bgColor = [UIColor colorWithRed:r green:g blue:b alpha:1];
        self.backgroundColor = bgColor;
        
        CGRect textView1Frame = CGRectMake(0,
                                           kScrollViewContentSizeEdge-3*kTextViewHeight,
                                           kTextViewWidth,
                                           kTextViewHeight);
        AJXKBTextView *textView1 = [[AJXKBTextView alloc] initWithFrame:textView1Frame];
        textView1.layer.borderColor = [UIColor blackColor].CGColor;
        textView1.layer.borderWidth = 1.0f;
        textView1.text = @"2018世界杯1111111";
        [self addSubview:textView1];
        
        CGRect textView2Frame = CGRectMake(0,
                                           kScrollViewContentSizeEdge-kTextViewHeight,
                                           kTextViewWidth,
                                           kTextViewHeight);
        AJXKBTextView *textView2 = [[AJXKBTextView alloc] initWithFrame:textView2Frame];
        textView2.layer.borderColor = [UIColor blackColor].CGColor;
        textView2.layer.borderWidth = 1.0f;
        textView2.text = @"2018世界杯22222222";
        [self addSubview:textView2];
    }
    return self;
}

@end
