//
//  IDTableVC.m
//  iOSDev
//
//  Created by Handy on 5/26/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "IDTableVC.h"
#import "IDSelectCell.h"

@interface IDTableVC () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *cachedCells;
@end

@implementation IDTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    
    _cachedCells = [NSMutableArray array];
    [self.view addSubview:self.tableview];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 300;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"%@, %@", NSStringFromSelector(_cmd), [@(indexPath.row) stringValue]);
    
    static NSString *cellIdentifier = @"cellIdentifier";
    IDSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[IDSelectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        NSValue *cellValue = [NSValue valueWithNonretainedObject:cell];
        [_cachedCells addObject:cellValue];
    } else {
        NSUInteger reuseIndex = [_cachedCells indexOfObject:cell];
        NSLog(@"Reuseed cell %ld", reuseIndex);
    }
    
    CGFloat r = arc4random()%255/255.0f;
    CGFloat g = arc4random()%255/255.0f;
    CGFloat b = arc4random()%255/255.0f;
    UIColor *bgColor = [UIColor colorWithRed:r green:g blue:b alpha:1];
    cell.backgroundColor = bgColor;
    cell.textLabel.text = [NSString stringWithFormat:@"row ------ %ld", (indexPath.row+1)];
    
    NSLog(@"Cached cell pool length is %ld", _cachedCells.count);
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"%@, %@", NSStringFromSelector(_cmd), [@(indexPath.row) stringValue]);
    return 200;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"%@, %@", NSStringFromSelector(_cmd), [@(indexPath.row) stringValue]);
    return kIDSelectCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
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
