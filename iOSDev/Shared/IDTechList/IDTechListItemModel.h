//
//  IDTechListItemModel.h
//  iOSDev
//
//  Created by XiaoShan on 2/26/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

@protocol IDTechListItemModel <NSObject>

@end

@interface IDTechListItemModel : JSONModel

@property (nonatomic, copy) NSString<Optional> *title;
@property (nonatomic, copy) NSString<Optional> *className;

@end