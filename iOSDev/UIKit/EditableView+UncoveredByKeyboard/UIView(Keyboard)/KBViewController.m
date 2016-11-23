//
//  KBViewController.m
//  iOSDev
//
//  Created by Handy on 11/23/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "KBViewController.h"
#import "AJXKBTextView.h"

#define kTextViewHeight            (100)

@interface KBViewController ()

@property (nonatomic, strong) AJXKBTextView *textView;

@end

@implementation KBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(finish)];
    [self.view addGestureRecognizer:tapGesture];
    
    CGRect textViewFrame = CGRectMake(0, self.view.ts_height-kTextViewHeight, self.view.ts_width, kTextViewHeight);
    _textView = [[AJXKBTextView alloc] initWithFrame:textViewFrame];
    _textView.text = @"2018世界杯";
    _textView.layer.borderColor = [UIColor blackColor].CGColor;
    _textView.layer.borderWidth = 1;
    [self.view addSubview:_textView];
}

- (void)finish
{
    [self.view endEditing:YES];
}

@end
