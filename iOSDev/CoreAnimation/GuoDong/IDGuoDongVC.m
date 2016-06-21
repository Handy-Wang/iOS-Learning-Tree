//
//  IDGuoDongVC.m
//  iOSDev
//
//  Created by Handy on 6/16/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "IDGuoDongVC.h"

#define kAnimationViewWidth             (80)
#define kAnimationViewHeight            (100)

#define kActionBtnTop                   (64.0f)
#define kActionBtnSize                  (80.0f)

@interface IDGuoDongVC ()
@property (nonatomic, strong) UIButton *changeTransformBtn;
@property (nonatomic, strong) UIButton *changeFrameBtn;
@property (nonatomic, strong) UIView *animationView;
@end

@implementation IDGuoDongVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self changeTransformBtn];
    [self changeFrameBtn];
    [self animationView];
}

- (UIButton *)changeTransformBtn {
    if (!_changeTransformBtn) {
        CGRect frame = CGRectMake(0, kActionBtnTop, kActionBtnSize, kActionBtnSize);
        _changeTransformBtn = [[UIButton alloc] initWithFrame:frame];
        [_changeTransformBtn setBackgroundColor:[UIColor blackColor]];
        [_changeTransformBtn setTitle:@"transform" forState:UIControlStateNormal];
        [_changeTransformBtn addTarget:self action:@selector(changeTransform) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_changeTransformBtn];
    }
    
    return _changeTransformBtn;
}

- (void)changeTransform {
    [UIView animateWithDuration:0.3 animations:^{
        _animationView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 2, 3);
    }];
}

- (UIButton *)changeFrameBtn {
    if (!_changeFrameBtn) {
        CGRect frame = CGRectMake(kActionBtnSize, kActionBtnTop, kActionBtnSize, kActionBtnSize);
        _changeFrameBtn = [[UIButton alloc] initWithFrame:frame];
        [_changeFrameBtn setBackgroundColor:[UIColor blackColor]];
        [_changeFrameBtn setTitle:@"frame" forState:UIControlStateNormal];
        [_changeFrameBtn addTarget:self action:@selector(changeFrame) forControlEvents:UIControlEventTouchUpInside];
        _changeFrameBtn.ts_right = self.view.ts_width;
        [self.view addSubview:_changeFrameBtn];
    }
    
    return _changeFrameBtn;
}

- (void)changeFrame {
    [UIView animateWithDuration:0.3 animations:^{
        _animationView.transform = CGAffineTransformIdentity;
        _animationView.ts_width = kAnimationViewWidth;
        _animationView.ts_height = kAnimationViewHeight;
        _animationView.ts_centerX = self.view.ts_centerX;
        _animationView.ts_top = _changeTransformBtn.ts_bottom + 100;
        _animationView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 2, 3);
    }];
}

- (UIView *)animationView {
    if (!_animationView) {
        _animationView = [[UIView alloc] initWithFrame:CGRectZero];
        _animationView.ts_width = kAnimationViewWidth;
        _animationView.ts_height = kAnimationViewHeight;
        _animationView.ts_centerX = self.view.ts_centerX;
        _animationView.ts_top = _changeTransformBtn.ts_bottom + 100;
        _animationView.backgroundColor = [UIColor blackColor];
        [self.view addSubview:_animationView];
    }
    
    return _animationView;
}

@end