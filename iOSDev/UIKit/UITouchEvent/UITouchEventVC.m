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
#import "UITouchEventVC.h"

@interface UITouchEventVC ()

@end

@implementation UITouchEventVC

- (void)viewDidLoad {
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
    
    CGRect frameC = CGRectMake(50, 20, 100, 100);
    TouchViewC *vc = [[TouchViewC alloc] initWithFrame:frameC];
    vc.userInteractionEnabled = YES;
    vc.backgroundColor = [UIColor blueColor];
    [va addSubview:vc];
    
}

@end
