
//
//  IDBinaryTreeVC.m
//  iOSDev
//
//  Created by XiaoShan on 2/26/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "IDBinaryTreeVC.h"
#import "IDBinaryTreeNode.h"

@interface IDBinaryTreeVC ()

@end

@implementation IDBinaryTreeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *depthLabel = [[UILabel alloc] initWithFrame:self.view.bounds];
    depthLabel.numberOfLines = 0;
    depthLabel.textAlignment = NSTextAlignmentCenter;
    depthLabel.textColor = [UIColor greenColor];
    [self.view addSubview:depthLabel];
    
    IDBinaryTreeNode *root = [IDBinaryTreeNode new];
    IDBinaryTreeNode *rootLeftNode = [IDBinaryTreeNode new];
    rootLeftNode.nodeName = @"rootLeftNode";
    IDBinaryTreeNode *rootRightNode = [IDBinaryTreeNode new];
    rootRightNode.nodeName = @"rootRightNode";
    root.leftNode = rootLeftNode;
    root.rightNode = rootRightNode;
    root.nodeName = @"root node";
    
    IDBinaryTreeNode *rLeftNote = [IDBinaryTreeNode new];
    rLeftNote.nodeName = @"rLeftNote";
    IDBinaryTreeNode *rRightNode = [IDBinaryTreeNode new];
    rRightNode.nodeName = @"rRightNode";
    rootRightNode.leftNode = rLeftNote;
    rootRightNode.rightNode = rRightNode;

    int treeDepth1 = [self getTreeDepth:root];
    int treeDepth2 = [self getTreeDepthNonRecursive:root];
    depthLabel.text = [NSString stringWithFormat:@"二叉树深度遍历，递归算法，层级为：%d层\n二叉树深度遍历，非递归算法，层级为：%d层", treeDepth1, treeDepth2];
}

- (int)getTreeDepth:(IDBinaryTreeNode *)node {
    int depth = 0;
    
    if (!!node) {
        if (!(node.leftNode) && !(node.rightNode)) {//叶子节点
            depth++;
        } else {
            int leftDepth = [self getTreeDepth:node.leftNode];
            int rightDepth = [self getTreeDepth:node.rightNode];
            int tempDepth = MAX(leftDepth, rightDepth);
            tempDepth++;
            depth = tempDepth;
        }
    }
    
    return depth;
}

- (int)getTreeDepthNonRecursive:(IDBinaryTreeNode *)root {
    int depth = 0;

    NSMutableArray *stack = [NSMutableArray array];
    IDBinaryTreeNode *node = root;
    
    while (!!node || !!stack) {
        while (!!node) {
            [stack addObject:node];
            node = node.leftNode;
        }
        
        if (!!stack) {
            node = [stack lastObject];
            [stack removeLastObject];
            
            if (stack.count <= 0 && !(node.rightNode)) {
                stack = nil;
            }
            node = node.rightNode;
        }
    }
    
    return depth;
}

@end
