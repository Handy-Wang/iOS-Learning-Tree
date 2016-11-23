//
//  IDTableVC.m
//  iOSDev
//
//  Created by Handy on 5/26/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "IDTableVC.h"
#import "IDSelectCell.h"
#import "IDTableView.h"

@interface IDTableVC ()
@property (nonatomic, strong) IDTableView *tableView1;
@property (nonatomic, strong) IDTableView *tableView2;
@end

@implementation IDTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self setEdgesForExtendedLayout:UIRectEdgeTop];
    [self.view addSubview:self.tableview2];
    [self.view addSubview:self.tableview1];
    
}

#pragma mark - Getter & Setter

- (UITableView *)tableview1 {
    if (!_tableView1) {
        _tableView1 = [[IDTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView1.ts_height = self.view.ts_height*0.8;
        _tableView1.ts_width = self.view.ts_width*0.5;
    }

    return _tableView1;
}

- (UITableView *)tableview2 {
    if (!_tableView2) {
        _tableView2 = [[IDTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView2.ts_left = self.view.ts_width*0.5;
        _tableView2.ts_height = self.view.ts_height*0.8;
        _tableView2.ts_width = self.view.ts_width*0.5;
    }
    
    return _tableView2;
}

@end
