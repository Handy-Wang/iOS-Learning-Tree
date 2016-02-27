//
//  IDBinaryTreeNode.h
//  iOSDev
//
//  Created by XiaoShan on 2/26/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDBinaryTreeNode : NSObject <NSCopying>

@property (nonatomic, strong) IDBinaryTreeNode *leftNode;
@property (nonatomic, strong) IDBinaryTreeNode *rightNode;
@property (nonatomic, copy) NSString *nodeName;

@end