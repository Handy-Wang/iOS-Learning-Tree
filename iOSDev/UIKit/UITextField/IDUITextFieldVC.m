//
//  IDUITextFieldVC.m
//  iOSDev
//
//  Created by Handy on 10/24/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "IDUITextFieldVC.h"
#import "IDTextField.h"

@interface IDUITextFieldVC (){
    IDTextField *_textField1;
    IDTextField *_textField2;
}
@end

@implementation IDUITextFieldVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect selfViewFrame = self.view.frame;
    CGFloat top = 64;
    CGFloat height = 40;
    
    self.automaticallyAdjustsScrollViewInsets=NO;

    CGRect textFieldFrame1 = CGRectMake(0, top, selfViewFrame.size.width/2.0f, height);
    UIView *textField1Container = [[UIView alloc] initWithFrame:textFieldFrame1];
    textField1Container.layer.borderColor = [UIColor blackColor].CGColor;
    textField1Container.layer.borderWidth = 1;
    textField1Container.layer.cornerRadius = 3;
    textField1Container.clipsToBounds = YES;
    textField1Container.backgroundColor = [UIColor lightGrayColor];
    
    _textField1 = [[IDTextField alloc] initWithFrame:textField1Container.bounds];
//    _textField1.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//    _textField1.textAlignment = NSTextAlignmentCenter;
    _textField1.font = [UIFont systemFontOfSize:14.0f];
    _textField1.backgroundColor = [UIColor clearColor];
    [_textField1 addTarget:self action:@selector(onTextChanged:) forControlEvents:UIControlEventEditingChanged];
    [textField1Container addSubview:_textField1];
    [self.view addSubview:textField1Container];
    
    CGRect textFieldFrame2 = CGRectMake(selfViewFrame.size.width/2.0f, top, selfViewFrame.size.width/2.0f, height);
    _textField2 = [[IDTextField alloc] initWithFrame:textFieldFrame2];
//    _textField2.clipsToBounds = YES;
//    _textField2.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    _textField2.textAlignment = NSTextAlignmentCenter;
    _textField2.font = [UIFont systemFontOfSize:14.0f];
//    _textField2.layer.cornerRadius = 3;
    _textField2.backgroundColor = [UIColor lightGrayColor];
    _textField2.layer.borderColor = [UIColor blackColor].CGColor;
    _textField2.layer.borderWidth = 1;
    [self.view addSubview:_textField2];
    
    CGRect resignBtnFrame = CGRectMake(0, textFieldFrame1.origin.y+textFieldFrame1.size.height,
                                       100, 44);
    UIButton *resignBtn = [[UIButton alloc] initWithFrame:resignBtnFrame];
    [resignBtn setTitle:@"Resign" forState:UIControlStateNormal];
    [resignBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [resignBtn addTarget:self action:@selector(resign) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resignBtn];
}

- (void)onTextChanged:(UITextField *)textField
{
//    [UIView animateWithDuration:0.1 animations:^{
//        [textField invalidateIntrinsicContentSize];
//    }];
}

- (void)resign
{
    [_textField1 resignFirstResponder];
    [_textField2 resignFirstResponder];
}

@end
