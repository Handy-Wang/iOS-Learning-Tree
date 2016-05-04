//
//  AUITextView.m
//  AUI
//
//  Created by Handy on 5/3/16.
//  Copyright © 2016 Handy. All rights reserved.
//

#import "AUITextView.h"

@interface AUITextView () <UITextViewDelegate>

@property (nonatomic, assign) UIEdgeInsets realTextContainerInset;
@property (nonatomic, assign) BOOL needScrollToBottom;

@end

@implementation AUITextView

#pragma mark - Lifecycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textContainerInset = UIEdgeInsetsZero;
        self.textContainer.lineFragmentPadding = 0;
        _realTextContainerInset = super.textContainerInset;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(auiTextViewDidChange:) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}

#pragma mark - ############### Public methods ###############
#pragma mark - Override methods - textContainerInset
- (void)setTextContainerInset:(UIEdgeInsets)textContainerInset {
    _realTextContainerInset = textContainerInset;
    [self layoutTextAlignment];
}

#pragma mark - Override methods - text

- (void)setText:(NSString *)text {
    [super setText:text];
    [self layoutTextAlignment];
}

#pragma mark - Override methods - text alignment

- (NSTextAlignment)textAlignment
{
    return (NSTextAlignment)_text9PointAlignment;;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment
{
    if (textAlignment == NSTextAlignmentCenter) {
        [self setText9PointAlignment:AUITextAlignmentCenterTop];
        
    } else if (textAlignment == NSTextAlignmentRight) {
        [self setText9PointAlignment:AUITextAlignmentRightTop];
        
    } else {
        [self setText9PointAlignment:AUITextAlignmentLeftTop];
    }
}

- (void)setText9PointAlignment:(AUITextAlignment)text9PointAlignment
{
    if (text9PointAlignment == AUITextAlignmentLeftTop ||
        text9PointAlignment == AUITextAlignmentLeftCenter ||
        text9PointAlignment == AUITextAlignmentLeftBottom ||
        text9PointAlignment == AUITextAlignmentCenterTop ||
        text9PointAlignment == AUITextAlignmentCenter ||
        text9PointAlignment == AUITextAlignmentCenterBottom ||
        text9PointAlignment == AUITextAlignmentRightTop ||
        text9PointAlignment == AUITextAlignmentRightCenter ||
        text9PointAlignment == AUITextAlignmentRightBottom) {
        _text9PointAlignment = text9PointAlignment;
        
    } else {
        _text9PointAlignment = AUITextAlignmentLeftTop;
    }
    
    self.needScrollToBottom = (_text9PointAlignment == AUITextAlignmentLeftBottom || _text9PointAlignment == AUITextAlignmentCenterBottom || _text9PointAlignment == AUITextAlignmentRightBottom);
    
    [self layoutTextAlignment];
}

#pragma mark - Override methods - frame

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self layoutTextAlignment];
}

#pragma mark - Private methods

- (void)auiTextViewDidChange:(UITextView *)textView
{
    [self layoutTextAlignment];
}

- (void)layoutTextAlignment {
    [self layoutVerticalTextAlignment];
    [self layoutHorizontalTextAlignment];
    [self scrollToBottomIfNeeded];
}

- (void)layoutHorizontalTextAlignment
{
    if (_text9PointAlignment == AUITextAlignmentCenterTop ||
        _text9PointAlignment == AUITextAlignmentCenter ||
        _text9PointAlignment == AUITextAlignmentCenterBottom) {
        [super setTextAlignment:NSTextAlignmentCenter];
        
    } else if (_text9PointAlignment == AUITextAlignmentRightTop ||
               _text9PointAlignment == AUITextAlignmentRightCenter ||
               _text9PointAlignment == AUITextAlignmentRightBottom) {
        [super setTextAlignment:NSTextAlignmentRight];
        
    } else {
        [super setTextAlignment:NSTextAlignmentLeft];
    }
}

- (void)layoutVerticalTextAlignment
{
    (void) [self.layoutManager glyphRangeForTextContainer:self.textContainer];
    CGSize textUsedSizeInTextContainer = [self.layoutManager usedRectForTextContainer:self.textContainer].size;
    
    CGFloat insetTop = 0;
    CGFloat insetBottom = 0;
    
    if (_text9PointAlignment == AUITextAlignmentLeftCenter ||
        _text9PointAlignment == AUITextAlignmentCenter ||
        _text9PointAlignment == AUITextAlignmentRightCenter) {
        insetTop = (self.frame.size.height - textUsedSizeInTextContainer.height) / 2.0f;
        insetBottom = insetTop;
        
    } else if (_text9PointAlignment == AUITextAlignmentLeftBottom ||
               _text9PointAlignment == AUITextAlignmentCenterBottom ||
               _text9PointAlignment == AUITextAlignmentRightBottom) {
        insetTop = self.frame.size.height - textUsedSizeInTextContainer.height;
        insetBottom = 0;;
        
    } else {
        insetTop = 0;
        insetBottom = 0;
    }
    
    insetTop = insetTop <= 0 ? 0 : insetTop;
    insetBottom = insetBottom <= 0 ? 0 : insetBottom;
    
    super.textContainerInset = UIEdgeInsetsMake(_realTextContainerInset.top + insetTop,
                                               _realTextContainerInset.left,
                                               _realTextContainerInset.bottom + insetBottom,
                                               _realTextContainerInset.right);
}

- (void)scrollToBottomIfNeeded {
    if(self.needScrollToBottom && self.text.length > 0 ) {
        self.needScrollToBottom = NO;
        [self scrollRectToVisible:CGRectMake(0, self.contentSize.height-1, self.frame.size.width, 1) animated:NO];
    }
}

@end
