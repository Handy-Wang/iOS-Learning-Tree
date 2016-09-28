//
//  NMFolderModel.m
//  iOSDev
//
//  Created by Handy on 9/28/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "NMFolderModel.h"

@implementation NMFolderModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _state = NMFolderState_Closed;
    }
    return self;
}

@end