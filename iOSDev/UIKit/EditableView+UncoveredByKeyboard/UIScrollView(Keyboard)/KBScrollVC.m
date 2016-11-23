//
//  KBScrollVC.m
//  iOSDev
//
//  Created by Handy on 11/23/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "KBScrollVC.h"
#import "KBScrollView.h"

@interface KBScrollVC ()
@property (nonatomic, strong) KBScrollView *scrollView1;
@property (nonatomic, strong) KBScrollView *scrollView2;
@end

@implementation KBScrollVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor grayColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(finish)];
    [self.view addGestureRecognizer:tapGesture];
    
    _scrollView1 = [[KBScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView1.contentSize = kScrollViewContentSize;
    _scrollView1.ts_top = 64.0f;
    _scrollView1.ts_height = self.view.ts_height*0.8;
    _scrollView1.ts_width = self.view.ts_width*0.5;
    [self.view addSubview:_scrollView1];
    
    _scrollView2 = [[KBScrollView alloc] initWithFrame:self.view.bounds];
    _scrollView2.contentSize = kScrollViewContentSize;
    _scrollView2.ts_top = 64.0f;
    _scrollView2.ts_left = _scrollView1.ts_right;
    _scrollView2.ts_height = self.view.ts_height*0.8;
    _scrollView2.ts_width = self.view.ts_width*0.5;
    [self.view addSubview:_scrollView2];
}

- (void)finish
{
    [self.view endEditing:YES];
}

@end
