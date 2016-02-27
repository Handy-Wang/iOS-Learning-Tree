//
//  NSString(TS_Compare).h
//  HGShopAssistant
//
//  Created by XiaoShan on 10/10/15.
//  Copyright © 2015 Higegou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(TS_Compare)

- (BOOL)ts_startWith:(NSString *)s1;

- (BOOL)ts_endWith:(NSString *)s1;

- (NSString *)ts_trim;

- (BOOL)ts_isEqualToStringIgnoreCase:(NSString *)aString;

@end