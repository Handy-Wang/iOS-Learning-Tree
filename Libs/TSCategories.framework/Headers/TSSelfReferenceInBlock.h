//
//  TSSelfReferenceInBlock.h
//  TSCategories
//
//  Created by XiaoShan on 12/26/15.
//  Copyright © 2015 Higegou. All rights reserved.
//

#ifndef TSSelfReferenceInBlock_h
#define TSSelfReferenceInBlock_h

#define TSWeakSelf typeof(self) __weak tsWeakSelf = self;
#define TSStrongSelf typeof(tsWeakSelf) __strong tsStrongSelf = tsWeakSelf;

#endif /* TSSelfReferenceInBlock_h */
