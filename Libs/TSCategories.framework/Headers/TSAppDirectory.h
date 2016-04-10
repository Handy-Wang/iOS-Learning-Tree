//
//  TSAppDirectory.h
//  HGShopAssistant
//
//  Created by XiaoShan on 10/13/15.
//  Copyright © 2015 Higegou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TSAppDirectory : NSObject

+ (NSString *)ts_documentDirectory;

+ (NSString *)ts_cacheDirectory;

@end