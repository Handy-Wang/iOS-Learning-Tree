//
//  IDSelectCell.m
//  iOSDev
//
//  Created by Handy on 11/8/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "IDSelectCell.h"
#import "IDSelectCellTextView.h"

@interface IDSelectCell()
@property (nonatomic, strong) IDSelectCellTextView *textView;
@end

@implementation IDSelectCell

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.isContainTetxtView) {
        [self textView];
    } else {
        [_textView removeFromSuperview];
        _textView = nil;
    }
}

- (UITextView *)textView
{
    if (!_textView) {
        _textView = [[IDSelectCellTextView alloc] initWithFrame:self.bounds];
        _textView.text = @"2018世界杯";
        _textView.layer.borderColor = [UIColor blackColor].CGColor;
        _textView.layer.borderWidth = 1;
        [self addSubview:_textView];
    }
    
    return _textView;
}

@end
