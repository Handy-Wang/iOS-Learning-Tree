//
//  KBScrollView.m
//  iOSDev
//
//  Created by Handy on 11/23/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "KBScrollView.h"
#import "AJXKBTextView.h"
#import "AJXKBTextField.h"

#define kTextViewHeight             (50.0f)
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
                                           2*kTextViewHeight,
                                           kTextViewWidth,
                                           kTextViewHeight);
        AJXKBTextView *textView1 = [[AJXKBTextView alloc] initWithFrame:textView1Frame];
        textView1.layer.borderColor = [UIColor blackColor].CGColor;
        textView1.layer.borderWidth = 1.0f;
        textView1.text = @"2018世界杯1111111TextView";
        [self addSubview:textView1];
        
        CGRect textView2Frame = CGRectMake(0,
                                           kScrollViewContentSizeEdge-kTextViewHeight,
                                           kTextViewWidth,
                                           kTextViewHeight);
        AJXKBTextView *textView2 = [[AJXKBTextView alloc] initWithFrame:textView2Frame];
        textView2.layer.borderColor = [UIColor blackColor].CGColor;
        textView2.layer.borderWidth = 1.0f;
        textView2.text = @"2018世界杯22222222TextView";
        [self addSubview:textView2];
        
        CGRect textField1Frame = CGRectMake(0,
                                            0,
                                            kTextViewWidth,
                                            kTextViewHeight);
        AJXKBTextField *textField1 = [[AJXKBTextField alloc] initWithFrame:textField1Frame];
        textField1.ts_top = textView1.ts_bottom + 5;
        textField1.layer.borderColor = [UIColor blackColor].CGColor;
        textField1.layer.borderWidth = 1.0f;
        textField1.text = @"2018世界杯333333333TextField";
        [self addSubview:textField1];
        
        CGRect textField2Frame = CGRectMake(0,
                                            0,
                                            kTextViewWidth,
                                            kTextViewHeight);
        AJXKBTextField *textField2 = [[AJXKBTextField alloc] initWithFrame:textField2Frame];
        textField2.ts_bottom = textView2.ts_top - 5;
        textField2.layer.borderColor = [UIColor blackColor].CGColor;
        textField2.layer.borderWidth = 1.0f;
        textField2.text = @"2018世界杯44444444TextField";
        [self addSubview:textField2];
    }
    return self;
}

@end
