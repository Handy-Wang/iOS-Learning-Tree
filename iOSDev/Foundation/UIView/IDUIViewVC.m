//
//  IDUIViewVC.m
//  iOSDev
//
//  Created by XiaoShan on 2/28/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "IDUIViewVC.h"

@interface IDUIViewVC ()

@property (nonatomic, strong) UIView *view1;

@end

@implementation IDUIViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect view1Frame = CGRectMake(0, 64, 100, 100);
    _view1 = [[UIView alloc] initWithFrame:view1Frame];
    _view1.backgroundColor = [UIColor redColor];
    [self.view addSubview:_view1];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, self.view.frame.size.height-100, 100, 100);
    [btn1 setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [btn1 setTitle:@"修改Bounds" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(changeViewBounds) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(self.view.frame.size.width-100, self.view.frame.size.height-100, 100, 100);
    [btn2 setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [btn2 setTitle:@"修改Anchor" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(changeViewAnchorPoint) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    CGPoint view1Position = _view1.layer.position;
    CGPoint view1AnchorPoint = _view1.layer.anchorPoint;
    NSLog(@"View1的默认position:%@, 默认anchorPoint:%@",
          NSStringFromCGPoint(view1Position), NSStringFromCGPoint(view1AnchorPoint));
}

//实验bounds的变化，bounds是对内部坐标进行设置
- (void)changeViewBounds {
    [UIView animateWithDuration:0.3 animations:^{
        [self.view setBounds:CGRectMake(-10, -40, self.view.bounds.size.width, self.view.bounds.size.height)];
    }];
}

//实验anchorPoint的变化
- (void)changeViewAnchorPoint {
    [UIView animateWithDuration:0.3 animations:^{
        _view1.layer.anchorPoint = CGPointMake(0, 0.5);
    }];
}

@end
