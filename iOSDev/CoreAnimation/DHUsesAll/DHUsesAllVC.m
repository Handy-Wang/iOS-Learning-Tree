//
//  DHUsesAllVC.m
//  iOSDev
//
//  Created by Handy on 6/21/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "DHUAView.h"
#import "DHUsesAllVC.h"

@interface DHUsesAllVC () {
    DHUAView *_v1;
    NSTimer *_printPresentationLayerTimer;
}
@end

@implementation DHUsesAllVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *aniBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    aniBtn1.frame = CGRectMake(self.view.ts_width - 44, 64, 44, 44);
    [aniBtn1 setTitle:@"GO1" forState:UIControlStateNormal];
    [aniBtn1.titleLabel setTextColor:[UIColor whiteColor]];
    [aniBtn1 setBackgroundColor:[UIColor blackColor]];
    [aniBtn1 addTarget:self action:@selector(doAnimtion1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:aniBtn1];
    
    UIButton *aniBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    aniBtn2.frame = CGRectMake(self.view.ts_width - 44, 64, 44, 44);
    aniBtn2.ts_top = aniBtn1.ts_bottom;
    [aniBtn2 setTitle:@"GO2" forState:UIControlStateNormal];
    [aniBtn2.titleLabel setTextColor:[UIColor whiteColor]];
    [aniBtn2 setBackgroundColor:[UIColor blackColor]];
    [aniBtn2 addTarget:self action:@selector(doAnimtion2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:aniBtn2];
    
    UIButton *aniBtn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    aniBtn3.frame = CGRectMake(self.view.ts_width - 44, 64, 44, 44);
    aniBtn3.ts_top = aniBtn2.ts_bottom;
    [aniBtn3 setTitle:@"GO3" forState:UIControlStateNormal];
    [aniBtn3.titleLabel setTextColor:[UIColor whiteColor]];
    [aniBtn3 setBackgroundColor:[UIColor blackColor]];
    [aniBtn3 addTarget:self action:@selector(doAnimtion3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:aniBtn3];
 
    _v1 = [[DHUAView alloc] initWithFrame:CGRectMake(0, 64, 44, 44)];
    _v1.backgroundColor = [UIColor redColor];
    [self.view addSubview:_v1];
    
//    [CATransaction begin];
//    [CATransaction setDisableActions:YES];//禁用layer对view询问actionForLayer
//    [UIView animateWithDuration:0.3 animations:^{
//        _v1.center = CGPointMake(200, 200);
//    }];
//    [CATransaction commit];
}

#pragma mark - 普通的UIView动态

- (void)doAnimtion1 {
//    [CATransaction begin];
    [UIView animateWithDuration:0.3 animations:^{
        _v1.center = CGPointMake(200, 200);
        _v1.alpha = 0.5;
    }];
//    [CATransaction commit];
}

#pragma mark - CAAnimation/CAAction/CAMediaTiming中部分属性的实验

- (void)doAnimtion2 {
    //*** 这一行等价于它下面三行
    _v1.center = CGPointMake(200, 200);
    //    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(200, 200)];
    //    anim.fillMode = kCAFillModeForwards;
    //    anim.removedOnCompletion = NO;
    
    //*** 当modelLayer的key对应的value值与动画fromValue不相同时，延迟等待过程中presentationLayer一直显示为fromValue
    //    anim.beginTime = CACurrentMediaTime() + 3.0f;
    //    anim.fillMode = kCAFillModeBackwards;
    
    
    CABasicAnimation *anim = [CABasicAnimation animation];
    anim.keyPath = @"position";
    anim.duration = 10.0f;
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(80, 86)];
    anim.additive = YES;
    [_v1.layer addAnimation:anim forKey:@"alpha animation"];
}

#pragma mark - 打印动画过程中，对比model layer 和 presentation layer数据的变化
- (void)doAnimtion3 {
    [UIView animateWithDuration:5.0f
                     animations:^{
                         _v1.center = CGPointMake(200, 200);
                     }];
    _printPresentationLayerTimer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(print) userInfo:nil repeats:YES];
}

- (void)print {
    //这里用一个Timer print presentLayer的位置。
    CALayer *presentationLayer = _v1.layer.presentationLayer;
    CGPoint modelLayerPosition = _v1.layer.position;
    CGPoint presentationLayerPosition = presentationLayer.position;
    NSLog(@"model:%@, presentLayer%@",
          NSStringFromCGPoint(modelLayerPosition), NSStringFromCGPoint(presentationLayerPosition));
    
    if (CGPointEqualToPoint(modelLayerPosition, presentationLayerPosition)) {
        if ([_printPresentationLayerTimer isValid]) {
            [_printPresentationLayerTimer invalidate];
            _printPresentationLayerTimer = nil;
        }
    }
}

@end