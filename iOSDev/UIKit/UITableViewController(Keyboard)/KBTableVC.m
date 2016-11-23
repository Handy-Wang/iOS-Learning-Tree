//
//  KBTableVC.m
//  iOSDev
//
//  Created by Handy on 5/26/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "KBTableVC.h"
#import "KBTableCell.h"
#import "KBTableView.h"

@interface KBTableVC ()
@property (nonatomic, strong) KBTableView *tableView1;
@property (nonatomic, strong) KBTableView *tableView2;
@end

@implementation KBTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self setEdgesForExtendedLayout:UIRectEdgeTop];
    [self.view addSubview:self.tableView1];
    [self.view addSubview:self.tableView2];
    
}

#pragma mark - Getter & Setter

- (UITableView *)tableView1 {
    if (!_tableView1) {
        _tableView1 = [[KBTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView1.ts_height = self.view.ts_height*0.8;
        _tableView1.ts_width = self.view.ts_width*0.5;
    }

    return _tableView1;
}

- (UITableView *)tableView2 {
    if (!_tableView2) {
        _tableView2 = [[KBTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView2.ts_left = self.view.ts_width*0.5;
        _tableView2.ts_height = self.view.ts_height*0.8;
        _tableView2.ts_width = self.view.ts_width*0.5;
    }
    
    return _tableView2;
}

@end
