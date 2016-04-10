//
//  IDBinaryTreeNode.m
//  iOSDev
//
//  Created by XiaoShan on 2/26/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "IDBinaryTreeNode.h"

@implementation IDBinaryTreeNode

- (id)copyWithZone:(nullable NSZone *)zone {
    IDBinaryTreeNode *node = [IDBinaryTreeNode new];
    node.leftNode = [self.leftNode copy];
    node.rightNode = [self.rightNode copy];
    node.nodeName = [self.nodeName copy];
    
    return node;
}

@end