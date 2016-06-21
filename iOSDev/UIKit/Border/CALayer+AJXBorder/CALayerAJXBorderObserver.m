//
//  CALayerAJXBorderObserver.m
//  Pods
//
//  Created by Handy on 6/17/16.
//
//

#import "CALayerAJXBorderObserver.h"

@interface CALayerAJXBorderObserver ()
@property (nonatomic, copy) CALayerAJXBorderObserverDeallocBlock deallocBlock;
@property(nonatomic, assign) __unsafe_unretained CALayer<CALayerAJXBorderObserverDelegate> *layer;
@end

@implementation CALayerAJXBorderObserver

- (instancetype)initWithLayer:(CALayer<CALayerAJXBorderObserverDelegate> *)layer andDeallocBlock:(CALayerAJXBorderObserverDeallocBlock)deallocBlock
{
    if (self = [super init]) {
        self.layer = layer;
        self.deallocBlock = [deallocBlock copy];
    }
    return self;
}

- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSString*, id> *)change context:(nullable void *)context
{
    if ([_layer respondsToSelector:@selector(ajx_observeValueForKeyPath:ofObject:change:context:)]) {
        [_layer ajx_observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)dealloc
{
    if (_deallocBlock) {
        _deallocBlock(_layer, self);
        _deallocBlock = nil;
    }
}

@end
