//
//  CALayerAJXBorderObserver.h
//  Pods
//
//  Created by Handy on 6/17/16.
//
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#define kObservedFrameKeyPath               (@"bounds")

@class CALayerAJXBorderObserver;
typedef void(^CALayerAJXBorderObserverDeallocBlock)(CALayer *layer, CALayerAJXBorderObserver *ob);

@protocol CALayerAJXBorderObserverDelegate <NSObject>
- (void)ajx_observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object
                            change:(nullable NSDictionary<NSString*, id> *)change context:(nullable void *)context;
@end

@interface CALayerAJXBorderObserver : NSObject
- (instancetype)initWithLayer:(CALayer<CALayerAJXBorderObserverDelegate> *)layer andDeallocBlock:(CALayerAJXBorderObserverDeallocBlock)deallocBlock;
@end