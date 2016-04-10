//
//  IDFuncArgsVC.m
//  iOSDev
//
//  Created by Handy on 4/1/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "IDFuncArgsVC.h"

void fun(int a, ...) {
    int *temp = &a;
    temp++;
    for (int i = 0; i < a; i++) {
        NSLog(@"temp is %d", *temp);
//        cout << *temp << endl;
        temp++;
    }
}

@interface IDFuncArgsVC ()

@end

@implementation IDFuncArgsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    int a = 1;
    int b = 2;
    int c = 3;
    int d = 4;
    fun(4, a, b, c, d);
}

@end
