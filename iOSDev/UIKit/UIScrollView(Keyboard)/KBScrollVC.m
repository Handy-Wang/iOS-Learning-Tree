//
//  KBScrollVC.m
//  iOSDev
//
//  Created by Handy on 11/23/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "KBScrollVC.h"
#import "AJXKBTextView.h"

#define kScrollViewContentSizeEdge  (600.0f)
#define kScrollViewContentSize      (CGSizeMake(kScrollViewContentSizeEdge, kScrollViewContentSizeEdge))
#define kTextViewHeight             (200.0f)
#define kTextViewWidth              (400)

@interface KBScrollVC ()
@property (nonatomic, strong) UIScrollView *scrollView;
@end

@implementation KBScrollVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(finish)];
    [self.view addGestureRecognizer:tapGesture];
    
    CGFloat r = arc4random()%255/255.0f;
    CGFloat g = arc4random()%255/255.0f;
    CGFloat b = arc4random()%255/255.0f;
    UIColor *bgColor = [UIColor colorWithRed:r green:g blue:b alpha:1];
    self.view.backgroundColor = bgColor;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView.contentSize = kScrollViewContentSize;
    _scrollView.ts_height = self.view.ts_height*0.8;
    [self.view addSubview:_scrollView];
    
    r = arc4random()%255/255.0f;
    g = arc4random()%255/255.0f;
    b = arc4random()%255/255.0f;
    bgColor = [UIColor colorWithRed:r green:g blue:b alpha:1];
    _scrollView.backgroundColor = bgColor;
    
    CGRect textView1Frame = CGRectMake(0,
                                       kScrollViewContentSizeEdge-3*kTextViewHeight,
                                       kTextViewWidth,
                                       kTextViewHeight);
    AJXKBTextView *textView1 = [[AJXKBTextView alloc] initWithFrame:textView1Frame];
    textView1.layer.borderColor = [UIColor blackColor].CGColor;
    textView1.layer.borderWidth = 1.0f;
    textView1.text = @"2018世界杯1111111";
    [_scrollView addSubview:textView1];
    
    CGRect textView2Frame = CGRectMake(0,
                                       kScrollViewContentSizeEdge-kTextViewHeight,
                                       kTextViewWidth,
                                       kTextViewHeight);
    AJXKBTextView *textView2 = [[AJXKBTextView alloc] initWithFrame:textView2Frame];
    textView2.layer.borderColor = [UIColor blackColor].CGColor;
    textView2.layer.borderWidth = 1.0f;
    textView2.text = @"2018世界杯22222222";
    [_scrollView addSubview:textView2];
}

- (void)finish
{
    [self.view endEditing:YES];
}

@end
