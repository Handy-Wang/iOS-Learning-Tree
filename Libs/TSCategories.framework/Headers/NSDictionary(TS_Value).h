//
//  NSDictionary(TS_Value).h
//  HGShopAssistant
//
//  Created by XiaoShan on 10/10/15.
//  Copyright © 2015 Higegou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary(TS_Value)

- (id)ts_objectForKey:(NSString *)key defalutObj:(id)defaultObj;

- (id)ts_objectForKey:(id)aKey ofClass:(Class)aClass defaultObj:(id)defaultObj;

- (int)ts_intValueForKey:(NSString *)key defaultValue:(int)defaultValue;

- (float)ts_floatValueForKey:(NSString *)key defaultValue:(float)defaultValue;

- (double)ts_doubleValueForKey:(NSString *)key defaultValue:(double)defaultValue;

- (long)ts_longValueForKey:(NSString *)key defaultValue:(long)defaultValue;

- (long long)ts_longlongValueForKey:(NSString *)key defaultValue:(long long)defaultValue;

- (NSString *)ts_stringValueForKey:(NSString *)key defaultValue:(NSString *)defaultValue;

- (NSArray *)ts_arrayValueForKey:(NSString *)key defaultValue:(NSArray *)defaultValue;

- (NSDictionary *)ts_dictionaryValueForKey:(NSString *)key defaultValue:(NSDictionary *)defaultValue;

@end
