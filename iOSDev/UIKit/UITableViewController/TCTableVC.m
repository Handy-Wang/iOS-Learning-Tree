//
//  TCTableVC.m
//  iOSDev
//
//  Created by Handy on 5/26/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "TCTableVC.h"

#define kTCTableCellHeight             (100)

@interface TCTableVC () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSUInteger sectionCount;
@property (nonatomic, assign) NSUInteger rowCount;
@end

@implementation TCTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self setEdgesForExtendedLayout:UIRectEdgeTop];
    
    self.sectionCount = 1;
    self.rowCount = 8;
    [self.view addSubview:self.tableView];
    
}

#pragma mark - Getter & Setter

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }

    return _tableView;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.sectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.rowCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    NSLog(@"%@, %@", NSStringFromSelector(_cmd), [@(indexPath.row) stringValue]);
    
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
    cell.textLabel.text = [NSString stringWithFormat:@"row ------ %ld", (indexPath.row+1)];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kTCTableCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    CGRect cellFrame = [cell.superview convertRect:cell.frame toView:cell.window];
    NSLog(@"===========%@--%@, cell window frame is %@",
          NSStringFromClass(self.class), NSStringFromSelector(_cmd), NSStringFromCGRect(cellFrame));
}

@end
