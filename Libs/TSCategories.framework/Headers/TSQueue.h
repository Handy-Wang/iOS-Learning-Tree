//
//  TSQueue.h
//  EHaiTao-Master
//
//  Created by XiaoShan on 12/13/14.
//  Copyright (c) 2014 北京启能万维科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSQueue : NSObject
@property (nonatomic, assign, readonly) NSUInteger count;

/**
 *  入队
 *
 *  @param data 数据
 */
- (void)enqueue:(id)data;

/**
 *  出队
 *
 *  @return 数据
 */
- (id)dequeue;

@end