//
//  IDHomeListVC.m
//  iOSDev
//
//  Created by XiaoShan on 2/26/16.
//  Copyright © 2016 XiaoShan. All rights reserved.
//

#import "IDHomeListVC.h"
#import "IDTechListModel.h"

@interface IDHomeListVC ()

@property (nonatomic, strong) IDTechListModel *model;

@end

@implementation IDHomeListVC

#pragma mark - ################## Lifecycle ##################

- (instancetype)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithStyle:style]) {
        self.title = @"iOS Dev";
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSError *error = nil;
    NSStringEncoding encoding = 0;
    NSString *techListDataFilePath = [[NSBundle mainBundle] pathForResource:@"IDHomeList" ofType:@"json"];
    NSString *jsonStr = [NSString stringWithContentsOfFile:techListDataFilePath
                                              usedEncoding:&encoding
                                                     error:&error];
    
    if (!error && jsonStr.length > 0) {
        NSError *parseError = nil;
        NSDictionary *dicData = [jsonStr ts_toObject];
        _model = [[IDTechListModel alloc] initWithDictionary:dicData error:&parseError];
    }
}

#pragma mark - ################## Delegates ##################

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _model.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.row < _model.items.count) {
        IDTechListItemModel *itemModel = _model.items[indexPath.row];
        cell.textLabel.text = itemModel.title;
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < _model.items.count) {
        
        IDTechListItemModel *itemModel = _model.items[indexPath.row];
        Class itemClass = NSClassFromString(itemModel.className);
        UIViewController *vc = [[itemClass alloc] init];
        vc.title = itemModel.title;
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
