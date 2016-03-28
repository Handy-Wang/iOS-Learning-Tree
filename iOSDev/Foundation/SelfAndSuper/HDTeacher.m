//
//  HDTeacher.m
//  RunLoopXX
//
//  Created by XiaoShan on 2/22/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "HDTeacher.h"

@implementation HDTeacher

+ (void)initialize {
}

+ (void)load {
}

- (instancetype)init {
    self = [super init];
    if (self) {
        NSLog(@"self class: %@, super class: %@, superClass: %@",
              NSStringFromClass(self.class), NSStringFromClass(super.class), NSStringFromClass(self.superclass));
    }
    return self;
}

- (void)setUsername:(NSString *)username {
    [super setUsername:username];
    NSLog(@"%@ - %@", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
}

@end
