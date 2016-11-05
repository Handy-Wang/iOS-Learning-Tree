//
//  IDUITextFieldVC.m
//  iOSDev
//
//  Created by Handy on 10/24/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "IDUITextFieldVC.h"
#import "IDTextField.h"
#import "NSStringUtils.h"

@interface IDUITextFieldVC (){
    IDTextField *_textField1;
    IDTextField *_textField2;
    IDTextField *_customizedTextField;
}
@end

@implementation IDUITextFieldVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets=NO;
    CGRect selfViewFrame = self.view.frame;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
    [self.view addGestureRecognizer:tap];
    
    CGFloat top = 200;
    
    CGRect customizedTextFieldFrame = CGRectMake(0, top, selfViewFrame.size.width, 0);
    _customizedTextField = [[IDTextField alloc] initWithFrame:customizedTextFieldFrame];
    UIFont *textFont = _customizedTextField.font; //[UIFont systemFontOfSize:23];
    NSString *text = @"大家好，welcome to my world. jjjjj我们ggggg";
    _customizedTextField.placeholder = @"请输入城市名称或拼音";
    _customizedTextField.font = textFont;
    _customizedTextField.text = text;
    _customizedTextField.textSize = [self calcTextSize:_customizedTextField.text andFont:textFont];
    _customizedTextField.frame = CGRectMake(0, top, selfViewFrame.size.width, _customizedTextField.textSize.height);
    _customizedTextField.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    [_customizedTextField addTarget:self
                             action:@selector(onTextChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:_customizedTextField];
    
    CGRect textRectLabelFrame = CGRectMake(0,top,
                                           selfViewFrame.size.width,
                                           _customizedTextField.textSize.height);
    UILabel *textRectLabel = [[UILabel alloc] initWithFrame:textRectLabelFrame];
    textRectLabel.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.1];
    [self.view insertSubview:textRectLabel atIndex:0];
    

//    CGRect textFieldFrame1 = CGRectMake(0, top, selfViewFrame.size.width/2.0f, height);
//    UIView *textField1Container = [[UIView alloc] initWithFrame:textFieldFrame1];
//    textField1Container.layer.borderColor = [UIColor blackColor].CGColor;
//    textField1Container.layer.borderWidth = 1;
//    textField1Container.layer.cornerRadius = 3;
//    textField1Container.clipsToBounds = YES;
//    textField1Container.backgroundColor = [UIColor lightGrayColor];
//    
//    _textField1 = [[IDTextField alloc] initWithFrame:textField1Container.bounds];
////    _textField1.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
////    _textField1.textAlignment = NSTextAlignmentCenter;
//    _textField1.font = [UIFont systemFontOfSize:14.0f];
//    _textField1.backgroundColor = [UIColor clearColor];
//    [_textField1 addTarget:self action:@selector(onTextChanged:) forControlEvents:UIControlEventEditingChanged];
//    [textField1Container addSubview:_textField1];
//    [self.view addSubview:textField1Container];
//    
//    CGRect textFieldFrame2 = CGRectMake(selfViewFrame.size.width/2.0f, top, selfViewFrame.size.width/2.0f, height);
//    _textField2 = [[IDTextField alloc] initWithFrame:textFieldFrame2];
////    _textField2.clipsToBounds = YES;
////    _textField2.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//    _textField2.textAlignment = NSTextAlignmentCenter;
//    _textField2.font = [UIFont systemFontOfSize:14.0f];
////    _textField2.layer.cornerRadius = 3;
//    _textField2.backgroundColor = [UIColor lightGrayColor];
//    _textField2.layer.borderColor = [UIColor blackColor].CGColor;
//    _textField2.layer.borderWidth = 1;
//    [self.view addSubview:_textField2];
//    
//    CGRect resignBtnFrame = CGRectMake(0, textFieldFrame1.origin.y+textFieldFrame1.size.height,
//                                       100, 44);
//    UIButton *resignBtn = [[UIButton alloc] initWithFrame:resignBtnFrame];
//    [resignBtn setTitle:@"Resign" forState:UIControlStateNormal];
//    [resignBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [resignBtn addTarget:self action:@selector(resign) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:resignBtn];
}

- (void)didTap:(UITapGestureRecognizer *)tapGesture {
    [_customizedTextField resignFirstResponder];
}

- (void)onTextChanged:(IDTextField *)textField
{
//    NSString *text = [textField text];
//    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:text];
//    CGSize textSize = [NSStringUtils textSizeWithAttributeString:attrText
//                                                         maxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX) line:1 font:nil];
//    textField.textSize = textSize;
}

- (CGSize)calcTextSize:(NSString *)text andFont:(UIFont *)textFont
{
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect textBounds = [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
                                           options:options
                                        attributes:@{NSFontAttributeName:_customizedTextField.font} context:NULL];
    textBounds = CGRectIntegral(textBounds);
    return textBounds.size;
    
//    NSAttributedString *attrString = [[NSAttributedString alloc]
//                                      initWithString:text attributes:@{NSFontAttributeName:textFont}];
//    CGSize textSize = [NSStringUtils textSizeWithAttributeString:attrString
//                                                         maxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
//                                                            line:1
//                                                            font:textFont];
//    return textSize;
}

- (void)resign
{
    [_textField1 resignFirstResponder];
    [_textField2 resignFirstResponder];
}

@end
