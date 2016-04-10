//
//  IDPerson.m
//  iOSDev
//
//  Created by XiaoShan on 3/2/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "IDPerson.h"

@implementation IDPerson

- (id)copyWithZone:(nullable NSZone *)zone {
    IDPerson *tmpPerson = [IDPerson new];
    tmpPerson.name = self.name;
    
    return tmpPerson;
}

- (id)mutableCopyWithZone:(nullable NSZone *)zone {
    IDPerson *tmpPerson = [IDPerson new];
    tmpPerson.name = self.name;
    
    return tmpPerson;
}

@end
