//
//  AUITextField.m
//  AUI
//
//  Created by Handy on 5/4/16.
//  Copyright © 2016 Handy. All rights reserved.
//

#import "AUITextField.h"

@implementation AUITextField

#pragma mark - ############### Public methods ###############

#pragma mark - Override methods - text

- (void)setText:(NSString *)text {
    [super setText:text];
    [self layoutTextAlignment];
}

#pragma mark - Override methods - text alignment

- (NSTextAlignment)textAlignment
{
    return (NSTextAlignment)_text9PointAlignment;
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
    [self layoutTextAlignment];
}

#pragma mark - Override methods - frame

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self layoutTextAlignment];
}

#pragma mark - Private methods
- (void)layoutTextAlignment {
    [self layoutVerticalTextAlignment];
    [self layoutHorizontalTextAlignment];
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
    if (_text9PointAlignment == AUITextAlignmentLeftCenter ||
        _text9PointAlignment == AUITextAlignmentCenter ||
        _text9PointAlignment == AUITextAlignmentRightCenter) {
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
    } else if (_text9PointAlignment == AUITextAlignmentLeftBottom ||
               _text9PointAlignment == AUITextAlignmentCenterBottom ||
               _text9PointAlignment == AUITextAlignmentRightBottom) {
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
        
    } else {
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    }
}

@end