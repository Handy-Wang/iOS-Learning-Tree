//
//  IDNSDictionaryVC.m
//  iOSDev
//
//  Created by XiaoShan on 2/26/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "IDNSDictionaryVC.h"

@interface IDNSDictionaryVC ()

@end

@implementation IDNSDictionaryVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self testCopyKey];
}


/**
 *
 * 方法setObject:forKey:的key会被copy的原因：
 *      如果NSDictionary内部对key只是retain，那么NSDictionary的外部的某一个地方修改key值(注意是修改key栈地址指向的值内容不是修改key的栈地址而指向另外的值内容)后(其实这是对mutable类型的key才有意义，后面会讲！)，在NSDictionary外部的另一个地方用key的原值内容去Dictionary里获取相应的value数据时就找不到了，为了避免这一情况的发生，所以key是非常有必要被copy的.
 * 所以，这就是setObject:forKey:的定义中key是要求实现NSCopying的原因。
 *
 * 但是，我发现当key是immutable类型时，调用setObject:forKey:方法后，key在NSDictionary里的栈指针地址没有变。
 * 这是因为：immutable类型的key是不可能在“NSDictionary的外部的某一个地方修改key值”的，所以对于immutable类型的key来说不会发生上面我提到的问题。
 * 进而，一般在SDK中immutable类型的key被copy后返回的是原地址且引用计数加1，类似下面这样：
 
     - (instancetype)copy {
        return [self retain];
     }

 *  经验证，如NSString类型的对象copy后的指针仍为原指针。
 *  所以，要验证setObject:forKey:方法被调用后key指针变化了的话，key必须用mutable类型，如NSMutableString.
 *
 *  参考：http://stackoverflow.com/questions/2394083/cocoas-nsdictionary-why-are-keys-copied
 *
 */
- (void)testCopyKey {
    NSMutableString *key1 = [NSMutableString stringWithString:@"Username"];
    //这一步操作后key1的栈指针不变，而key1指向的值变了，这就是我上面说的“NSDictionary的外部的某一个地方修改key值”
//    [key1 appendString:@":"];
    NSString *value1 = @"handy";
    NSLog(@"key1:%p, value1:%p", key1, value1);
    
    NSString *key2 = @"age";
    NSString *value2 = @"18";
    NSLog(@"key2:%p, value2:%p \n\n", key2, value2);
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:value1 forKey:key1];
    [dic setObject:value2 forKey:key2];
    
    for (NSString *key in dic.allKeys) {
        NSString *value = dic[key];
        NSLog(@"key:%p, value:%p", key, value);
    }
}

@end
