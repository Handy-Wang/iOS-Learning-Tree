//
//  IDFPSLabelVC.m
//  iOSDev
//
//  Created by Handy on 4/28/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "IDFPSLabelVC.h"
#import "NMFPSLabel.h"

@interface IDFPSLabelVC ()

@end

@implementation IDFPSLabelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NMFPSLabel *fpsLabel = [[NMFPSLabel alloc] initWithFrame:CGRectMake(0, 128, 80, 20)];
    fpsLabel.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:fpsLabel];
}

@end
