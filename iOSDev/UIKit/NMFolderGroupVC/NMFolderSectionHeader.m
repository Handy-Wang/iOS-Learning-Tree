//
//  NMFolderSectionHeader.m
//  iOSDev
//
//  Created by Handy on 9/28/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "NMFolderSectionHeader.h"

@interface NMFolderSectionHeader ()
@end

@implementation NMFolderSectionHeader

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addTarget:self action:@selector(didTap) forControlEvents:UIControlEventTouchUpInside];
        self.backgroundColor = [UIColor whiteColor];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}

- (void)didTap
{
    if ([self.delegate respondsToSelector:@selector(didSectionHeader:)]) {
        [self.delegate didSectionHeader:_model];
    }
}

@end