//
//  IDTestObjX.m
//  iOSDev
//
//  Created by Handy on 6/20/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "IDTestObjX.h"

@implementation IDTestObjX

- (instancetype)initWithSubObj:(IDTestSubObjX *)subObj
{
    self = [super init];
    if (self) {
        self.name = @"handy";
        self.password = @"123456";
        self.subObj = subObj;
        NSLog(@"subObj1111111111 is %@", _subObj);
    }
    return self;
}

- (void)dealloc {
    NSLog(@"password1111 is %@", _password);
    NSLog(@"name is %@", _name);
    NSLog(@"password2222 is %@", _password);
    NSLog(@"subObj22222 is %@", _subObj);
    NSLog(@"self is %@", self);
}

@end
