//
//  UIImage(ImageName).h
//  HGShopAssistant
//
//  Created by XiaoShan on 10/26/15.
//  Copyright © 2015 Higegou. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TS_IMG(imageName)                              [UIImage imageNamed:imageName]

@interface UIImage(TS_ImageName)

+ (UIImage *)ts_imageNamed:(NSString *)name inBundle:(NSString *)bundleName;

@end
