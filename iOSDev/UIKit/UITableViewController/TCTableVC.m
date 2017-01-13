//
//  TCTableVC.m
//  iOSDev
//
//  Created by Handy on 5/26/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "TCTableVC.h"
#import "TCTableView.h"

#define kTCTableCellHeight              (100)
#define kBottomButtonsHeight            (88)

@interface TCTableVC () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) TCTableView *tableView;
@property (nonatomic, assign) NSUInteger sectionCount;
@property (nonatomic, assign) NSUInteger rowCount;
@property (nonatomic, strong) NSMutableArray *cellsHeight;
@property (nonatomic, strong) NSMutableArray *cellsBgColr;
@property (nonatomic, strong) UIButton *insetButton;
@end

@implementation TCTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self setEdgesForExtendedLayout:UIRectEdgeTop];
    
    self.sectionCount = 1;
    self.rowCount = 10;
    self.cellsHeight = [NSMutableArray array];
    self.cellsBgColr = [NSMutableArray array];
    for (int i = 0; i < self.rowCount; i++) {
        [self.cellsHeight addObject:@(kTCTableCellHeight+i*10)];
        CGFloat r = arc4random()%255/255.0f;
        CGFloat g = arc4random()%255/255.0f;
        CGFloat b = arc4random()%255/255.0f;
        UIColor *bgColor = [UIColor colorWithRed:r green:g blue:b alpha:1];
        [self.cellsBgColr addObject:bgColor];
    }
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.insetButton];
}

#pragma mark - Getter & Setter

- (UITableView *)tableView {
    if (!_tableView) {
        CGRect tableViewFrame = CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, self.view.bounds.size.height-kBottomButtonsHeight);
        _tableView = [[TCTableView alloc] initWithFrame:tableViewFrame style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }

    return _tableView;
}

- (UIButton *)insetButton
{
    if (!_insetButton) {
        _insetButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_insetButton setFrame:CGRectMake(0, _tableView.ts_bottom, _tableView.ts_width, kBottomButtonsHeight)];
        [_insetButton setTitle:@"setInset" forState:UIControlStateNormal];
        [_insetButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_insetButton setBackgroundColor:[UIColor whiteColor]];
        [_insetButton addTarget:self action:@selector(updateTableViewInset) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _insetButton;
}

- (void)updateTableViewInset
{
    NSLog(@"%@--%@", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
    
    CGFloat offset = ceil(296.33334);
    int offsetDistance = 44;
    
//    if (offset < offsetDistance) {
        CGRect oldBounds = _tableView.bounds;
        oldBounds.origin.y += offset;
        [_tableView setBounds:oldBounds];
        
        UIEdgeInsets oldInsets = _tableView.contentInset;
        oldInsets.bottom += (offset+1);
        [_tableView setContentInset:oldInsets];
        
//    } else {
//        int count = offset / offsetDistance;
//        int left = offset - count * offsetDistance;
//        if (left > 0) {
//            count++;
//        }
//        
//        CGFloat leftOffset = offset;
//        for (int i = 0; i < count; i++) {
//            CGFloat delta = leftOffset > offsetDistance ? offsetDistance : leftOffset;
//            
//            CGRect oldBounds = _tableView.bounds;
//            oldBounds.origin.y += delta;
//            [_tableView setBounds:oldBounds];
//            
//            UIEdgeInsets oldInsets = _tableView.contentInset;
//            oldInsets.bottom += delta;
//            [_tableView setContentInset:oldInsets];
//            
//            leftOffset -= delta;
//        }
//    }
    

}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%@--%@", NSStringFromClass(self.class), NSStringFromSelector(_cmd));
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
    
    UIColor *bgColor = self.cellsBgColr[indexPath.row];
    cell.backgroundColor = bgColor;
    cell.textLabel.text = [NSString stringWithFormat:@"row ------ %ld", (indexPath.row+1)];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.cellsHeight[indexPath.row] floatValue];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

    CGFloat oldHeight = [self.cellsHeight[indexPath.row] floatValue];
    oldHeight -= 40;
    self.cellsHeight[indexPath.row] = @(oldHeight);
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

@end
