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
#import "UIScrollView(AJXKeyboard).h"
#import "AJXKeyboardManager.h"

@interface AJXKBTextView() <UITextViewDelegate>
@property (nonatomic, assign) BOOL isTextEditing;
@property (nonatomic, weak) UIWindow *keyWindow;
@property (nonatomic, weak) UIView *contatinerView;
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
    if (kbMgr.isKeyboardVisible) {
        
        _keyWindow = [self ajxKeyWindow];
        _contatinerView = [self ajxSuperTableView];
        _contatinerView = _contatinerView ? : [self ajxSuperScrollView];
        //todo
        //_contatinerView = _contatinerView ? : [self ViewControllerView];
        
        if ([self isScrollableContainerView]) {
            [((UIScrollView *)_contatinerView) cacheContentInset];
            [self updateScrollableContainerViewContentOffset];
            [self updateScrollableContainerViewContentInset];
        } else {
            //todo
            //[self updateContainerViewFrame];
        }
        
        //如果开启编辑时，当前输入框所属scrollableView与之前缓存在KBManager里的scrollableView(containerView)不是同一个，
        //则需要把之前的scrollableView的inset恢复到键盘弹起前
        if (kbMgr.containerView != _contatinerView) {
            if ([kbMgr.containerView isKindOfClass:[UIScrollView class]]) {
                [(UIScrollView *)(kbMgr.containerView) restoreContentInset];
            } else {
                //todo:
                //[kbMgr.containerView restoreTop];
            }
        }
        kbMgr.containerView = _contatinerView;
    }
}

- (void)keyboardDidChangedFrame:(NSNotification *)notification
{
    if ([self isScrollableContainerView]) {
        [self updateScrollableContainerViewContentOffset];
        [self updateScrollableContainerViewContentInset];
    } else {
        //todo
        //[self updateContainerViewFrame];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    NSLog(@"===========%@--%@", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
    if ([self isScrollableContainerView]) {
        [self restoreScrollableContainerViewContentInsetIfNeeded];
    } else {
        //todo
        //[self restoreNormalViewTop]
    }
    _contatinerView = nil;
    _keyWindow = nil;
    _isTextEditing = NO;
}

#pragma mark - Private

- (void)updateScrollableContainerViewContentOffset
{
    AJXKeyboardManager *kbMgr = [AJXKeyboardManager defaultKeyboardManager];
    if (kbMgr.isKeyboardVisible && [self isScrollableContainerView] && _isTextEditing) {
        UIScrollView *scrollableContainerView = (UIScrollView *)_contatinerView;
        CGRect textViewFrameInWindow = [self.superview convertRect:self.frame toView:_keyWindow];
        CGFloat offsetNeededToTranslate = CGRectGetMaxY(textViewFrameInWindow) - CGRectGetMinY(kbMgr.keyboardFrame);
        
        if (offsetNeededToTranslate > 0) {
            CGPoint oldContentOffset = scrollableContainerView.contentOffset;
            CGFloat newOffset = oldContentOffset.y + offsetNeededToTranslate;
            scrollableContainerView.contentOffset = CGPointMake(oldContentOffset.x, newOffset);
        }
    }
}

- (void)updateScrollableContainerViewContentInset
{
    AJXKeyboardManager *kbMgr = [AJXKeyboardManager defaultKeyboardManager];
    if (kbMgr.isKeyboardVisible && [self isScrollableContainerView] && _isTextEditing) {
        UIScrollView *scrollableContainerView = (UIScrollView *)_contatinerView;
        CGRect tableFrameInWindow = [scrollableContainerView.superview convertRect:scrollableContainerView.frame toView:_keyWindow];
        CGRect tableAndKeyboardInsectRect = CGRectIntersection(tableFrameInWindow, kbMgr.keyboardFrame);
        CGFloat intersectionHeight = CGRectIsNull(tableAndKeyboardInsectRect) ? 0 : tableAndKeyboardInsectRect.size.height;
        
        UIEdgeInsets oldContentInset = [scrollableContainerView ajxKeyboardOldContentInset];
        scrollableContainerView.contentInset = UIEdgeInsetsMake(oldContentInset.top,
                                                        oldContentInset.left,
                                                        oldContentInset.bottom + intersectionHeight,
                                                        oldContentInset.right);
    }
}

- (void)restoreScrollableContainerViewContentInsetIfNeeded
{
    AJXKeyboardManager *kbMgr = [AJXKeyboardManager defaultKeyboardManager];
    //键盘消失后才恢复scrollableView的contentInset，在scrollableView内部的textView间切换时不恢复scrollableView的contentInset
    if (!(kbMgr.isKeyboardVisible) && [self isScrollableContainerView]) {
        UIScrollView *scrollableContainerView = (UIScrollView *)_contatinerView;
        [scrollableContainerView restoreContentInset];
    }
}

#pragma mark - Private 

//包括UIScrollView和UITableView两种情况
- (BOOL)isScrollableContainerView
{
    return _contatinerView && [_contatinerView isKindOfClass:[UIScrollView class]];
}

@end
