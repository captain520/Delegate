//
//  CPBankListVC.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/4/11.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBankListVC.h"
#import "CPBankListModel.h"
#import "CPBankListCell.h"

@interface CPBankListVC ()

@end

@implementation CPBankListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.models.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 2 * CPTOP_BOTTOM_OFFSET_F + 3 * SMALL_CELL_HEIGHT_F;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdenitify = @"CPBankListCell";
    
    CPBankListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdenitify];
    if (!cell) {
        cell = [[CPBankListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdenitify];
        cell.shouldShowBottomLine = YES;
    }
    
    cell.model = self.models[indexPath.row];
    
    return cell;
}



- (void)loadData {
    
    __weak typeof(self) weakSelf = self;
    
    NSDictionary *params = @{
                             @"userid": @([CPUserInfoModel shareInstance].loginModel.ID),
                             @"userid": @(self.currentPageIndex),
                             @"userid": @"20"
                             };
    
    [CPBankListModel modelRequestWith:@"http://leshouzhan.platline.com/api/Userbank/findUserBankList"
                           parameters:params
                                block:^(id result) {
                                    [weakSelf handleLoadDataBlock:result];
                                } fail:^(CPError *error) {
                                    
                                }];
}

- (void)handleLoadDataBlock:(CPBankListModel *)result {
    
    if (!result.data ||
        ![result isKindOfClass:[CPBankListModel class]] ||
        ![result.data isKindOfClass:[NSArray class]]) {

        self.dataTableView.mj_footer.hidden = YES;

        [self.models removeAllObjects];
        
    } else {
        [self.models addObjectsFromArray:result.data];
    }
    
    if (self.models.count >= result.total) {
        [self.dataTableView.mj_header endRefreshing];
        [self.dataTableView.mj_footer endRefreshingWithNoMoreData];
    } else {
        [self.dataTableView.mj_header endRefreshing];
        [self.dataTableView.mj_footer endRefreshing];
    }
    
    [self.dataTableView reloadData];
}


@end
