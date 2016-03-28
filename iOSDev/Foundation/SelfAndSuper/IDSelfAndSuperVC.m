//
//  IDSelfAndSuperVC.m
//  iOSDev
//
//  Created by XiaoShan on 3/6/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "IDSelfAndSuperVC.h"
#import "HDTeacher.h"

@interface IDSelfAndSuperVC ()

@end

@implementation IDSelfAndSuperVC

- (void)viewDidLoad {
    [super viewDidLoad];

    //实验为什么[self class] 和 [super class]都是HDTeacher
    //实际上，super关键字是self传给了父类，即super就是指向self的，所以无论在子类里输出super.class，还是在父类里输出self.class都是子类的class
    //参考：http://mobile.51cto.com/iphone-274680.htm
    HDTeacher *teacher = [HDTeacher new];
    teacher.username = @"handy.wang";
    teacher = nil;
}

@end
