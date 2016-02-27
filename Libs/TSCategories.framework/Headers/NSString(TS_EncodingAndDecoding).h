//
//  NSString(TS_EncodingAndDecoding).h
//  HGShopAssistant
//
//  Created by XiaoShan on 10/11/15.
//  Copyright © 2015 Higegou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(TS_EncodingAndDecoding)

- (NSString *)ts_toURLEncodedString;

- (NSString *)ts_toURLDecodedString;

- (NSString *)ts_toMD5EncodedString;

@end
