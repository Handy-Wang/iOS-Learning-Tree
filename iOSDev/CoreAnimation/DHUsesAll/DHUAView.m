//
//  DHUAView.m
//  iOSDev
//
//  Created by Handy on 6/21/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "DHUAView.h"
#import "DHUALayer.h"

@implementation DHUAView

+ (Class)layerClass {
    return [DHUALayer class];
}

- (nullable id<CAAction>)actionForLayer:(CALayer *)layer forKey:(NSString *)event {
    NSLog(@"actionForLayer:forKey, event : %@", event);
    id<CAAction> action = [super actionForLayer:layer forKey:event];
    NSLog(@"action is %@", action);
    
    return action;
}

@end
