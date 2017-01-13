//
//  IDNSCacheVC.m
//  iOSDev
//
//  Created by XiaoShan on 2/26/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "IDNSCacheVC.h"
#import "IDCacheItem.h"

@interface IDNSCacheVC () <NSCacheDelegate>

@property (nonatomic, strong) NSCache<NSNumber *, __kindof UIImage *> *cache;

@end

@implementation IDNSCacheVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    NSString *file1 = [[NSBundle mainBundle] pathForResource:@"mountian" ofType:@"png"];
//    IDCacheItem *img1 = [[IDCacheItem alloc] initWithContentsOfFile:file1];
    
    /**
     *  实验NSCache对象在什么时候被移除和dealloc
     *
     *  totalCostLimit是这样描述的：This is not a strict limit, and if the cache goes over the limit, 
     *  an object in the cache could be evicted instantly, at a later point in time, or possibly never, 
     *  all depending on the implementation details of the cache.
     *
     *  所以，下面设置了缓存大小为一张图片的内存大小，后面的循环向NSCache里加入5张图片，
     *  由于缓存大小的限制，所以从日志可以看出来从加入第2张图片开始，
     *  每加一张后NSCache里的被加入的前一张图片就会被移除，如果被移除的图片没有别的地方引用，那么就会被dealloc.
     */
    
    _cache = [[NSCache alloc] init];
//    _cache.totalCostLimit = img1.size.width * img1.size.height * 4;//1张图所需内存
    _cache.delegate = self;
    [_cache setEvictsObjectsWithDiscardedContent:YES];//Default YES
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        int count = 5;
        
        for (int i = 0; i < count; i++) {
            NSString *file = [[NSBundle mainBundle] pathForResource:@"mountian" ofType:@"png"];
            IDCacheItem *img = [[IDCacheItem alloc] initWithContentsOfFile:file];
            
            if (!!img) {
                //这里的cost是用来计算cache被消耗的总大小的，与img的内存大小不一定是相等的，所以这个cost很假，
                //即，可以设置一个大数让cache很容易达到totalCostLimit，也可以设置一个相对小的数让cache不容易触发移除机制。
                [_cache setObject:img forKey:@(i) cost:img.size.width * img.size.height * 4];
                NSLog(@"Set cache img %d %@", i, img);
            }
        }
        
        for (int i = 0; i < count; i++) {
            IDCacheItem *img = [_cache objectForKey:@(i)];
            NSLog(@"Cache img %d %@", i, img);
        }
    });
}

- (void)cache:(NSCache *)cache willEvictObject:(id)obj {
    NSLog(@"Evict img %@", obj);
}

@end
