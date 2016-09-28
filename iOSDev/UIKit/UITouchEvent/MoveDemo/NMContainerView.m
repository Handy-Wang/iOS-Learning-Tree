//
//  NMContainerView.m
//  iOSDev
//
//  Created by Handy on 9/22/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "NMTableView.h"
#import "NMContainerView.h"

@interface NMContainerView()
{
    NMTableView *_tableView;
}

@end

@implementation NMContainerView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _tableView = [[NMTableView alloc] initWithFrame:CGRectMake(0, 0,
                                                                   self.bounds.size.width,
                                                                   self.bounds.size.height)];
        _tableView.contentInset = UIEdgeInsetsMake(-44, 0, 0, 0);
        _tableView.layer.borderColor = [UIColor greenColor].CGColor;
        _tableView.layer.borderWidth = 1;
        _tableView.containerView = self;
        [self addSubview:_tableView];
        
        UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        panGesture.delegate = self;
        [self addGestureRecognizer:panGesture];
    }
    
    return self;
}

- (void)pan:(UIPanGestureRecognizer *)panGesture
{
//    if (panGesture.state == UIGestureRecognizerStateChanged) {
//        CGPoint point = [panGesture translationInView:self];
//        NSLog(@"translation point is %@", NSStringFromCGPoint(point));
//        
//        CGRect frame = self.frame;
//        frame.origin.y += point.y;
//        self.frame = frame;
//    }
    
    
    CGPoint translatedPoint = [panGesture translationInView:self];
    NSLog(@"gesture translatedPoint  is %@", NSStringFromCGPoint(translatedPoint));
    CGFloat x = panGesture.view.center.x;
    CGFloat y = panGesture.view.center.y + translatedPoint.y;
    
    panGesture.view.center = CGPointMake(x, y);
    
    NSLog(@"pan gesture testPanView moving  is %@,%@", NSStringFromCGPoint(panGesture.view.center), NSStringFromCGRect(panGesture.view.frame));
    
    [panGesture setTranslation:CGPointMake(0, 0) inView:self];
    
    if (panGesture.view.frame.origin.y <= 64) {
        _tableView.canScrollList = YES;
        CGRect frame = panGesture.view.frame;
        frame.origin.y = 64;
        panGesture.view.frame = frame;
        self.isTop = YES;
    } else {
        _tableView.canScrollList = NO;
        self.isTop = NO;
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@ - %@------------", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"%@ - %@------------", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
}

@end
