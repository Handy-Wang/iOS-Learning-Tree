//
//  AUITextAlignment.h
//  AUI
//
//  Created by Handy on 5/4/16.
//  Copyright © 2016 Handy. All rights reserved.
//

#ifndef AUITextAlignment_h
#define AUITextAlignment_h

/**
 *  horizontal text alignment & vertical text alignment.
 *  eg, AUITextAlignmentLeftTop means left alignment in horizaontal orientation and top alignment in vertical orientation.
 */
typedef NS_ENUM(NSInteger, AUITextAlignment) {
    AUITextAlignmentLeftTop         = 0,
    AUITextAlignmentLeftCenter      = 1,
    AUITextAlignmentLeftBottom      = 2,
    AUITextAlignmentCenterTop       = 3,
    AUITextAlignmentCenter          = 4,
    AUITextAlignmentCenterBottom    = 5,
    AUITextAlignmentRightTop        = 6,
    AUITextAlignmentRightCenter     = 7,
    AUITextAlignmentRightBottom     = 8
};

#endif /* AUITextAlignment_h */
