//
//  IDTechListModel.h
//  iOSDev
//
//  Created by XiaoShan on 2/26/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "IDTechListItemModel.h"

@interface IDTechListModel : JSONModel

@property (nonatomic, strong) NSArray<Optional, IDTechListItemModel> *items;

@end
