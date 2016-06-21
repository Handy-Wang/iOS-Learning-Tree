//
//  IDTableVC.m
//  iOSDev
//
//  Created by Handy on 5/26/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "IDTableVC.h"

@interface IDTableVC () <UITableViewDataSource, UITableViewDelegate> {
    UITableView *_tableview;
}
@end

@implementation IDTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self.view addSubview:[self tableview]];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@, %@", NSStringFromSelector(_cmd), [@(indexPath.row) stringValue]);
    
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    CGFloat r = arc4random()%255/255.0f;
    CGFloat g = arc4random()%255/255.0f;
    CGFloat b = arc4random()%255/255.0f;
    UIColor *bgColor = [UIColor colorWithRed:r green:g blue:b alpha:1];
    cell.backgroundColor = bgColor;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@, %@", NSStringFromSelector(_cmd), [@(indexPath.row) stringValue]);
    return 200;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@, %@", NSStringFromSelector(_cmd), [@(indexPath.row) stringValue]);
    return 200;
}

#pragma mark - Getter & Setter

- (UITableView *)tableview {
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableview.dataSource = self;
        _tableview.delegate = self;
    }

    return _tableview;
}

@end
