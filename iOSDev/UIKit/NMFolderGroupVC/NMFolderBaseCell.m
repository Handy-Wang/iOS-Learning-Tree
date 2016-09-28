//
//  NMFolderBaseCell.m
//  iOSDev
//
//  Created by Handy on 9/28/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "NMFolderBaseCell.h"

@implementation NMFolderBaseCell

- (void)setModel:(NMFolderBaseModel *)model
{
    _model = model;
    
    self.textLabel.text = _model.title;
}

@end
