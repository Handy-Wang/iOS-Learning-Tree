//
//  UIView(TS_Geometry).h
//  EHaiTao-Master
//
//  Created by neolix on 14-10-11.
//  Copyright (c) 2014年 北京启能万维科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kTSAppScreenWidth               [UIScreen mainScreen].bounds.size.width
#define kTSAppScreenHeight              [UIScreen mainScreen].bounds.size.height
#define kTSStatusBarHeight              (20.0f)
#define kTSNavigationBarHeight          (44.0f)

@interface UIView (TS_Geometry)

@property(nonatomic) CGFloat ts_left;
@property(nonatomic) CGFloat ts_top;
@property(nonatomic) CGFloat ts_right;
@property(nonatomic) CGFloat ts_bottom;

@property(nonatomic) CGFloat ts_width;
@property(nonatomic) CGFloat ts_height;

@property(nonatomic) CGFloat ts_centerX;
@property(nonatomic) CGFloat ts_centerY;

@property(nonatomic,readonly) CGFloat ts_screenX;
@property(nonatomic,readonly) CGFloat ts_screenY;
@property(nonatomic,readonly) CGFloat ts_screenViewX;
@property(nonatomic,readonly) CGFloat ts_screenViewY;
@property(nonatomic,readonly) CGRect ts_screenFrame;
@property(nonatomic) CGPoint ts_origin;
@property(nonatomic) CGSize ts_size;

@end
