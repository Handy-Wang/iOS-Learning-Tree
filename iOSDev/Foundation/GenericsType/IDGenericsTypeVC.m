//
//  IDGenericsTypeVC.m
//  iOSDev
//
//  Created by XiaoShan on 2/27/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "IDGenericsTypeVC.h"

//自定义范型---------------------------------------------------
@interface IDStack<ObjectType : __kindof UIView *> : NSObject

@property (nonatomic, strong, nonnull) NSMutableArray<ObjectType> *allObjects;

- (BOOL)pushObject:(ObjectType)obj;

@end

@implementation IDStack


- (BOOL)pushObject:(id)obj {
    return NO;
}

@end
//------------------------------------------------------------

@interface IDGenericsTypeVC ()

@property (nonatomic, strong, nonnull) NSMutableArray <UIView *> *a1;
@property (nonatomic, strong, nonnull) NSMutableArray <__kindof UIView *> *a2;

@end

@implementation IDGenericsTypeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //实验范性和__kindif特性
    _a1 = [NSMutableArray array];
    //    [_a1[0] addTarget:self action:@selector(aMethod) forControlEvents:UIControlEventTouchUpInside];
    UIView *firstV = _a1.firstObject.subviews.firstObject;
    NSLog(@"First view is %@", firstV);
    
    _a2 = [NSMutableArray array];
    [_a2.firstObject addTarget:self action:@selector(aMethod) forControlEvents:UIControlEventTouchUpInside];
    
    //自定义范型
    IDStack<UIButton *> *stack = [IDStack new];
    [stack pushObject:[UIButton new]];
    NSLog(@"stack is %@", stack);
}

- (void)aMethod {
}

@end
