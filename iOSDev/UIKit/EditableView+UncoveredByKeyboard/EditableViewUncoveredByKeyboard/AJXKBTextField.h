//
//  AJXKBTextField.h
//  iOSDev
//
//  Created by Handy on 11/24/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSTextField.h"

@interface AJXKBTextField : BSTextField
- (void)keyboardWillShow;
@end

@interface AJXKBTextField (AJXKeyboard)
- (void)textFieldDidBeginEditing:(UITextField *)textField;
- (void)textFieldDidEndEditing:(UITextField *)textField;
- (BOOL)textFieldShouldReturn:(UITextField *)textField;
@end

