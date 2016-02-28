//
//  IDCALayerVC.m
//  iOSDev
//
//  Created by XiaoShan on 2/27/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "IDCALayerVC.h"
#import "IDCALayer.h"
#import "IDCALayerView.h"

@interface IDCALayerVC ()

@property (nonatomic, strong) IDCALayerView *v;

@end

@implementation IDCALayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //实验UIView的内容的渲染流程(走drawInRect的流程)，此流程中有BackingStore参与，即符号断眯时CABackingStoreUpdate_方法被调到
    _v = [[IDCALayerView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_v];
    
    //实验UIView的内容的渲染流程(赋值content内容的流程)，此流程无BackingStore参与：验验：加符号断点CABackingStoreUpdate_，然后在setImage中修改content内容时CABackingStoreUpdate_没有被调到
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat width = 100.0f;
    CGFloat height = 100.0f;
    CGFloat left = (self.view.frame.size.width - width) / 2.0f;
    CGFloat top = self.view.frame.size.height - height;
    btn.frame = CGRectMake(left, top, width, height);
    btn.backgroundColor = [UIColor greenColor];
    [btn addTarget:self action:@selector(setImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    #warning todo 实验动画的渲染流程
    //实验动画的渲染流程
//    [UIView animateWithDuration:0.3 animations:^{
//        _v.backgroundColor = [UIColor redColor];
//    }];
}

- (void)setImage {
    NSString *file = [[NSBundle mainBundle] pathForResource:@"WeChat_1456306696" ofType:@"jpeg"];
    UIImage *img = [UIImage imageWithContentsOfFile:file];
    _v.layer.contents = (__bridge id _Nullable)(img.CGImage);
}

@end