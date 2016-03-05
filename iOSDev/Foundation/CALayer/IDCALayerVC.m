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

/*
 总结：
1. 研究CALayer调用UIView的流程，即CALayer的display流程。
1.1 第一步：setNeedDisplay(UIView) -> setNeedDisplay(CALayer)；
1.2 第二步：View Drawing Cycle(Found dirty data) -> display(CALayer) -> displayInContext:(CALayer) -> drawLayer:InContext:(CALayerDelegate<UIView>) -> drawRect:(CALayerDelegate<UIView>)
1.3 第三步：View Drawing Cycle(Get layer model) -> Compositing Layers(OpenGLES) -> Render in device screen(GPU)
2. display流程中，有BackingStore的参与，通过符号断点CABackingStoreUpdate_可知。注：只创建CALayer时，需要调用setNeedDisplay才会使drawing cycle发起display流程；而创建UIView时设置frame时就会在UIView的内部调用setNeedDisplay，但是如果不把创建的view添加到父View上的话，CALayer的display方法同样也不会被调用，因为没有父View与说明不需要显示，那么肯定不会有display流程。
3. 非display流程中，修改layer的content时，无BackingStore参与，不会走display流程，content应该是不经过BackingStore这个缓冲区而直接被OpenGLES合成后加载到了CPU，而被显示了。相当于少了一道工序。这个流程应该与1.3一致。
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //实验UIView的内容的渲染流程(CALayer的display流程)，此流程中有BackingStore参与，即符号断眯时CABackingStoreUpdate_方法被调到
    _v = [[IDCALayerView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_v];
    
    //实验UIView的内容的渲染流程(不经过CALayer的display流程)，此流程无BackingStore参与：验验：加符号断点CABackingStoreUpdate_，然后在setImage中修改content内容时CABackingStoreUpdate_没有被调到
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