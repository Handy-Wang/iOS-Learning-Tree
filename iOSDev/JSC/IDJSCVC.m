//
//  IDJSCVC.m
//  iOSDev
//
//  Created by Handy on 11/13/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "IDJSCVC.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface Teacher : NSObject<JSExport>
@end

@implementation Teacher
@end

//================================================================

@protocol StudentJSExport <JSExport>

- (instancetype)init;

@end

@interface Student : NSObject<StudentJSExport>
@end

@implementation Student

- (instancetype)init
{
    if (self = [super init]) {
        NSLog(@"Student class");
    }
    return self;
}


@end

//================================================================

@interface IDJSCVC() {
    JSVirtualMachine *_virtualMachine;
    JSContext *_context;
}
@end

@implementation IDJSCVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _virtualMachine = [[JSVirtualMachine alloc] init];
    _context = [[JSContext alloc] initWithVirtualMachine:_virtualMachine];
    _context.exceptionHandler = ^(JSContext *context, JSValue *exception) {
        NSLog(@"exception: %@", exception);
    };
    
    _context[@"Teacher"] = ^() {
        NSLog(@"Teacher class");
        return [[Teacher alloc] init];
    };
    [_context evaluateScript:@"var missGao = new Teacher();"];
    
    _context[@"Student"] = [Student class];
    [_context evaluateScript:@"var xiaoMing = new Student();"];
}

@end
