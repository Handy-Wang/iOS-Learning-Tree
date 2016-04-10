//
//  HDPerson.m
//  RunLoopXX
//
//  Created by XiaoShan on 2/22/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "HDPerson.h"

@implementation HDPerson

+ (void)initialize {
}

+ (void)load {
}

- (instancetype)init {
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)setUsername:(NSString *)username {
    _username = username;
    NSLog(@"%@ - %@", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
}

@end