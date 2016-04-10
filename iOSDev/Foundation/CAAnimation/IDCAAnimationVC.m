//
//  IDCAAnimationVC.m
//  iOSDev
//
//  Created by XiaoShan on 2/29/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IDCAAnimationVC.h"
#import "IDCAAnimationTestView.h"

@interface IDCAAnimationVC ()

@property (nonatomic, strong) UIView *viewA;
@property (nonatomic, strong) UIView *viewB;

@end

@implementation IDCAAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //实验transitionFromView的CATransition动画
    CGRect viewAFrame = CGRectMake(0, 64, 44, 44);
    _viewA = [[UIView alloc] initWithFrame:viewAFrame];
    _viewA.backgroundColor = [UIColor redColor];
    [self.view addSubview:_viewA];
    [self.view sendSubviewToBack:_viewA];
    
    CGRect viewBFrame = CGRectMake(self.view.frame.size.width-44,
                                   self.view.frame.size.height-44,
                                   44,
                                   44);
    _viewB= [[UIView alloc] initWithFrame:viewBFrame];
    _viewB.backgroundColor = [UIColor greenColor];
    
    UIButton *animationABtn = [UIButton buttonWithType:UIButtonTypeCustom];
    animationABtn.frame = CGRectMake(self.view.frame.size.width-100, 64, 100, 44);
    [animationABtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [animationABtn setTitle:@"ClickToGo" forState:UIControlStateNormal];
    [animationABtn addTarget:self action:@selector(testTransitionFromView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:animationABtn];
    
    //------------------------------------------
    //实验CAAction的创建过程
//    [self testCAActionCreateProcedure];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    //实验CAAction的创建过程
    [self testCAActionCreateProcedure];
}

- (void)testTransitionFromView {
    [UIView transitionFromView:_viewA
                        toView:_viewB
                      duration:1
                       options:UIViewAnimationOptionTransitionFlipFromLeft
                    completion:^(BOOL finished) {
                    }];
}

- (void)testCAActionCreateProcedure {
    CGRect animViewFrame = CGRectMake(self.view.frame.size.width-44, 64, 44, 44);
    IDCAAnimationTestView *animView = [[IDCAAnimationTestView alloc] initWithFrame:animViewFrame];
    animView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:animView];
    
//    animView.alpha = 0.5;
//    
//    [UIView animateWithDuration:0.3 animations:^{
////        animView.alpha = 0.5;
//        animView.frame = CGRectZero;
//    }];
}

@end
