//
//  AJXKBTextView.m
//  iOSDev
//
//  Created by Handy on 11/21/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "AJXKBTextView.h"
#import "UIView(AJXKeyboard).h"
#import "UIScrollView(AJXKeyboard).h"
#import "AJXKeyboardManager.h"

@interface AJXKBTextView() <UITextViewDelegate>
@property (nonatomic, assign) BOOL isTextEditing;
@property (nonatomic, weak) UIWindow *keyWindow;
@property (nonatomic, weak) UIView *contatinerView;
@property (nonatomic, assign) BOOL needUpdateFrameForNormalContainerView;
@end

@implementation AJXKBTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _needUpdateFrameForNormalContainerView = YES;
        //init keyboard manager
        [AJXKeyboardManager defaultKeyboardManager];
        self.delegate = self;
    }
    return self;
}

#pragma mark - UITextViewDelegate methods

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    _isTextEditing = YES;
    AJXKeyboardManager *kbMgr = [AJXKeyboardManager defaultKeyboardManager];
    kbMgr.editingTextView = self;
    
    if (kbMgr.isKeyboardVisible) {
        
        _keyWindow = [self ajxKeyWindow];
        
        //查找可滚动super view
        _contatinerView = [self ajxSuperScrollableView];
        
        //查找普通super view
        _contatinerView = _contatinerView ? : [self ajxSuperVCView];
        
        if ([self isScrollableContainerView]) {
            [((UIScrollView *)_contatinerView) cacheContentInset];
            [self updateScrollableContainerContentOffsetWhenKeyboardShow];
            [self updateScrollableContainerContentInset];
        } else {
            [_contatinerView ajxCacheInitFrame];
            [self updateNormalContainerFrameWhenKeyboardShow];
        }
        
        /**
         * 如果开启编辑时，当前输入框所属container与之前缓存在KBManager里的container不是同一个，
         * (说明在键盘没有收起的情况下，切换到了属于不同container的输入框)
         * 则需要把之前的container的inset或frame恢复到键盘弹起前
         */
        if (kbMgr.containerView != _contatinerView) {
            if ([kbMgr.containerView isKindOfClass:[UIScrollView class]]) {
                [(UIScrollView *)(kbMgr.containerView) restoreContentInset];
            } else {
                [kbMgr.containerView ajxRestoreInitFrame];
            }
        }
        kbMgr.containerView = _contatinerView;
    }
}

- (void)keyboardDidChangedFrame
{
    if ([self isScrollableContainerView]) {
        [self updateScrollableContainerContentOffsetWhenKeyboardFrameChanged];
        [self updateScrollableContainerContentInset];
    } else {
        [self updateNormalContainerFrameWhenKeyboardFrameChanged];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([self isScrollableContainerView]) {
        [self restoreScrollableContainerViewContentInset];
    } else {
        [self restoreContainerInitFrame];
    }
    
    _contatinerView = nil;
    _keyWindow = nil;
    _isTextEditing = NO;
    _needUpdateFrameForNormalContainerView = YES;
    AJXKeyboardManager *kbMgr = [AJXKeyboardManager defaultKeyboardManager];
    kbMgr.editingTextView = nil;
}

#pragma mark - Scrollable container view

- (void)updateScrollableContainerContentOffsetWhenKeyboardShow
{
    AJXKeyboardManager *kbMgr = [AJXKeyboardManager defaultKeyboardManager];
    if (kbMgr.isKeyboardVisible && [self isScrollableContainerView] && _isTextEditing && _needUpdateFrameForNormalContainerView) {
        UIScrollView *scrollableContainerView = (UIScrollView *)_contatinerView;
        CGRect textViewFrameInWindow = [self.superview convertRect:self.frame toView:_keyWindow];
        CGFloat offsetNeededToTranslate = CGRectGetMaxY(textViewFrameInWindow) - CGRectGetMinY(kbMgr.keyboardFrame);
        
        if (offsetNeededToTranslate > 0) {
            CGPoint oldContentOffset = scrollableContainerView.contentOffset;
            CGFloat newOffset = oldContentOffset.y + offsetNeededToTranslate;
            scrollableContainerView.contentOffset = CGPointMake(oldContentOffset.x, newOffset);
        } else {
            _needUpdateFrameForNormalContainerView = NO;
        }
    }
}

- (void)updateScrollableContainerContentOffsetWhenKeyboardFrameChanged
{
    AJXKeyboardManager *kbMgr = [AJXKeyboardManager defaultKeyboardManager];
    if (kbMgr.isKeyboardVisible && [self isScrollableContainerView] && _isTextEditing  && _needUpdateFrameForNormalContainerView) {
        UIScrollView *scrollableContainerView = (UIScrollView *)_contatinerView;
        CGRect textViewFrameInWindow = [self.superview convertRect:self.frame toView:_keyWindow];
        CGFloat offsetNeededToTranslate = CGRectGetMaxY(textViewFrameInWindow) - CGRectGetMinY(kbMgr.keyboardFrame);
        
        CGPoint oldContentOffset = scrollableContainerView.contentOffset;
        CGFloat newOffset = oldContentOffset.y + offsetNeededToTranslate;
        scrollableContainerView.contentOffset = CGPointMake(oldContentOffset.x, newOffset);
    }
}

- (void)updateScrollableContainerContentInset
{
    AJXKeyboardManager *kbMgr = [AJXKeyboardManager defaultKeyboardManager];
    if (kbMgr.isKeyboardVisible && [self isScrollableContainerView] && _isTextEditing) {
        UIScrollView *scrollableContainerView = (UIScrollView *)_contatinerView;
        CGRect tableFrameInWindow = [scrollableContainerView.superview convertRect:scrollableContainerView.frame toView:_keyWindow];
        CGRect tableAndKeyboardInsectRect = CGRectIntersection(tableFrameInWindow, kbMgr.keyboardFrame);
        CGFloat intersectionHeight = CGRectIsNull(tableAndKeyboardInsectRect) ? 0 : tableAndKeyboardInsectRect.size.height;
        
        UIEdgeInsets oldContentInset = [scrollableContainerView ajxOldContentInset];
        scrollableContainerView.contentInset = UIEdgeInsetsMake(oldContentInset.top,
                                                        oldContentInset.left,
                                                        oldContentInset.bottom + intersectionHeight,
                                                        oldContentInset.right);
    }
}

- (void)restoreScrollableContainerViewContentInset
{
    AJXKeyboardManager *kbMgr = [AJXKeyboardManager defaultKeyboardManager];
    //键盘消失后才恢复scrollableView的contentInset，在scrollableView内部的textView间切换时不恢复scrollableView的contentInset
    if (!(kbMgr.isKeyboardVisible) && [self isScrollableContainerView]) {
        UIScrollView *scrollableContainerView = (UIScrollView *)_contatinerView;
        [scrollableContainerView restoreContentInset];
    }
}

#pragma mark - Normal container view

- (void)updateNormalContainerFrameWhenKeyboardShow
{
    AJXKeyboardManager *kbMgr = [AJXKeyboardManager defaultKeyboardManager];
    if (kbMgr.isKeyboardVisible && ![self isScrollableContainerView] &&
        _isTextEditing && _needUpdateFrameForNormalContainerView) {
        
        CGRect textViewFrameInWindow = [self.superview convertRect:self.frame toView:_keyWindow];
        CGFloat offset = CGRectGetMaxY(textViewFrameInWindow) - CGRectGetMinY(kbMgr.keyboardFrame);
        
        if (offset > 0) {
            CGRect containerFrame = _contatinerView.frame;
            containerFrame.origin.y -= offset;
            _contatinerView.frame = containerFrame;
        } else {
            _needUpdateFrameForNormalContainerView = NO;
        }
    }
}

- (void)updateNormalContainerFrameWhenKeyboardFrameChanged
{
    AJXKeyboardManager *kbMgr = [AJXKeyboardManager defaultKeyboardManager];
    if (kbMgr.isKeyboardVisible && ![self isScrollableContainerView] &&
        _isTextEditing && _needUpdateFrameForNormalContainerView) {
        
        CGRect textViewFrameInWindow = [self.superview convertRect:self.frame toView:_keyWindow];
        CGFloat offset = CGRectGetMaxY(textViewFrameInWindow) - CGRectGetMinY(kbMgr.keyboardFrame);
        CGRect containerFrame = _contatinerView.frame;
        containerFrame.origin.y -= offset;
        _contatinerView.frame = containerFrame;
    }
}

- (void)restoreContainerInitFrame
{
    AJXKeyboardManager *kbMgr = [AJXKeyboardManager defaultKeyboardManager];
    if (!(kbMgr.isKeyboardVisible) && ![self isScrollableContainerView]) {
        [_contatinerView ajxRestoreInitFrame];
    }
}

#pragma mark - Private 

//包括UIScrollView和UITableView两种情况
- (BOOL)isScrollableContainerView
{
    return _contatinerView && [_contatinerView isKindOfClass:[UIScrollView class]];
}

@end
