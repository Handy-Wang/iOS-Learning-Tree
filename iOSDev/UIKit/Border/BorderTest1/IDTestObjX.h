//
//  IDTestObjX.h
//  iOSDev
//
//  Created by Handy on 6/20/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "IDTestSubObjX.h"
#import <Foundation/Foundation.h>

@interface IDTestObjX : NSObject

@property (nonatomic, weak) NSString *name;
@property (nonatomic, assign) __unsafe_unretained NSString *password;
@property (nonatomic, weak) IDTestSubObjX *subObj;

- (instancetype)initWithSubObj:(IDTestSubObjX *)subObj;

@end
