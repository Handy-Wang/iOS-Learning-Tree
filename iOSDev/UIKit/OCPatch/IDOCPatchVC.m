//
//  IDOCPatchVC.m
//  iOSDev
//
//  Created by XiaoShan on 3/4/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "IDOCPatchVC.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface IDOCPatchVC ()

@property (nonatomic, strong) JSContext *jsContext;
@property (nonatomic, strong) UIButton *btn;

@end

@implementation IDOCPatchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *javascript = [self loadJavaScript];
    self.jsContext = [self loadJavaScriptContext:javascript];
}

#pragma mark - private methods

- (NSString *)loadJavaScript {
    NSURL *jsURL = [[NSBundle mainBundle] URLForResource:@"jspatch" withExtension:@"js"];
    NSString *js = [NSString stringWithContentsOfURL:jsURL encoding:NSUTF8StringEncoding error:nil];
    
    return js;
}

- (JSContext *)loadJavaScriptContext:(NSString *)javascript {
    JSContext *jsContext = [[JSContext alloc] init];
    jsContext[@"__c"] = ^ (id obj) {
        NSLog(@"Invoke from javascript, obj : %@", obj);
    };
    [jsContext evaluateScript:javascript];
    jsContext.exceptionHandler = ^(JSContext *context, JSValue *exception) {
        context.exception = exception;
        NSLog(@"异常信息：%@", context.exception);
    };
    
    return jsContext;
}

@end
