//
//  DHUALayer.m
//  iOSDev
//
//  Created by Handy on 6/21/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "DHUALayer.h"

@implementation DHUALayer

- (void)addAnimation:(CAAnimation *)anim forKey:(NSString *)key
{
    [super addAnimation:anim forKey:key];
    NSLog(@"------%@",[anim debugDescription]);
}

@end
