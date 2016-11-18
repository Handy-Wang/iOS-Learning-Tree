//
//  NMFolderGroupVC.m
//  iOSDev
//
//  Created by Handy on 9/28/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "NMFolderCell.h"
#import "NMFolderGroupVC.h"
#import "NMFolderItemCell.h"
#import "NMFolderBaseCell.h"
#import "NMFolderBaseModel.h"
#import "NMFolderModel.h"
#import "NMFolderItemModel.h"
#import "NMFolderSectionHeader.h"

@interface NMFolderGroupVC () <UITableViewDataSource, UITableViewDelegate> {
    UITableView *_tableView;
    NSArray *_folderData;
}
@end

@implementation NMFolderGroupVC

#pragma mark - Lifecycle

- (void)viewDidLoad
{
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [_tableView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    
    [self getData];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([@"contentSize" isEqualToString:keyPath]) {
        id oldValue = [change objectForKey:NSKeyValueChangeOldKey];
        id newValue = [change objectForKey:NSKeyValueChangeNewKey];
        CGSize oldContentSize = CGSizeZero;
        [oldValue getValue:&oldContentSize];
        CGSize newContentSize = CGSizeZero;
        [newValue getValue:&newContentSize];
        
        if (!CGSizeEqualToSize(oldContentSize, newContentSize)) {
            NSLog(@"content size changed ===================>");
            UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100)];
            tableFooterView.backgroundColor = [UIColor redColor];
            _tableView.tableFooterView = tableFooterView;
        }
    }
}

- (void)dealloc
{
    [_tableView removeObserver:self forKeyPath:@"contentSize"];
}

#pragma mark - Private

- (void)getData
{
    NMFolderModel *folder1 = [[NMFolderModel alloc] init];
    folder1.title = @"文件夹1";
    
    NMFolderModel *folder2 = [[NMFolderModel alloc] init];
    folder2.title = @"文件夹2";
    
    _folderData = @[folder1, folder2];
    
    //---------------------------------------------------------
    NMFolderItemModel *item101 = [[NMFolderItemModel alloc] init];
    item101.title = @"文件1-01";
    
    NMFolderItemModel *item102 = [[NMFolderItemModel alloc] init];
    item102.title = @"文件1-02";
    
    NMFolderItemModel *item103 = [[NMFolderItemModel alloc] init];
    item103.title = @"文件1-03";
    
    NMFolderItemModel *item104 = [[NMFolderItemModel alloc] init];
    item104.title = @"文件1-04";
    
    NMFolderItemModel *item105 = [[NMFolderItemModel alloc] init];
    item105.title = @"文件1-05";
    
    NMFolderItemModel *item106 = [[NMFolderItemModel alloc] init];
    item106.title = @"文件1-06";
    
    NMFolderItemModel *item107 = [[NMFolderItemModel alloc] init];
    item107.title = @"文件1-07";
    
    NMFolderItemModel *item108 = [[NMFolderItemModel alloc] init];
    item108.title = @"文件1-08";
    
    NMFolderItemModel *item109 = [[NMFolderItemModel alloc] init];
    item109.title = @"文件1-09";
    
    NMFolderItemModel *item110 = [[NMFolderItemModel alloc] init];
    item110.title = @"文件1-10";
    
    NMFolderItemModel *item111 = [[NMFolderItemModel alloc] init];
    item111.title = @"文件1-11";
    
    NMFolderItemModel *item112 = [[NMFolderItemModel alloc] init];
    item112.title = @"文件1-22";
    
    NMFolderItemModel *item113 = [[NMFolderItemModel alloc] init];
    item113.title = @"文件1-13";
    
    NMFolderItemModel *item114 = [[NMFolderItemModel alloc] init];
    item114.title = @"文件1-14";
    
    NMFolderItemModel *item115 = [[NMFolderItemModel alloc] init];
    item115.title = @"文件1-15";
    
    NMFolderItemModel *item116 = [[NMFolderItemModel alloc] init];
    item116.title = @"文件1-16";
    
    NMFolderItemModel *item117 = [[NMFolderItemModel alloc] init];
    item117.title = @"文件1-17";
    
    NMFolderItemModel *item118 = [[NMFolderItemModel alloc] init];
    item118.title = @"文件1-18";
    
    NMFolderItemModel *item119 = [[NMFolderItemModel alloc] init];
    item119.title = @"文件1-19";
    
    NMFolderItemModel *item120 = [[NMFolderItemModel alloc] init];
    item120.title = @"文件1-20";
    
    folder1.items = @[item101, item102, item103, item104, item105, item106, item107, item108, item109, item110, item111, item112, item113, item114, item115, item116, item117, item118, item119, item120];
    
    //---------------------------------------------------------
    
    NMFolderItemModel *item21 = [[NMFolderItemModel alloc] init];
    item21.title = @"文件2-1";
    
    NMFolderItemModel *item22 = [[NMFolderItemModel alloc] init];
    item22.title = @"文件2-2";
    
    NMFolderItemModel *item23 = [[NMFolderItemModel alloc] init];
    item23.title = @"文件2-3";
    
    NMFolderItemModel *item24 = [[NMFolderItemModel alloc] init];
    item24.title = @"文件2-4";
    
    NMFolderItemModel *item25 = [[NMFolderItemModel alloc] init];
    item25.title = @"文件2-5";
    
    NMFolderItemModel *item26 = [[NMFolderItemModel alloc] init];
    item26.title = @"文件2-6";
    
    NMFolderItemModel *item27 = [[NMFolderItemModel alloc] init];
    item27.title = @"文件2-7";
    
    NMFolderItemModel *item28 = [[NMFolderItemModel alloc] init];
    item28.title = @"文件2-8";
    
    NMFolderItemModel *item29 = [[NMFolderItemModel alloc] init];
    item29.title = @"文件2-9";
    
    NMFolderItemModel *item210 = [[NMFolderItemModel alloc] init];
    item210.title = @"文件2-10";
    
    folder2.items = @[item21, item22, item23, item24, item25, item26, item27, item28, item29, item210];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _folderData.count;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@--%@, section:%ld, row:%ld", NSStringFromClass(self.class), NSStringFromSelector(_cmd), indexPath.section, indexPath.row);
    return 400;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 80;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@--%@, section:%ld, row:%ld", NSStringFromClass(self.class), NSStringFromSelector(_cmd), indexPath.section, indexPath.row);
    return 44;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NMFolderModel *folderModel = _folderData[section];
    NMFolderSectionHeader *sectionHeader = [[NMFolderSectionHeader alloc] init];
    sectionHeader.model = folderModel;
    sectionHeader.model.section = section;
    sectionHeader.delegate = self;
    [sectionHeader setTitle:folderModel.title forState:UIControlStateNormal];
    return sectionHeader;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rowsCount = 0;
    NMFolderModel *folderModel = _folderData[section];
    if (folderModel.state == NMFolderState_Open) {
        rowsCount = folderModel.items.count;
    }
    return rowsCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    NMFolderBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[NMFolderItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    NMFolderModel *folderModel = _folderData[indexPath.section];
    NMFolderItemModel *itemModel = folderModel.items[indexPath.row];
    [cell setModel:itemModel];
    
    return cell;
}

#pragma mark - NMFolderSectionHeaderDelegate

- (void)didSectionHeader:(NMFolderModel *)sectionHeaderModel
{
    NMFolderState oldState = sectionHeaderModel.state;
    sectionHeaderModel.state = oldState == NMFolderState_Open ? NMFolderState_Closed : NMFolderState_Open;
    [_tableView reloadData];
    
//    [_tableView beginUpdates];
//    NSMutableArray *indexPaths = [NSMutableArray array];
//    for (int i = 0; i < sectionHeaderModel.items.count; i++) {
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:sectionHeaderModel.section];
//        [indexPaths addObject:indexPath];
//    }
//    if (sectionHeaderModel.state == NMFolderState_Open) {
//        [_tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
//    } else {
//        [_tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
//    }
//    [_tableView endUpdates];
}

@end
