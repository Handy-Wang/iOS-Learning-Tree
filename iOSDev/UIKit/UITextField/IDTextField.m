//
//  IDTextField.m
//  iOSDev
//
//  Created by Handy on 10/24/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "IDTextField.h"
#import <objc/runtime.h>

@interface IDTextField() {
    int _count;
}
@end

@implementation IDTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
    }
    return self;
}

//输入模式过程中不调用此方法，切换到非输入模式时才会调用此方法
- (void)drawTextInRect:(CGRect)rect {
    NSLog(@"Before %@--%@, textSize %@, rect %@",
          NSStringFromClass(self.class), NSStringFromSelector(_cmd), NSStringFromCGSize(self.textSize), NSStringFromCGRect(rect));

    CGRect renderRect = CGRectMake(0, 0, self.textSize.width, self.textSize.height);
    [self.text drawInRect:renderRect withAttributes:@{NSFontAttributeName:self.font}];
    
    NSLog(@"After %@--%@, textSize %@, rect %@",
          NSStringFromClass(self.class), NSStringFromSelector(_cmd), NSStringFromCGSize(self.textSize), NSStringFromCGRect(renderRect));
}

////进入编辑模式时调用
- (CGRect)editingRectForBounds:(CGRect)bounds {
    CGRect editingRect = [super textRectForBounds:bounds];
    NSLog(@"Before editingRect %@--%@, textSize %@, editingRect %@, bounds %@",
          NSStringFromClass(self.class), NSStringFromSelector(_cmd), NSStringFromCGSize(self.textSize),
          NSStringFromCGRect(editingRect), NSStringFromCGRect(bounds));
    
    CGRect renderRect = self.bounds;
    
    NSLog(@"After editingRect %@--%@, textSize %@, editingRect %@, bounds %@",
          NSStringFromClass(self.class), NSStringFromSelector(_cmd), NSStringFromCGSize(self.textSize),
          NSStringFromCGRect(renderRect), NSStringFromCGRect(bounds));
    
    return renderRect;
}

@end
