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
    __strong NSString *name;
    __weak NSNumber *_wheelsCount;
}
@end

@implementation IDMyCar

@end

//###########################################################################
//###########################################################################
//###########################################################################

static void fixup_class_arc(Class class) {
    struct {
        Class isa;
        Class superclass;
        struct {
            void *_buckets;
            uint32_t _mask;
            uint32_t _occupied;
        } cache;
        uintptr_t bits;
    } *objcClass = (__bridge typeof(objcClass))class;
#if !__LP64__
#define FAST_DATA_MASK 0xfffffffcUL
#else
#define FAST_DATA_MASK 0x00007ffffffffff8UL
#endif
    struct {
        uint32_t flags;
        uint32_t version;
        struct {
            uint32_t flags;
        } *ro;
    } *objcRWClass = (typeof(objcRWClass))(objcClass->bits & FAST_DATA_MASK);
#define RO_IS_ARR 1<<7
    objcRWClass->ro->flags |= RO_IS_ARR;
}

@interface IDRuntimeVC ()

@end

@implementation IDRuntimeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //参考1, Runtime源码objc-layout.m中对Object Layouts的说明
    /**********************************************************************
     * Object Layouts.
     *
     * Layouts are used by the garbage collector to identify references from
     * the object to other objects.
     *
     * Layout information is in the form of a '\0' terminated byte string.
     * Each byte contains a word skip count in the high nibble and a
     * consecutive references count in the low nibble. Counts that exceed 15 are
     * continued in the succeeding byte with a zero in the opposite nibble.
     * Objects that should be scanned conservatively will have a NULL layout.
     * Objects that have no references have a empty byte string.
     *
     * Example;
     *
     *   For a class with pointers at offsets 4,12, 16, 32-128
     *   the layout is { 0x11, 0x12, 0x3f, 0x0a, 0x00 } or
     *       skip 1 - 1 reference (4)
     *       skip 1 - 2 references (12, 16)
     *       skip 3 - 15 references (32-88)
     *       no skip - 10 references (92-128)
     *       end
     * 
     **********************************************************************/
    
    //参考2: http://blog.sunnyxx.com/2015/09/13/class-ivar-layout/
    
    //参考3: http://blog.zorro.im/posts/object_setIvar_under_arc.html
    
    //参考4: http://stackoverflow.com/questions/16131172/what-are-class-setivarlayout-and-class-getivarlayout
    
    //参考5: http://www.cnblogs.com/cane004/archive/2010/08/19/ASCII.html
    [self dynamicCreateClass];
}

- (void)dynamicCreateClass {
    //    uint8_t *strongIvarLayout = class_getIvarLayout([IDMyCar class]);
    //    uint8_t *weakIvarLayout = class_getWeakIvarLayout([IDMyCar class]);
    //    NSLog(@"strongIvarLayout %x", *strongIvarLayout);
    //    NSLog(@"weakIvarLayout %x", *weakIvarLayout);
    
    Class class = [[self class] createClassWithName:@"iCar"];
    
    id car = [class new];
    Ivar wheelsCountIvar = class_getInstanceVariable(class, "_wheelsCount");
    Ivar nameIvar = class_getInstanceVariable(class, "_name");
    
    {
        NSNumber *wheelsCount = [NSNumber numberWithInt:4];
        NSString *name = [@"BMW" mutableCopy];
        object_setIvar(car, wheelsCountIvar, wheelsCount);
        object_setIvar(car, nameIvar, name);
    }
    
    NSLog(@"Wheels count is %@", object_getIvar(car, wheelsCountIvar));
    NSLog(@"Name is %@", object_getIvar(car, nameIvar));
}

//通过Runtime创建一个类（实例变量、属性、方法）
+ (Class)createClassWithName:(NSString *)className {
    /**
     *  extraBytes
     *  The number of bytes to allocate for indexed ivars at the end of the class and metaclass objects. This should usually be 0.
     */
    Class class = objc_allocateClassPair([NSObject class], [className UTF8String], 0);
    //添加instance variable
    class_addIvar(class, [@"_wheelsCount" UTF8String], sizeof(id), log2(sizeof(id)), @encode(id));
    class_addIvar(class, [@"_name" UTF8String], sizeof(id), log2(sizeof(id)), @encode(id));
    
    //设置instance variable的strong修饰符的结构
    class_setIvarLayout(class, (const uint8_t *)"\x01");
    //设置instance variable的strong修饰符的结构
    class_setWeakIvarLayout(class, (const uint8_t *)"\x11");
    //添加instance variable的strong修饰符
    objc_registerClassPair(class);
    fixup_class_arc(class);
    
    return class;
}

@end
