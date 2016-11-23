//
//  KBTableCell.m
//  iOSDev
//
//  Created by Handy on 11/8/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "KBTableCell.h"
#import "KBTableCellTextView.h"

@interface KBTableCell()
@property (nonatomic, strong) KBTableCellTextView *textView;
@end

@implementation KBTableCell

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
        _textView = [[KBTableCellTextView alloc] initWithFrame:self.bounds];
        _textView.text = @"2018世界杯";
        _textView.layer.borderColor = [UIColor blackColor].CGColor;
        _textView.layer.borderWidth = 1;
        [self addSubview:_textView];
    }
    
    return _textView;
}

@end
