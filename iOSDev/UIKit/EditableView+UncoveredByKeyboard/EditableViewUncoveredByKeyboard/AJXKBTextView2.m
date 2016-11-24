//
//  AJXKBTextView2.m
//  iOSDev
//
//  Created by Handy on 11/21/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "AJXKBTextView2.h"
#import "UIView(AJXKeyboard).h"
#import "UIWindow(AJXKeyboard).h"
#import "UIScrollView(AJXKeyboard).h"
#import "AJXKeyboardManager.h"

@interface AJXKBTextView2() <UITextViewDelegate>
@property (nonatomic, assign) BOOL isTextEditing;
@property (nonatomic, weak) UIWindow *keyWindow;
@property (nonatomic, weak) UITableView *superTableView;
@end

@implementation AJXKBTextView2

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //init keyboard manager
        [AJXKeyboardManager defaultKeyboardManager];
        self.delegate = self;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardDidChangedFrame:)
                                                     name:kAjxKeyboardDidChangeFrameNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - UITextViewDelegate methods

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    _isTextEditing = YES;
    
    AJXKeyboardManager *kbMgr = [AJXKeyboardManager defaultKeyboardManager];
    NSLog(@"====Begin edit, kb frame %@...", NSStringFromCGRect(kbMgr.keyboardFrame));
    if (kbMgr.isKeyboardVisible) {
        _keyWindow = [self ajxKeyWindow];
        _superTableView = [self ajxSuperScrollableView];
        
        //---
        if (kbMgr.containerView != _superTableView  && [kbMgr.containerView isKindOfClass:[UITableView class]]) {
            kbMgr.containerView.frame = kbMgr.containerViewInitFrame;
            kbMgr.containerView = nil;
        }
        
        //---
        kbMgr.containerView = _superTableView;
        if (_superTableView) {
            kbMgr.containerViewInitFrame = _superTableView.frame;
        }
        [self updateTop];
    }
}

- (void)keyboardDidChangedFrame:(NSNotification *)notification
{
    AJXKeyboardManager *kbMgr = [AJXKeyboardManager defaultKeyboardManager];
    [self updateTop];
    NSLog(@"====Chagne frame, kb frame is %@...", NSStringFromCGRect(kbMgr.keyboardFrame));
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    NSLog(@"===========%@--%@", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
    AJXKeyboardManager *kbMgr = [AJXKeyboardManager defaultKeyboardManager];
    if (!kbMgr.isKeyboardVisible) {
        _superTableView.frame = kbMgr.containerViewInitFrame;
    }
    _superTableView = nil;
    _keyWindow = nil;
    _isTextEditing = NO;
}

#pragma mark - Private

- (void)updateTop
{
    AJXKeyboardManager *kbMgr = [AJXKeyboardManager defaultKeyboardManager];
    if (kbMgr.isKeyboardVisible && _superTableView && _isTextEditing) {
        
        CGRect textViewFrameInWindow = [self.superview convertRect:self.frame toView:_keyWindow];
        CGFloat distance = CGRectGetMaxY(textViewFrameInWindow) - CGRectGetMinY(kbMgr.keyboardFrame);
        if (distance > 0) {//textview被键盘遮挡
            CGRect superTableViewFrameInWindow = [_superTableView.superview convertRect:_superTableView.frame toView:_keyWindow];
            CGRect intersectRect = CGRectIntersection(superTableViewFrameInWindow, kbMgr.keyboardFrame);
            CGFloat offsetNeededToTranslate = 0;
            if (!CGRectIsNull(intersectRect)) {
                offsetNeededToTranslate = intersectRect.size.height;
            }
            
            if (offsetNeededToTranslate > 0) {
                CGRect tableViewFrame = _superTableView.frame;
                tableViewFrame.origin.y -= offsetNeededToTranslate;
                _superTableView.frame = tableViewFrame;
            }
        }
    }
}

@end
