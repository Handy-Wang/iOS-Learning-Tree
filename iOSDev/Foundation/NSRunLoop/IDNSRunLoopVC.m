//
//  IDNSRunLoopVC.m
//  iOSDev
//
//  Created by XiaoShan on 2/27/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "IDNSRunLoopVC.h"

@interface IDNSRunLoopVC ()

@end

@implementation IDNSRunLoopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //GCD与RunLoop的关系
    [self testGCDandRunLoop];
}

- (void)testGCDandRunLoop {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"Do something...");
    });
}

@end
