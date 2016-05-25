//
//  BSTextView.m
//  UI
//
//  Created by Handy on 5/3/16.
//  Copyright © 2016 Handy. All rights reserved.
//

#import "BSTextView.h"

@interface BSTextView () <UITextViewDelegate>

@property (nonatomic, assign) UIEdgeInsets realTextContainerInset;
@property (nonatomic, assign) BOOL needScrollToBottom;
@property (nonatomic, strong) NSMutableParagraphStyle *textParagraphStyle;

@end

@implementation BSTextView

@synthesize linespacing = _linespacing;

#pragma mark - Lifecycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textContainerInset = UIEdgeInsetsZero;
        self.textContainer.lineFragmentPadding = 0;
        _realTextContainerInset = super.textContainerInset;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bsTextViewDidChange:) name:UITextViewTextDidChangeNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}

#pragma mark - ############### Public methods ###############

- (void)setLinespacing:(CGFloat)linespacing {
    [self createLinespacingStyleIfNeeded];
    _linespacing = linespacing;
    _textParagraphStyle.lineSpacing = _linespacing;
    [self applyTextLinespacingIfNeeded:self.attributedText];
    
    [self layoutTextAlignment];
}

- (CGFloat)linespacing {
    return _textParagraphStyle.lineSpacing;
}

#pragma mark - Override methods - textContainerInset

- (void)setTextContainerInset:(UIEdgeInsets)textContainerInset {
    _realTextContainerInset = textContainerInset;
    
    [self layoutTextAlignment];
}

#pragma mark - Override methods - text

- (void)setAttributedText:(NSAttributedString *)attrText {
    NSDictionary *attr = [attrText attributesAtIndex:0 effectiveRange:NULL];
    NSParagraphStyle *paragraphStyle = attr[NSParagraphStyleAttributeName];
    _textParagraphStyle = [paragraphStyle mutableCopy];
    [self applyTextLinespacingIfNeeded:attrText];
    
    [self layoutTextAlignment];
}

- (void)setText:(NSString *)text {
    //重置_textParagraphStyle，为了防止先设置attrText再设置text时，attrText中的样式对text的影响
    _textParagraphStyle = nil;
    [self createLinespacingStyleIfNeeded];
    _textParagraphStyle.lineSpacing = _linespacing;
    
    NSAttributedString *attrText = [[NSAttributedString alloc] initWithString:text];
    [self applyTextLinespacingIfNeeded:attrText];
    
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
        [self setText9PointAlignment:BSTextAlignmentCenterTop];
        
    } else if (textAlignment == NSTextAlignmentRight) {
        [self setText9PointAlignment:BSTextAlignmentRightTop];
        
    } else {
        [self setText9PointAlignment:BSTextAlignmentLeftTop];
    }
}

- (void)setText9PointAlignment:(BSTextAlignment)text9PointAlignment
{
    if (text9PointAlignment == BSTextAlignmentLeftTop ||
        text9PointAlignment == BSTextAlignmentLeftCenter ||
        text9PointAlignment == BSTextAlignmentLeftBottom ||
        text9PointAlignment == BSTextAlignmentCenterTop ||
        text9PointAlignment == BSTextAlignmentCenter ||
        text9PointAlignment == BSTextAlignmentCenterBottom ||
        text9PointAlignment == BSTextAlignmentRightTop ||
        text9PointAlignment == BSTextAlignmentRightCenter ||
        text9PointAlignment == BSTextAlignmentRightBottom) {
        _text9PointAlignment = text9PointAlignment;
        
    } else {
        _text9PointAlignment = BSTextAlignmentLeftTop;
    }
    
    self.needScrollToBottom = (_text9PointAlignment == BSTextAlignmentLeftBottom || _text9PointAlignment == BSTextAlignmentCenterBottom || _text9PointAlignment == BSTextAlignmentRightBottom);
    
    [self layoutTextAlignment];
}

#pragma mark - Override methods - frame

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self layoutTextAlignment];
}

#pragma mark - ############### Private methods ###############

- (void)bsTextViewDidChange:(UITextView *)textView
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
    if (_text9PointAlignment == BSTextAlignmentCenterTop ||
        _text9PointAlignment == BSTextAlignmentCenter ||
        _text9PointAlignment == BSTextAlignmentCenterBottom) {
        [super setTextAlignment:NSTextAlignmentCenter];
        
    } else if (_text9PointAlignment == BSTextAlignmentRightTop ||
               _text9PointAlignment == BSTextAlignmentRightCenter ||
               _text9PointAlignment == BSTextAlignmentRightBottom) {
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
    
    if (_text9PointAlignment == BSTextAlignmentLeftCenter ||
        _text9PointAlignment == BSTextAlignmentCenter ||
        _text9PointAlignment == BSTextAlignmentRightCenter) {
        insetTop = (self.frame.size.height - textUsedSizeInTextContainer.height) / 2.0f;
        insetBottom = insetTop;
        
    } else if (_text9PointAlignment == BSTextAlignmentLeftBottom ||
               _text9PointAlignment == BSTextAlignmentCenterBottom ||
               _text9PointAlignment == BSTextAlignmentRightBottom) {
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

- (void)applyTextLinespacingIfNeeded:(NSAttributedString *)attrText {
    NSMutableAttributedString *mAttrText = [attrText mutableCopy];
    if (mAttrText.length > 0 && _textParagraphStyle) {
        [mAttrText addAttribute:NSParagraphStyleAttributeName value:_textParagraphStyle range:NSMakeRange(0, mAttrText.length)];
    }
    
    super.attributedText = mAttrText;
}

#pragma mark - ############### Getter & Setter methods ###############

- (void)createLinespacingStyleIfNeeded {
    if (!_textParagraphStyle) {
        _textParagraphStyle = [[NSMutableParagraphStyle alloc] init];
        _textParagraphStyle.maximumLineHeight = self.font.lineHeight;
        _textParagraphStyle.minimumLineHeight = self.font.lineHeight;
        _textParagraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
//    paragraphStyleForRender.alignment = NSTextAlignmentLeft;
//    NSMutableDictionary *attrsForRender = [newAttrs mutableCopy];
//        NSMutableDictionary *attrsForRender = [NSMutableDictionary dictionary];
//        attrsForRender[NSParagraphStyleAttributeName] = ps;
//        NSAttributedString *attrStrForRender = [[NSAttributedString alloc] initWithString:text attributes:attrsForRender];
    }
}

@end