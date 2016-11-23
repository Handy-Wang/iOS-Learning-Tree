//
//  IDSelectCellTextView.m
//  iOSDev
//
//  Created by Handy on 11/21/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "IDSelectCellTextView.h"
#import "UIView(AJXKeyboard).h"
#import "UIWindow(AJXKeyboard).h"
#import "UITableView(AJXKeyboard).h"
#import "AJXKeyboardManager.h"

@interface IDSelectCellTextView() <UITextViewDelegate>
@property (nonatomic, assign) BOOL isTextEditing;
@property (nonatomic, weak) UIWindow *keyWindow;

@property (nonatomic, weak) UITableView *superTableView;
//@property (nonatomic, weak) UIScrollView *superScrollView;
@end

@implementation IDSelectCellTextView

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
    AJXKeyboardManager *kbMgr = [AJXKeyboardManager defaultKeyboardManager];
    NSLog(@"====Begin edit, kb frame %@...", NSStringFromCGRect(kbMgr.keyboardFrame));
    
    _isTextEditing = YES;
    if (kbMgr.isKeyboardVisible) {
        _keyWindow = [self ajxKeyWindow];
        _superTableView = [self ajxSuperTableView];
        if (_superTableView) {
            [_superTableView cacheContentInsetAndOffset];
        }
        
        if (_superTableView) {
            CGRect textViewFrameInWindow = [self.superview convertRect:self.frame toView:_keyWindow];
            CGFloat offset = CGRectGetMaxY(textViewFrameInWindow) - CGRectGetMinY(kbMgr.keyboardFrame);
            
            NSLog(@"BEGIN EDIT, offset %f", offset);
            if (offset > 0) {
                NSLog(@"update content offset.....");
                CGPoint oldContentOffset = _superTableView.contentOffset;
                _superTableView.contentOffset = CGPointMake(oldContentOffset.x, oldContentOffset.y + offset);
            }
            
            /**
             * 在键盘第一次显示后，无论输入框有没有被键盘挡住，都需要在tableview的原bottomInset上累加键盘的高度
             * 注：修改contentInset采用的是相对于键盘没有弹起时的contentInset来累加的，不是相对于tableView当前的contentInset来累加的
             */
            UIEdgeInsets oldContentInset = [_superTableView ajxKeyboardTableViewOldContentInset];
            _superTableView.contentInset = UIEdgeInsetsMake(oldContentInset.top,
                                                            oldContentInset.left,
                                                            oldContentInset.bottom + CGRectGetHeight(kbMgr.keyboardFrame),
                                                            oldContentInset.right);
        }
    }
}

- (void)keyboardDidChangedFrame:(NSNotification *)notification
{
    AJXKeyboardManager *kbMgr = [AJXKeyboardManager defaultKeyboardManager];
    NSLog(@"====Chagne frame, kb frame is %@...", NSStringFromCGRect(kbMgr.keyboardFrame));
    
    if (kbMgr.isKeyboardVisible && _superTableView && _isTextEditing) {
        
        CGRect textViewFrameInWindow = [self.superview convertRect:self.frame toView:_keyWindow];
        CGFloat offset = CGRectGetMaxY(textViewFrameInWindow) - CGRectGetMinY(kbMgr.keyboardFrame);
        
        if (offset >= 0) {
            CGFloat newOffset = _superTableView.contentOffset.y + offset;
            NSLog(@"KEYBOARD FRAME CHANGED, offset %f", newOffset);
            NSLog(@"update content offset.....");
            CGPoint oldContentOffset = _superTableView.contentOffset;
            _superTableView.contentOffset = CGPointMake(oldContentOffset.x, newOffset);
        }
        
        UIEdgeInsets oldContentInset = [_superTableView ajxKeyboardTableViewOldContentInset];
        CGFloat newInsetBottom = oldContentInset.bottom + CGRectGetHeight(kbMgr.keyboardFrame);
        _superTableView.contentInset = UIEdgeInsetsMake(oldContentInset.top,
                                                        oldContentInset.left,
                                                        newInsetBottom,
                                                        oldContentInset.right);
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    NSLog(@"===========%@--%@", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
    
    AJXKeyboardManager *kbMgr = [AJXKeyboardManager defaultKeyboardManager];
    if (!kbMgr.isKeyboardVisible) {
        [_superTableView restoreContentInsetAndOffset];
    }
    _superTableView = nil;
    _keyWindow = nil;
    _isTextEditing = NO;
}

@end
