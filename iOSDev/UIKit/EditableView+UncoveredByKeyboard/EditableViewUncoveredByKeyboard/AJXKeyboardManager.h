//
//  AJXKeyboardManager.h
//  iOSDev
//
//  Created by Handy on 11/22/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AJXKeyboardManager : NSObject
@property (nonatomic, assign, readonly) CGRect keyboardFrame;
@property (nonatomic, assign, readonly) BOOL isKeyboardVisible;
@property (nonatomic, weak) UIView *containerView;
@property (nonatomic, assign) CGRect containerViewInitFrame;//for class AJXKBTextView2

@property (nonatomic, weak) UITextView *editingTextView;
@property (nonatomic, weak) UITextField *editingTextField;

+ (instancetype)defaultKeyboardManager;

@end
