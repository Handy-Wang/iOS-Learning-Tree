//
//  UITouchEventVC.m
//  iOSDev
//
//  Created by Handy on 9/7/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "TouchViewA.h"
#import "TouchViewB.h"
#import "TouchViewC.h"
#import "TouchViewD.h"
#import "UITouchEventVC.h"
#import "NMTapGestureRecognizer.h"

@interface UITouchEventVC ()

@end

@implementation UITouchEventVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CGRect frameA = CGRectMake(0, 80, 200, 200);
    TouchViewA *va = [[TouchViewA alloc] initWithFrame:frameA];
    va.userInteractionEnabled = YES;
    va.backgroundColor = [UIColor redColor];
    [self.view addSubview:va];
    
    CGRect frameB = CGRectMake(0, 0, 100, 100);
    TouchViewB *vb = [[TouchViewB alloc] initWithFrame:frameB];
    vb.userInteractionEnabled = YES;
    vb.backgroundColor = [UIColor greenColor];
    [va addSubview:vb];
//    UIView *maskView = [[UIView alloc] initWithFrame:vb.bounds];
//    maskView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.5];
//    vb.maskView = maskView;
    
    CGRect frameC = CGRectMake(50, 20, 100, 100);
    TouchViewC *vc = [[TouchViewC alloc] initWithFrame:frameC];
    vc.userInteractionEnabled = YES;
    vc.backgroundColor = [UIColor blueColor];
    [va addSubview:vc];
    
    CGRect frameD = CGRectMake(0, 0, 50, 50);
    TouchViewD *vd = [[TouchViewD alloc] initWithFrame:frameD];
    vd.userInteractionEnabled = YES;
    vd.backgroundColor = [UIColor grayColor];
    [vc addSubview:vd];
    
    NMTapGestureRecognizer *vcTapGesture = [[NMTapGestureRecognizer alloc] initWithTarget:self action:@selector(triggerTapGesture:)];
    UILongPressGestureRecognizer *vcLongPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(triggerLongPressGesture:)];
//    vcTapGesture.delaysTouchesBegan = YES;//Default NO;
//    vcTapGesture.cancelsTouchesInView = NO;//Default YES;
//    vcTapGesture.delaysTouchesEnded = NO;//Default YES;
    [va addGestureRecognizer:vcTapGesture];
    [va addGestureRecognizer:vcLongPressGesture];
}

- (void)triggerTapGesture:(UITapGestureRecognizer *)tapGesture
{
    NSLog(@"%@ - %@", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
}

- (void)triggerLongPressGesture:(UILongPressGestureRecognizer *)longPressGesture
{
    NSLog(@"%@ - %@", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
}

@end
