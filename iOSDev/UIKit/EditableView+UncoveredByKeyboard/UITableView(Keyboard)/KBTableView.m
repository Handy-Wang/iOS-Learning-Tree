//
//  KBTableView.m
//  iOSDev
//
//  Created by Handy on 11/23/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "KBTableView.h"
#import "KBTableCell.h"

@interface KBTableView() <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, assign) NSUInteger sectionCount;
@property (nonatomic, assign) NSUInteger rowCount;
@end

@implementation KBTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        self.dataSource = self;
        self.delegate = self;
        self.sectionCount = 1;
        self.rowCount = 8;
    }
    return self;
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
    KBTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[KBTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    CGFloat r = arc4random()%255/255.0f;
    CGFloat g = arc4random()%255/255.0f;
    CGFloat b = arc4random()%255/255.0f;
    UIColor *bgColor = [UIColor colorWithRed:r green:g blue:b alpha:1];
    cell.backgroundColor = bgColor;
    cell.isContainTetxtView = !!(indexPath.row % 2);
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kKBTableCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    CGRect cellFrame = [cell.superview convertRect:cell.frame toView:cell.window];
    NSLog(@"===========%@--%@, cell window frame is %@",
          NSStringFromClass(self.class), NSStringFromSelector(_cmd), NSStringFromCGRect(cellFrame));
    [self.window endEditing:YES];
}

@end
