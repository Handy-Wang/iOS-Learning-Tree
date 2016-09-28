//
//  NMFolderModel.h
//  iOSDev
//
//  Created by Handy on 9/28/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NMFolderBaseModel.h"

typedef NS_ENUM(NSInteger, NMFolderState) {
    NMFolderState_Open,
    NMFolderState_Closed
};

@interface NMFolderModel : NMFolderBaseModel

@property (nonatomic, assign) NMFolderState state;
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, strong) NSArray *items;

@end
