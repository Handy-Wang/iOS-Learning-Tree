//
//  AJXKeyboardManager.m
//  iOSDev
//
//  Created by Handy on 11/22/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "AJXKeyboardManager.h"

@interface AJXKeyboardManager ()
@property (nonatomic, assign, readwrite) CGRect keyboardFrame;
@end

@implementation AJXKeyboardManager

+ (instancetype)defaultKeyboardManager
{
    static dispatch_once_t onceToken;
    static AJXKeyboardManager *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[AJXKeyboardManager alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _keyboardFrame = CGRectZero;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidChangedFrame:) name:UIKeyboardDidChangeFrameNotification object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 显示键盘

- (void)keyboardWillShow:(NSNotification *)notification
{
//    NSLog(@"===========%@--%@", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
//    NSLog(@"===========keyboard frame is %@", NSStringFromCGRect([self keyboardFrameFromNotification:notification]));
    _keyboardFrame = [self keyboardFrameFromNotification:notification];
    
    //记录刚显示keyboard的frame
}

- (void)keyboardDidShow:(NSNotification *)notification
{
//    NSLog(@"===========%@--%@", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
//    NSLog(@"===========keyboard frame is %@", NSStringFromCGRect([self keyboardFrameFromNotification:notification]));
}

#pragma mark - 键盘高度变化

- (void)keyboardDidChangedFrame:(NSNotification *)notification
{
//    NSLog(@"===========%@--%@", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
//    NSLog(@"===========keyboard frame is %@", NSStringFromCGRect([self keyboardFrameFromNotification:notification]));
    
    if ([self isKeyboardVisible]) {
        _keyboardFrame = [self keyboardFrameFromNotification:notification];
    }
    
    NSNotification *notify = [[NSNotification alloc] initWithName:kAjxKeyboardDidChangeFrameNotification
                                                           object:notification.object
                                                         userInfo:notification.userInfo];
    [[NSNotificationCenter defaultCenter] postNotification:notify];
}

#pragma mark - 隐藏键盘

- (void)keyboardWillHide:(NSNotification *)notification
{
//    NSLog(@"===========%@--%@", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
//    NSLog(@"===========keyboard frame is %@", NSStringFromCGRect([self keyboardFrameFromNotification:notification]));
    _keyboardFrame = CGRectZero;
}

- (void)keyboardDidHide:(NSNotification *)notification
{
//    NSLog(@"===========%@--%@", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
//    NSLog(@"===========keyboard frame is %@", NSStringFromCGRect([self keyboardFrameFromNotification:notification]));
}

#pragma mark - private methods

- (CGRect)keyboardFrameFromNotification:(NSNotification *)notification
{
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    return keyboardFrame;
}

- (BOOL)isKeyboardVisible
{
    return !CGRectIsEmpty(_keyboardFrame);
}

@end