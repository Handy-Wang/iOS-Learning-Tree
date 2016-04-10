//
//  IDRuntimeVC.m
//  iOSDev
//
//  Created by Handy on 4/6/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "IDRuntimeVC.h"
#import <objc/runtime.h>

@interface IDMyCar : NSObject {
    __strong NSString *_band;
    __weak NSNumber *_wheelsCount0;
    __weak NSNumber *_wheelsCount;
    __strong NSString *_band1;
//    __strong NSString *_band2;
//    __strong NSString *_band3;
//    __unsafe_unretained NSNumber *_age;
//    __weak NSNumber *_wheelsCount1;
}
@end

@implementation IDMyCar

@end

//###########################################################################
//###########################################################################
//###########################################################################

@interface IDRuntimeVC ()

@end

@implementation IDRuntimeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    uint8_t *strongIvarLayout = class_getIvarLayout([IDMyCar class]);
    uint8_t *weakIvarLayout = class_getWeakIvarLayout([IDMyCar class]);
    NSLog(@"strongIvarLayout %x", *strongIvarLayout);
    NSLog(@"weakIvarLayout %x", *weakIvarLayout);
    
    Class class = [[self class] createClassWithName:@"iCar"];
    id car = [class new];
    Ivar whealsCountIvar = class_getInstanceVariable(class, "_wheelsCount");
    object_setIvar(car, whealsCountIvar, @(4));
    NSLog(@"Wheels count is %d", [object_getIvar(car, whealsCountIvar) intValue]);
}

//通过Runtime创建一个类（实例变量、属性、方法）
+ (Class)createClassWithName:(NSString *)className {
    /**
     *  extraBytes
     *  The number of bytes to allocate for indexed ivars at the end of the class and metaclass objects. This should usually be 0.
     */
    Class class = objc_allocateClassPair([NSObject class], [className UTF8String], 0);
    //添加instance variable
    class_addIvar(class, [@"_wheelsCount" UTF8String], sizeof(int), log2(sizeof(int)), @encode(int));
//    //设置instance variable的strong修饰符的结构
//    class_setIvarLayout(class, (const uint8_t *)"\x10");
//    //设置instance variable的strong修饰符的结构
//    class_setWeakIvarLayout(class, (const uint8_t *)"\x01");
    //添加instance variable的strong修饰符
    objc_registerClassPair(class);
    
    return class;
}

@end
