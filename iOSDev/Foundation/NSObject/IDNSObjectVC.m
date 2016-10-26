//
//  IDNSObjectVC.m
//  iOSDev
//
//  Created by Handy on 10/26/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "IDNSObjectVC.h"
#import "BaseAnimal.h"
#import "SubPerson.h"

@interface IDNSObjectVC ()

@end

@implementation IDNSObjectVC

- (void)viewDidLoad {
    [super viewDidLoad];

    BOOL rst1 = [BaseAnimal conformsToProtocol:@protocol(MyProtocol)];
    NSLog(@"rst1 is %d", rst1);
    
    BOOL rst2 = [SubPerson conformsToProtocol:@protocol(MyProtocol)];
    NSLog(@"rst2 is %d", rst2);
}

@end
