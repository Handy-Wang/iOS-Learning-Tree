//
//  KBTableCell.m
//  iOSDev
//
//  Created by Handy on 11/8/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "KBTableCell.h"
#import "AJXKBTextView.h"
#import "AJXKBTextField.h"

@interface KBTableCell()
@property (nonatomic, strong) AJXKBTextView *textView;
@property (nonatomic, strong) AJXKBTextField *textField;
@end

@implementation KBTableCell

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_textView removeFromSuperview];
    _textView = nil;
    
    [_textField removeFromSuperview];
    _textField = nil;
    
    if (self.isContainTetxtView) {
        [self textView];
    } else {
        [self textField];
    }
}

- (UITextView *)textView
{
    if (!_textView) {
        _textView = [[AJXKBTextView alloc] initWithFrame:self.bounds];
        _textView.text = @"2018世界杯TextView";
        _textView.layer.borderColor = [UIColor blackColor].CGColor;
        _textView.layer.borderWidth = 1;
        _textView.backgroundColor = [UIColor clearColor];
        [self addSubview:_textView];
    }
    
    return _textView;
}

- (UITextField *)textField
{
    if (!_textField) {
        _textField = [[AJXKBTextField alloc] initWithFrame:self.bounds];
        _textField.text = @"2018世界杯TextField";
        _textField.layer.borderColor = [UIColor blackColor].CGColor;
        _textField.layer.borderWidth = 1;
        [self addSubview:_textField];
    }
    
    return _textField;
}

@end
