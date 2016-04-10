//
//  UIView(TS_FrontView).h
//  BBT
//
//  Created by XiaoShan on 12/1/15.
//  Copyright © 2015 Higegou. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TSFrontViewTag) {
    TSFrontViewTag_TableView = 100010,
    TSFrontViewTag_EmptyView,
    TSFrontViewTag_LoadingView
};

@interface UIView(TS_FrontView)

- (void)ts_bringFullScreenSubviewToFront:(TSFrontViewTag)tag;

@end