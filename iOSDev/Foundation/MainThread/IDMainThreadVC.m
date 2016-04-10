//
//  IDMainThreadVC.m
//  iOSDev
//
//  Created by Handy on 4/8/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "IDMainThreadVC.h"

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

@interface IDMainThreadVC () {
    BOOL _isReloadDone;
    CFRunLoopObserverRef _observer;
    NSTimeInterval _begin;
}
@end

@implementation IDMainThreadVC

- (instancetype)init {
    self = [super init];
    if (self) {
        //Monitor 6 callback(ACTIVITY) of RunLoop
//        [self monitorRunLoopActivities];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //如何准确计算出循环里异步block运行所需的时长
    [self timeCostForEachAsynBlockInLoop];
}

- (void)timeCostForEachAsynBlockInLoop {
    dispatch_queue_t queue = dispatch_get_main_queue();//dispatch_queue_create("HANDY_TEST_QUEUE", DISPATCH_QUEUE_SERIAL);//DISPATCH_QUEUE_CONCURRENT
    __block NSTimeInterval lastDuration = 0;
    __block NSTimeInterval begin = [[NSDate date] timeIntervalSince1970] * 1000.0f;
    
    for (int i=0; i<10; i++) {
        dispatch_async(queue, ^{
            //Long time task...
            for (int j=0; j<1000000; j++) {
            }
            //---
            
            NSTimeInterval now = [[NSDate date] timeIntervalSince1970] * 1000.0f;
            NSTimeInterval currentDuration = (now - begin);
            NSTimeInterval timecost = currentDuration - lastDuration;
            lastDuration = currentDuration;
            NSLog(@"Time1 cost %d is %g milli-seconds", i, timecost);
        });
    }
}

- (void)monitorRunLoopActivities {
//    CFRunLoopObserverContext context = {0, (__bridge void *)(self), NULL, NULL, NULL};
//    _observer = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, &runLoopObserverCallBack, &context);
//    CFRunLoopAddObserver([[NSRunLoop currentRunLoop] getCFRunLoop], _observer, kCFRunLoopCommonModes);
}

@end
