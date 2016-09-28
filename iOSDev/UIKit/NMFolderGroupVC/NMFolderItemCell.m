//
//  NMFolderItemCell.m
//  iOSDev
//
//  Created by Handy on 9/28/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "NMFolderItemCell.h"

@implementation NMFolderItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor lightGrayColor];
    }
    return self;
}

@end
