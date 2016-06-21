//
//  IDBorderTest1.m
//  iOSDev
//
//  Created by Handy on 6/20/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "IDTestObjX.h"
#import "IDTestSubObjX.h"
#import "IDBorderTest1.h"
#import "IDBorderTest1Cell.h"

@interface IDBorderTest1 () <UITableViewDataSource, UITableViewDelegate> {
    UITableView *_tableView;
}
@end

@implementation IDBorderTest1

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    
    IDTestObjX *testObj = [[IDTestObjX alloc] initWithSubObj:[IDTestSubObjX new]];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 300;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    
    IDBorderTest1Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[IDBorderTest1Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    CGFloat left = arc4random() % 10;
    CGFloat top = arc4random() %10;
    CGFloat width = arc4random() % 200;
    CGFloat height = arc4random() %200;
    CGRect frame = CGRectMake(left, top, width, height);
    [cell updateSubViewFrame:frame indexPath:indexPath];
    
    return cell;
}

@end