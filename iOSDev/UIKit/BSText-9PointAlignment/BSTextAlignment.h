//
//  BSTextAlignment.h
//  UI
//
//  Created by Handy on 5/4/16.
//  Copyright © 2016 Handy. All rights reserved.
//

#ifndef BSTextAlignment_h
#define BSTextAlignment_h

/**
 *  horizontal text alignment & vertical text alignment.
 *  eg, BSTextAlignmentLeftTop means left alignment in horizaontal orientation and top alignment in vertical orientation.
 */
typedef NS_ENUM(NSInteger, BSTextAlignment) {
    BSTextAlignmentLeftTop          = 0,
    BSTextAlignmentLeftCenter       = 1,
    BSTextAlignmentLeftBottom       = 2,
    BSTextAlignmentCenterTop        = 3,
    BSTextAlignmentCenter           = 4,
    BSTextAlignmentCenterBottom     = 5,
    BSTextAlignmentRightTop         = 6,
    BSTextAlignmentRightCenter      = 7,
    BSTextAlignmentRightBottom      = 8
};

#endif /* BSTextAlignment_h */
