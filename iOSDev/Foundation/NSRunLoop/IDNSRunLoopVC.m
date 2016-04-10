//
//  IDNSRunLoopVC.m
//  iOSDev
//
//  Created by XiaoShan on 2/27/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "IDNSRunLoopVC.h"

static void runLoopObserverCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
//    MyClass *object = (__bridge MyClass*)info;
//    object->activity = activity;
    
    NSString *activityName = @"kCFRunLoopAllActivities";
    
    switch (activity) {
        case 1://kCFRunLoopEntry
            activityName = @"kCFRunLoopEntry";
            break;
        case 2://kCFRunLoopBeforeTimers
            activityName = @"kCFRunLoopBeforeTimers";
            break;
        case 4://kCFRunLoopBeforeSources
            activityName = @"kCFRunLoopBeforeSources";
            break;
        case 32://kCFRunLoopBeforeWaiting
            activityName = @"kCFRunLoopBeforeWaiting";
            break;
        case 64://kCFRunLoopAfterWaiting
            activityName = @"kCFRunLoopAfterWaiting";
            break;
        case 128://kCFRunLoopExit
            activityName = @"kCFRunLoopExit";
            break;
        default://kCFRunLoopAllActivities
            break;
    }
    
    NSLog(@"current activity is %@ \n\n", activityName);
}

@interface IDNSRunLoopVC () {
    BOOL _isReloadDone;
    CFRunLoopObserverRef _observer;
}

@end

@implementation IDNSRunLoopVC

- (instancetype)init {
    self = [super init];
    if (self) {
        //Monitor 6 callback(ACTIVITY) of RunLoop
        [self monitorRunLoopActivities];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        _isReloadDone = NO;
        [self.view layoutIfNeeded]; //会自动设置tableView layoutIfNeeded为YES，意味着将会在runloop结束时重绘table
        dispatch_async(dispatch_get_main_queue(),^{
            _isReloadDone = YES;
        });
    });
    
    //GCD与RunLoop的关系
//    [self testGCDandRunLoop];
}

- (void)monitorRunLoopActivities {
    CFRunLoopObserverContext context = {0, (__bridge void *)(self), NULL, NULL, NULL};
    _observer = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, &runLoopObserverCallBack, &context);
    CFRunLoopAddObserver([[NSRunLoop currentRunLoop] getCFRunLoop], _observer, kCFRunLoopCommonModes);
}

- (void)testGCDandRunLoop {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSLog(@"Do something...");
    });
}

- (void)dealloc {
    CFRunLoopRemoveObserver([[NSRunLoop currentRunLoop] getCFRunLoop], _observer, kCFRunLoopCommonModes);
}

@end
