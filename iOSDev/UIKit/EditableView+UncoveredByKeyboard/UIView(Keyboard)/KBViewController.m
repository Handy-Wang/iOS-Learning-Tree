//
//  KBViewController.m
//  iOSDev
//
//  Created by Handy on 11/23/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "KBViewController.h"
#import "AJXKBTextView.h"
#import "AJXKBTextField.h"

#define kTextViewHeight            (50)

@interface KBViewController ()

@property (nonatomic, strong) UIView *container1;
@property (nonatomic, strong) AJXKBTextView *textView1;
@property (nonatomic, strong) AJXKBTextView *textView2;
@property (nonatomic, strong) AJXKBTextField *textField1;
@property (nonatomic, strong) AJXKBTextField *textField2;

@property (nonatomic, strong) UIView *container2;
@property (nonatomic, strong) AJXKBTextView *textView3;
@property (nonatomic, strong) AJXKBTextView *textView4;
@property (nonatomic, strong) AJXKBTextField *textField3;
@property (nonatomic, strong) AJXKBTextField *textField4;

@end

@implementation KBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(finish)];
    [self.view addGestureRecognizer:tapGesture];
    
    _container1 = [[UIView alloc] initWithFrame:self.view.bounds];
    _container1.ts_width = self.view.ts_width*0.5;
    
    CGRect textViewFrame1 = CGRectMake(0, 100, _container1.ts_width, kTextViewHeight);
    _textView1 = [[AJXKBTextView alloc] initWithFrame:textViewFrame1];
    _textView1.text = @"2018世界杯111111 UITextView";
    _textView1.layer.borderColor = [UIColor blackColor].CGColor;
    _textView1.layer.borderWidth = 1;
    [_container1 addSubview:_textView1];
    
    CGRect textViewFrame2 = CGRectMake(0, self.view.ts_height-kTextViewHeight-44, _container1.ts_width, kTextViewHeight);
    _textView2 = [[AJXKBTextView alloc] initWithFrame:textViewFrame2];
    _textView2.text = @"2018世界杯222222 UITextView";
    _textView2.layer.borderColor = [UIColor blackColor].CGColor;
    _textView2.layer.borderWidth = 1;
    [_container1 addSubview:_textView2];
    
    CGRect textFieldFrame1 = CGRectMake(0, 0, _container1.ts_width, kTextViewHeight);
    _textField1 = [[AJXKBTextField alloc] initWithFrame:textFieldFrame1];
    _textField1.ts_top = _textView1.ts_bottom + 5;
    _textField1.text = @"UITextField2018世界杯111111";
    _textField1.layer.borderColor = [UIColor blackColor].CGColor;
    _textField1.layer.borderWidth = 1;
    [_container1 addSubview:_textField1];
    
    CGRect textFieldFrame2 = CGRectMake(0, 0, _container1.ts_width, kTextViewHeight);
    _textField2 = [[AJXKBTextField alloc] initWithFrame:textFieldFrame2];
    _textField2.ts_bottom = _textView2.ts_top - 5;
    _textField2.text = @"UITextField2018世界杯222222";
    _textField2.layer.borderColor = [UIColor blackColor].CGColor;
    _textField2.layer.borderWidth = 1;
    [_container1 addSubview:_textField2];
    
    //-----------------------------------------------
    
    _container2 = [[UIView alloc] initWithFrame:self.view.bounds];
    _container2.ts_width = self.view.ts_width*0.5;
    _container2.ts_left = _container1.ts_right;
    
    CGRect textViewFrame3 = CGRectMake(0, 100, _container1.ts_width, kTextViewHeight);
    _textView3 = [[AJXKBTextView alloc] initWithFrame:textViewFrame3];
    _textView3.text = @"2018世界杯3333333 UITextView";
    _textView3.layer.borderColor = [UIColor blackColor].CGColor;
    _textView3.layer.borderWidth = 1;
    [_container2 addSubview:_textView3];
    
    
    CGRect textViewFrame4 = CGRectMake(0, self.view.ts_height-kTextViewHeight-44, _container1.ts_width, kTextViewHeight);
    _textView4 = [[AJXKBTextView alloc] initWithFrame:textViewFrame4];
    _textView4.text = @"2018世界杯44444444 UITextView";
    _textView4.layer.borderColor = [UIColor blackColor].CGColor;
    _textView4.layer.borderWidth = 1;
    [_container2 addSubview:_textView4];
    
    CGRect textFieldFrame3 = CGRectMake(0, 0, _container1.ts_width, kTextViewHeight);
    _textField3 = [[AJXKBTextField alloc] initWithFrame:textFieldFrame3];
    _textField3.ts_top = _textView3.ts_bottom + 5;
    _textField3.text = @"UITextField2018世界杯33333333";
    _textField3.layer.borderColor = [UIColor blackColor].CGColor;
    _textField3.layer.borderWidth = 1;
    [_container2 addSubview:_textField3];
    
    CGRect textFieldFrame4 = CGRectMake(0, 0, _container1.ts_width, kTextViewHeight);
    _textField4 = [[AJXKBTextField alloc] initWithFrame:textFieldFrame4];
    _textField4.ts_bottom = _textView4.ts_top - 5;
    _textField4.text = @"UITextField2018世界杯44444444";
    _textField4.layer.borderColor = [UIColor blackColor].CGColor;
    _textField4.layer.borderWidth = 1;
    [_container2 addSubview:_textField4];
    
    //-------------------------------------------------
    
    [self.view addSubview:_container1];
    [self.view addSubview:_container2];
}

- (void)finish
{
    [self.view endEditing:YES];
}

@end
