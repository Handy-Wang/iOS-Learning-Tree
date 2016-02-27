//
//  IDNSCacheVC.m
//  iOSDev
//
//  Created by XiaoShan on 2/26/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "IDNSCacheVC.h"
#import "IDCacheItem.h"

@interface IDNSCacheVC ()

@property (nonatomic, strong, nonnull) NSCache *cache;

@end

@implementation IDNSCacheVC

- (void)viewDidLoad {
    [super viewDidLoad];

    _cache = [[NSCache alloc] init];
    [_cache setObject:[IDCacheItem new] forKey:@"key1"];
    [_cache setEvictsObjectsWithDiscardedContent:NO];//Default YES
}

@end