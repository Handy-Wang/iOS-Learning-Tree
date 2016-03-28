//
//  IDProtocolBufferVC.m
//  iOSDev
//
//  Created by XiaoShan on 3/6/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "IDProtocolBufferVC.h"
#import "Person.pbobjc.h"

@interface IDProtocolBufferVC ()

@end

@implementation IDProtocolBufferVC

//参考：http://www.tanhao.me/code/150911.html/
/**
 * 注意：
 *      1)ProtocolBuffer是基于MRC的，所以在ARC项目中使用时需要-fno-objc-arc
 *      2)引入ProtocolBuffer的Generated目录后(实际上是当前项目下google/protobuf下的内容)，
 *      编译时可能会提示"duplicate symbol in ..."之类的错误，在“build phases/compile sources/”下删除位于“google/protobuf/”下的文件引用即可
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    Person *person = [Person new];
    person.name = @"Handy4Wong";
    person.sex = 1;
    person.age = 30;
    
    //序列化
    NSData *data = [person data];
    
    //反序列化
    Person *person2 = [Person parseFromData:data error:nil];
    NSLog(@"name:%@ sex:%d age:%d",person2.name,person2.sex,person2.age);
}

@end
