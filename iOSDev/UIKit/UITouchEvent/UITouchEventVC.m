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

@interface UITouchEventVC () {
    UIControl *_control1;
}
@end

@implementation UITouchEventVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //由于在touchupinside的selector回调里取control状态时仍为highlighted
    //所以，这里采用observe的方式直接监听highlighted的状态变化，以监听到control的状态从highlighted=1变为0的时机
    CGRect controlFrame1 = CGRectMake(0, 0, 200, 200);
    _control1 = [[UIControl alloc] initWithFrame:controlFrame1];
    [_control1 setBackgroundColor:[UIColor redColor]];
    [_control1 addTarget:self action:@selector(didTapControl1:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_control1];
    
    [_control1 addObserver:self forKeyPath:@"highlighted" options:NSKeyValueObservingOptionNew+NSKeyValueObservingOptionOld context:NULL];
    
    
    /*
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
     */
}

- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSString*, id> *)change context:(nullable void *)context
{
    id oldValue = [change objectForKey:NSKeyValueChangeOldKey];
    id newValue = [change objectForKey:NSKeyValueChangeNewKey];
    NSLog(@"--------- observe, old state is %lu, new state is %lu", [oldValue integerValue], [newValue integerValue]);
}

- (void)didTapControl1:(UIControl *)control
{
    NSLog(@"--------- state is %lu", control.state);
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
