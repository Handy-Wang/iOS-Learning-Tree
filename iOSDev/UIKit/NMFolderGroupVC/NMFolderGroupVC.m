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
    
//    UIView *tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
//    tableFooterView.backgroundColor = [UIColor redColor];
//    _tableView.tableFooterView = tableFooterView;
    
    
    [self getData];
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
    NMFolderItemModel *item11 = [[NMFolderItemModel alloc] init];
    item11.title = @"文件1-1";
    
    NMFolderItemModel *item12 = [[NMFolderItemModel alloc] init];
    item12.title = @"文件1-2";
    
    NMFolderItemModel *item13 = [[NMFolderItemModel alloc] init];
    item13.title = @"文件1-3";
    
    NMFolderItemModel *item14 = [[NMFolderItemModel alloc] init];
    item14.title = @"文件1-4";
    
    NMFolderItemModel *item15 = [[NMFolderItemModel alloc] init];
    item15.title = @"文件1-5";
    
    NMFolderItemModel *item16 = [[NMFolderItemModel alloc] init];
    item16.title = @"文件1-6";
    
    NMFolderItemModel *item17 = [[NMFolderItemModel alloc] init];
    item17.title = @"文件1-7";
    
    NMFolderItemModel *item18 = [[NMFolderItemModel alloc] init];
    item18.title = @"文件1-8";
    
    NMFolderItemModel *item19 = [[NMFolderItemModel alloc] init];
    item19.title = @"文件1-9";
    
    NMFolderItemModel *item111 = [[NMFolderItemModel alloc] init];
    item111.title = @"文件1-10";
    
    folder1.items = @[item11, item12, item13, item14, item15, item16, item17, item18, item19, item111];
    
    //---------------------------------------------------------
    
    NMFolderItemModel *item21 = [[NMFolderItemModel alloc] init];
    item21.title = @"文件2-1";
    
    NMFolderItemModel *item22 = [[NMFolderItemModel alloc] init];
    item22.title = @"文件2-2";
    
    NMFolderItemModel *item23 = [[NMFolderItemModel alloc] init];
    item23.title = @"文件2-3";
//    
//    NMFolderItemModel *item24 = [[NMFolderItemModel alloc] init];
//    item24.title = @"文件2-4";
//    
//    NMFolderItemModel *item25 = [[NMFolderItemModel alloc] init];
//    item25.title = @"文件2-5";
//    
//    NMFolderItemModel *item26 = [[NMFolderItemModel alloc] init];
//    item26.title = @"文件2-6";
//    
//    NMFolderItemModel *item27 = [[NMFolderItemModel alloc] init];
//    item27.title = @"文件2-7";
//    
//    NMFolderItemModel *item28 = [[NMFolderItemModel alloc] init];
//    item28.title = @"文件2-8";
//    
//    NMFolderItemModel *item29 = [[NMFolderItemModel alloc] init];
//    item29.title = @"文件2-9";
//    
//    NMFolderItemModel *item211 = [[NMFolderItemModel alloc] init];
//    item211.title = @"文件2-10";
    
    folder2.items = @[item21, item22, item23/*, item24, item25, item26, item27, item28, item29, item211*/];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _folderData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
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
    
    [_tableView beginUpdates];
    NSMutableArray *indexPaths = [NSMutableArray array];
    for (int i = 0; i < sectionHeaderModel.items.count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:sectionHeaderModel.section];
        [indexPaths addObject:indexPath];
    }
    if (sectionHeaderModel.state == NMFolderState_Open) {
        [_tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
    } else {
        [_tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
    }
    [_tableView endUpdates];
}

@end
