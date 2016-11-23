//
//  AJXKeyboardManager.h
//  iOSDev
//
//  Created by Handy on 11/22/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kAjxKeyboardDidChangeFrameNotification      (@"kAjxKeyboardDidChangeFrameNotification")

@interface AJXKeyboardManager : NSObject
@property (nonatomic, assign, readonly) CGRect keyboardFrame;
@property (nonatomic, assign, readonly) BOOL isKeyboardVisible;

+ (instancetype)defaultKeyboardManager;

@end
