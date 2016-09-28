//
//  NMTableView.h
//  iOSDev
//
//  Created by Handy on 9/22/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NMContainerView;

@interface NMTableView : UITableView
@property (nonatomic, assign) BOOL canScrollList;
@property (nonatomic, weak) NMContainerView *containerView;
@end
