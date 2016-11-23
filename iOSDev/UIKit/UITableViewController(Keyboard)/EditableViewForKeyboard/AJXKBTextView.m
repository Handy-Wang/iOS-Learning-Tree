//
//  AJXKBTextView.m
//  iOSDev
//
//  Created by Handy on 11/21/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "AJXKBTextView.h"
#import "UIView(AJXKeyboard).h"
#import "UIWindow(AJXKeyboard).h"
#import "UITableView(AJXKeyboard).h"
#import "AJXKeyboardManager.h"

@interface AJXKBTextView() <UITextViewDelegate>
@property (nonatomic, assign) BOOL isTextEditing;
@property (nonatomic, weak) UIWindow *keyWindow;

@property (nonatomic, weak) UITableView *superTableView;
//@property (nonatomic, weak) UIScrollView *superScrollView;
@end

@implementation AJXKBTextView

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
        _superTableView = [self ajxSuperTableView];
        if (_superTableView) {
            [_superTableView cacheContentInset];
        }
        
        [self updateTableViewContentOffset];
        [self updateTableViewContentInset];
        
        //如果开启编辑时，当前输入框所属tableView与之前缓存在KBManager里的tableView(containerView)不是同一个，
        //则需要把之前的tableView的inset恢复到键盘弹起前
        if (kbMgr.containerView != _superTableView  && [kbMgr.containerView isKindOfClass:[UITableView class]]) {
            [(UITableView *)(kbMgr.containerView) restoreContentInset];
            kbMgr.containerView = nil;
        }
        
        kbMgr.containerView = _superTableView;
    }
}

- (void)keyboardDidChangedFrame:(NSNotification *)notification
{
    AJXKeyboardManager *kbMgr = [AJXKeyboardManager defaultKeyboardManager];
    NSLog(@"====Chagne frame, kb frame is %@...", NSStringFromCGRect(kbMgr.keyboardFrame));
    [self updateTableViewContentOffset];
    [self updateTableViewContentInset];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    NSLog(@"===========%@--%@", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
    [self resetTableViewContentInsetIfNeeded];
    _keyWindow = nil;
    _isTextEditing = NO;
}

#pragma mark - Private

- (void)updateTableViewContentOffset
{
    AJXKeyboardManager *kbMgr = [AJXKeyboardManager defaultKeyboardManager];
    if (kbMgr.isKeyboardVisible && _superTableView && _isTextEditing) {
        CGRect textViewFrameInWindow = [self.superview convertRect:self.frame toView:_keyWindow];
        CGFloat offsetNeededToTranslate = CGRectGetMaxY(textViewFrameInWindow) - CGRectGetMinY(kbMgr.keyboardFrame);
        
        if (offsetNeededToTranslate > 0) {
            CGPoint oldContentOffset = _superTableView.contentOffset;
            CGFloat newOffset = oldContentOffset.y + offsetNeededToTranslate;
            _superTableView.contentOffset = CGPointMake(oldContentOffset.x, newOffset);
        }
    }
}

- (void)updateTableViewContentInset
{
    AJXKeyboardManager *kbMgr = [AJXKeyboardManager defaultKeyboardManager];
    if (kbMgr.isKeyboardVisible && _superTableView && _isTextEditing) {
        CGRect tableFrameInWindow = [_superTableView.superview convertRect:_superTableView.frame toView:_keyWindow];
        CGRect tableAndKeyboardInsectRect = CGRectIntersection(tableFrameInWindow, kbMgr.keyboardFrame);
        CGFloat intersectionHeight = CGRectIsNull(tableAndKeyboardInsectRect) ? 0 : tableAndKeyboardInsectRect.size.height;
        
        UIEdgeInsets oldContentInset = [_superTableView ajxKeyboardTableViewOldContentInset];
        _superTableView.contentInset = UIEdgeInsetsMake(oldContentInset.top,
                                                        oldContentInset.left,
                                                        oldContentInset.bottom + intersectionHeight,
                                                        oldContentInset.right);
    }
}

- (void)resetTableViewContentInsetIfNeeded
{
    AJXKeyboardManager *kbMgr = [AJXKeyboardManager defaultKeyboardManager];
    //键盘消失后才恢复tableView的contentInset，在tableView内部的textView间切换时不恢复tableView的contentInset
    if (!(kbMgr.isKeyboardVisible)) {
        [_superTableView restoreContentInset];
        _superTableView = nil;
    }
}

@end
