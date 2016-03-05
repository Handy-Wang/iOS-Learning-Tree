//
//  IDNSArrayVC.m
//  iOSDev
//
//  Created by XiaoShan on 2/27/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "IDNSArrayVC.h"
#import "IDPerson.h"

@interface IDNSArrayVC ()

@end

@implementation IDNSArrayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self testDeepCopyAndShallowCopy];
}

//实验深拷贝和浅拷贝
//参考：http://www.jianshu.com/p/a99f3da35560
//参考：https://www.zybuluo.com/MicroCai/note/50592
- (void)testDeepCopyAndShallowCopy {
    IDPerson *person1 = [[IDPerson alloc] init];
    person1.name = @"handy.wang";
    
    IDPerson *person2 = [person1 copy];
    IDPerson *person3 = [person1 mutableCopy];
    
    NSMutableArray *testArray = [NSMutableArray arrayWithObjects:person1, person2, person3, nil];
    NSMutableArray *copyArray = [testArray mutableCopy];//Array自身是深copy了，但是里面的成员没有。
    
    person1.name = @"wang";
}

@end
