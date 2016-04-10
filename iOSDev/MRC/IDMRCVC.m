//
//  IDMRCVC.m
//  iOSDev
//
//  Created by XiaoShan on 3/2/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "IDMRCVC.h"

typedef void (^eBlock)();

typedef void (^dBlock)();

//dBlock exampleD_getBlock() {
//    char d = 'D';
//    return ^{
//        printf("%c\n", d);
//    };
//}

eBlock exampleE_getBlock() {
    char e = 'E';
    void (^block)() = ^{
        printf("%c\n", e);
    };
    return block;
}

@implementation IDMRCVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    exampleD_getBlock()();
    eBlock block = exampleE_getBlock();
    block();
    
    NSObject *obj1 = [NSObject new];
    [obj1 release];
}

@end
