//
//  AJXKBTextField.m
//  iOSDev
//
//  Created by Handy on 11/24/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "AJXKBTextField.h"
#import "UIView(AJXKeyboard).h"
#import "UIScrollView(AJXKeyboard).h"
#import "AJXKeyboardManager.h"

@interface AJXKBTextField() <UITextFieldDelegate>
@property (nonatomic, weak) id outterDelegate;
@property (nonatomic, assign) BOOL isTextEditing;
@property (nonatomic, weak) UIWindow *keyWindow;
@property (nonatomic, weak) UIView *contatinerView;
@property (nonatomic, assign) BOOL needUpdateFrameForNormalContainerView;
@property (nonatomic, assign) BOOL hadUpdatedContainerFrameOnce;
@end

@implementation AJXKBTextField

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

- (void)setDelegate:(id<UITextViewDelegate>)delegate
{
    if (!delegate || delegate == self) {
        [super setDelegate:delegate];
    }
    
    if (delegate != self) {
        _outterDelegate = delegate;
    }
}

- (void)dealloc
{
    _outterDelegate = nil;
}

#pragma mark - UITextFieldDelegate methods

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
//    NSLog(@"11111111111");
    if ([_outterDelegate respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [_outterDelegate textFieldDidBeginEditing:textField];
    }
    
    _isTextEditing = YES;
    AJXKeyboardManager *kbMgr = [AJXKeyboardManager defaultKeyboardManager];
    kbMgr.editingTextField = self;
    
    /**
     * 对于UITextField来说，第一次点击textField进行输入时，会先调用textFieldDidBeginEditing，
     * 这时isKeyboardVisible为NO，然后系统会发出UIKeyboardWillShowNotification，
     * 即调用下面的keyboardWillShow方法；
     *
     * 当键盘不消失时(isKeyboardVisible=YES时)，切换不同textField时，iOS7.x/iOS8.x上新获得焦点的textField只会调用textFieldDidBeginEditing，系统不会发出UIKeyboardWillShowNotification，iOS 9.x及以上新获得焦点的textField会调用textFieldDidBeginEditing，系统有时会发出UIKeyboardWillShowNotification。
     *
     * 所以，为了兼容不同iOS版本，updateContainerFrameOnce里的逻辑只需调用一次
     */
    [self updateContainerFrameOnce];
}

- (void)keyboardWillShow
{
//    NSLog(@"2222222222222222222");
    [self updateContainerFrameOnce];
}

- (void)updateContainerFrameOnce
{
    AJXKeyboardManager *kbMgr = [AJXKeyboardManager defaultKeyboardManager];
    if (kbMgr.isKeyboardVisible && !_hadUpdatedContainerFrameOnce) {
//        NSLog(@"33333333333333");
        _hadUpdatedContainerFrameOnce = YES;
        
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

- (void)keyboardDidChangedFrame:(NSNotification *)notification
{
    if ([self isScrollableContainerView]) {
        [self updateScrollableContainerContentOffsetWhenKeyboardFrameChanged];
        [self updateScrollableContainerContentInset];
    } else {
        [self updateNormalContainerFrameWhenKeyboardFrameChanged];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([_outterDelegate respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [_outterDelegate textFieldDidEndEditing:textField];
    }
    
    if ([self isScrollableContainerView]) {
        [self restoreScrollableContainerViewContentInset];
    } else {
        [self restoreContainerInitFrame];
    }
    
    _contatinerView = nil;
    _keyWindow = nil;
    _isTextEditing = NO;
    _needUpdateFrameForNormalContainerView = YES;
    _hadUpdatedContainerFrameOnce = NO;
    AJXKeyboardManager *kbMgr = [AJXKeyboardManager defaultKeyboardManager];
    kbMgr.editingTextField = nil;
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
            //scrollableContainerView.contentOffset = CGPointMake(oldContentOffset.x, newOffset);
            
            //不触发scrollViewDidScroll的设置offset的方式
            CGRect scrollableContainerViewBounds = scrollableContainerView.bounds;
            scrollableContainerViewBounds.origin = CGPointMake(oldContentOffset.x, newOffset);
            scrollableContainerView.bounds = scrollableContainerViewBounds;
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
        //scrollableContainerView.contentOffset = CGPointMake(oldContentOffset.x, newOffset);
        
        //不触发scrollViewDidScroll的设置offset的方式
        CGRect scrollableContainerViewBounds = scrollableContainerView.bounds;
        scrollableContainerViewBounds.origin = CGPointMake(oldContentOffset.x, newOffset);
        scrollableContainerView.bounds = scrollableContainerViewBounds;
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

#pragma mark - Forward UITextFieldDelegate methods to outter delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    BOOL should = YES;
    if ([_outterDelegate respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        should = [_outterDelegate textFieldShouldBeginEditing:textField];
    }
    return should;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    BOOL should = YES;
    if ([_outterDelegate respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        should = [_outterDelegate textFieldShouldEndEditing:textField];
    }
    return should;
}

- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason
{
    if ([_outterDelegate respondsToSelector:@selector(textFieldDidEndEditing:reason:)]) {
        [_outterDelegate textFieldDidEndEditing:textField reason:reason];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    BOOL should = YES;
    if ([_outterDelegate respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
        should = [_outterDelegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    return should;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    BOOL should = YES;
    if ([_outterDelegate respondsToSelector:@selector(textFieldShouldClear:)]) {
        should = [_outterDelegate textFieldShouldClear:textField];
    }
    return should;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    BOOL should = NO;
    if ([_outterDelegate respondsToSelector:@selector(textFieldShouldReturn:)]) {
        should = [_outterDelegate textFieldShouldReturn:textField];
    }
    return should;
}

@end
