//
//  IDNSCacheVC.m
//  iOSDev
//
//  Created by XiaoShan on 2/26/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "IDNSCacheVC.h"

@interface IDNSCacheVC ()

@end

@implementation IDNSCacheVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSCache *cache = [[NSCache alloc] init];
    [cache setObject:@"handy" forKey:@"wang"];
}

@end
