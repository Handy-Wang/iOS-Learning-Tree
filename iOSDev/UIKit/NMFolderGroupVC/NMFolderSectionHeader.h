//
//  NMFolderSectionHeader.h
//  iOSDev
//
//  Created by Handy on 9/28/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NMFolderModel.h"

@class NMFolderSectionHeader;
@protocol NMFolderSectionHeaderDelegate <NSObject>

- (void)didSectionHeader:(NMFolderModel *)sectionHeaderModel;

@end

@interface NMFolderSectionHeader : UIButton

@property (nonatomic, weak) id delegate;
@property (nonatomic, strong) NMFolderModel *model;

@end
