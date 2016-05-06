//
//  BSTextField.m
//  UI
//
//  Created by Handy on 5/4/16.
//  Copyright © 2016 Handy. All rights reserved.
//

#import "BSTextField.h"

@implementation BSTextField

#pragma mark - ############### Public methods ###############

#pragma mark - Override methods - text

- (void)setText:(NSString *)text {
    [super setText:text];
    [self layoutTextAlignment];
}

#pragma mark - Override methods - text alignment

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
    if (_text9PointAlignment == BSTextAlignmentLeftCenter ||
        _text9PointAlignment == BSTextAlignmentCenter ||
        _text9PointAlignment == BSTextAlignmentRightCenter) {
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        
    } else if (_text9PointAlignment == BSTextAlignmentLeftBottom ||
               _text9PointAlignment == BSTextAlignmentCenterBottom ||
               _text9PointAlignment == BSTextAlignmentRightBottom) {
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
        
    } else {
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    }
}

@end