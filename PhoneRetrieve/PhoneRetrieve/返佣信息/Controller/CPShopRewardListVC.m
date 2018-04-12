//
//  CPShopRewardListVC.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/4/3.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPShopRewardListVC.h"
#import "CPRewardDetailCell.h"
#import "CPRewardHeader.h"
#import "CPOrderDetailVC.h"
#import "CPOrderSearchVC.h"
#import "CPConsignResultVC.h"

@interface CPShopRewardListVC ()


@end

@implementation CPShopRewardListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataArray = @[
                       @[@"",@"",@""],
                       @[@"",@"",@""]
                       ];
    
    [self setupUI];
    [self loadData];
}

- (void)setupUI {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:CPImage(@"search") style:UIBarButtonItemStylePlain target:self action:@selector(searchAction:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.models.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    CPRewardDataModel* rewardModel = self.models[section];
    
    return [rewardModel.info count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 3 * SMALL_CELL_HEIGHT_F + 2 * CPTOP_BOTTOM_OFFSET_F;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self configRewardDetailCell:indexPath];
}

- (id)configRewardDetailCell:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentify = @"CPRewardDetailCell";
    
    CPRewardDetailCell *cell = [self.dataTableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (nil == cell) {
        cell = [[CPRewardDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.clipsToBounds = YES;
    }
    
    CPRewardDataModel* rewardModel = self.models[indexPath.section];
    cell.model =  rewardModel.info[indexPath.row];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    NSString *headerIdentify = @"CPRewardHeader";
    
    CPRewardHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentify];
    if (!header) {
        header = [[CPRewardHeader alloc] initWithReuseIdentifier:headerIdentify];
        header.contentView.backgroundColor = UIColor.whiteColor;
    }
    
    header.model = self.models[section];
    
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CPRewardDataModel* rewardModel = self.models[indexPath.section];
    CPRewardInfoModel *infoModel =  rewardModel.info[indexPath.row];
    
    CPConsignResultVC *vc = [[CPConsignResultVC alloc] init];
    vc.ID = infoModel.orderid;
    vc.title = @"交易订单详情";
    
    [self.navigationController pushViewController:vc animated:YES];
    
//    CPOrderDetailVC *vc = [[CPOrderDetailVC alloc] init];
//    vc.orderID = @"319";
//
//    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -  返佣查询

- (void)searchAction:(UIButton *)sender {
    
    CPOrderSearchVC *searchVC = [[CPOrderSearchVC alloc] init];
    searchVC.title = @"返佣查询";
    searchVC.type = CPOrderSearchTypeReward;
    
    [self.navigationController pushViewController:searchVC animated:YES];
    
}

- (void)loadData {
    
    
    if (self.model) {
        [self handleLoadDataSuccessBlock:self.model];
        
        return;
    }

    __weak typeof(self) weakSelf = self;
    
    NSDictionary *params = @{
                             @"code" : @([CPUserInfoModel shareInstance].loginModel.ID),
                             @"pagesize" : @"20",
                             @"currentpage" : @(self.currentPageIndex)
                             };

    [CPRewardModel modelRequestWith:@"http://leshouzhan.platline.com/api/Distributionorder/getDistributionList"
                       parameters:params
                            block:^(CPRewardModel *result) {
                                [weakSelf handleLoadDataSuccessBlock:result];
                            } fail:^(CPError *error) {
                                
                            }];
}

- (void)handleLoadDataSuccessBlock:(CPRewardModel *)result {
    

    if (!result.data || ![result isKindOfClass:[CPRewardModel class]]|| ![result.data isKindOfClass:[NSArray class]]) {
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
