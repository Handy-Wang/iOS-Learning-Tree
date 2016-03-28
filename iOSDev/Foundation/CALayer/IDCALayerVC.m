//
//  IDCALayerVC.m
//  iOSDev
//
//  Created by XiaoShan on 2/27/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "IDCALayerVC.h"
#import "IDCALayer.h"
#import "IDCALayerView.h"

#define kActionBtnSize              (100.0f)

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

@interface IDCALayerVC () {
    CFRunLoopObserverRef _observer;
    
    //测试点击事件触发display的过程
    IDCALayerView *_bgColorView;
    UIButton *_changeBgColorBtn;
    //---
    
    //测试非display过程的图片显示
    IDCALayerView *_bgImgView;
    UIButton *_changeBgImgBtn;
    //---
}

@end

@implementation IDCALayerVC

- (instancetype)init {
    self = [super init];
    if (self) {
        [self monitorRunLoopActivities];
    }
    return self;
}

- (void)monitorRunLoopActivities {
    CFRunLoopObserverContext context = {0, (__bridge void *)(self), NULL, NULL, NULL};
    _observer = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, YES, 0, &runLoopObserverCallBack, &context);
    CFRunLoopAddObserver([[NSRunLoop currentRunLoop] getCFRunLoop], _observer, kCFRunLoopCommonModes);
}

/*
 总结：
1. 研究CALayer调用UIView的流程，即CALayer的display流程。
1.1 第一步：setNeedDisplay(UIView) -> setNeedDisplay(CALayer)；
1.2 第二步：View Drawing Cycle(Found dirty data) -> display(CALayer) -> displayInContext:(CALayer) -> drawLayer:InContext:(CALayerDelegate<UIView>) -> drawRect:(CALayerDelegate<UIView>)
1.3 第三步：View Drawing Cycle(Get layer model) -> Compositing Layers(OpenGLES) -> Render in device screen(GPU)
2. display流程中，有BackingStore的参与，通过符号断点CABackingStoreUpdate_可知。注：只创建CALayer时，需要调用setNeedDisplay才会使drawing cycle发起display流程；而创建UIView时设置frame时就会在UIView的内部调用setNeedDisplay，但是如果不把创建的view添加到父View上的话，CALayer的display方法同样也不会被调用，因为没有父View与说明不需要显示，那么肯定不会有display流程。
3. 非display流程中，修改layer的content时，无BackingStore参与，不会走display流程，content应该是不经过BackingStore这个缓冲区而直接被OpenGLES合成后加载到了GPU，而被显示了。相当于少了一道工序。这个流程应该与1.3一致。
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self testViewDisplayProcessForDrawRect];
    [self testViewNonDisplayProcessForShowImg];
    
    [self.view bringSubviewToFront:_changeBgColorBtn];
    [self.view bringSubviewToFront:_changeBgImgBtn];
}

#pragma mark - testViewDisplayProcesForDrawRect

//实验UIView的内容的渲染流程(CALayer的display流程)，此流程中有BackingStore参与，即符号断点时CABackingStoreUpdate_方法被调到
- (void)testViewDisplayProcessForDrawRect {
    CGRect bgColorViewFrame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/2.0f);
    _bgColorView = [[IDCALayerView alloc] initWithFrame:bgColorViewFrame];
    [self.view addSubview:_bgColorView];
    
    CGFloat left = (self.view.frame.size.width - 2*kActionBtnSize) / 3.0f;
    CGFloat top = self.view.frame.size.height - kActionBtnSize;
    CGRect changeBgColorBtnFrame = CGRectMake(left, top, kActionBtnSize, kActionBtnSize);
    _changeBgColorBtn = [[UIButton alloc] initWithFrame:changeBgColorBtnFrame];
    [_changeBgColorBtn setTitle:@"修改背景色" forState:UIControlStateNormal];
    [_changeBgColorBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_changeBgColorBtn setBackgroundColor:[UIColor greenColor]];
    [_changeBgColorBtn addTarget:self action:@selector(changeBgColor) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_changeBgColorBtn];
}

- (void)changeBgColor {
    _bgColorView.backgroundColor = [UIColor blueColor];
}

#pragma mark - testViewNonDisplayProcessForShowImg

//实验UIView的内容的渲染流程(不经过CALayer的display流程)，此流程无BackingStore参与：验验：加符号断点CABackingStoreUpdate_，然后在setImage中修改content内容时CABackingStoreUpdate_没有被调到
- (void)testViewNonDisplayProcessForShowImg {
    CGRect bgImgViewFrame = CGRectMake(0, self.view.frame.size.height/2.0f,
                                       self.view.frame.size.width, self.view.frame.size.height/2.0f);
    _bgImgView = [[IDCALayerView alloc] initWithFrame:bgImgViewFrame];
    _bgImgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:_bgImgView];
    
    CGFloat left = 2*(self.view.frame.size.width - 2*kActionBtnSize) / 3.0f + kActionBtnSize;
    CGFloat top = self.view.frame.size.height - kActionBtnSize;
    CGRect changeBgImgBtnFrame = CGRectMake(left, top, kActionBtnSize, kActionBtnSize);
    _changeBgImgBtn = [[UIButton alloc] initWithFrame:changeBgImgBtnFrame];
    [_changeBgImgBtn setTitle:@"设置图片" forState:UIControlStateNormal];
    [_changeBgImgBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _changeBgImgBtn.backgroundColor = [UIColor greenColor];
    [_changeBgImgBtn addTarget:self action:@selector(setImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_changeBgImgBtn];
}

- (void)setImage {
    NSString *file = [[NSBundle mainBundle] pathForResource:@"WeChat_1456306696" ofType:@"jpeg"];
    UIImage *img = [UIImage imageWithContentsOfFile:file];
    _bgImgView.layer.contents = (__bridge id _Nullable)(img.CGImage);
}

@end