//
//  CPRetrieveOrderListVC.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/4/4.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPRetrieveOrderListVC.h"
#import "CPRewardHeader.h"
#import "CPRetrieveDetailCell.h"
#import "CPOrderSearchVC.h"
#import "CPOrderDetailVC.h"
#import "CPDealOrderModel.h"

@interface CPRetrieveOrderListVC ()

@end

@implementation CPRetrieveOrderListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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
    
    CPRetrieveOrderDataModel *dataModel = self.models[section];

    return dataModel.info.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 3 * SMALL_CELL_HEIGHT_F + 2 * CPTOP_BOTTOM_OFFSET_F;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentify = @"CPShippingListCell";
    
    CPRetrieveDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (nil == cell) {
        cell = [[CPRetrieveDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        //        cell.clipsToBounds = YES;
        cell.shouldShowBottomLine = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //        cell.contentView.backgroundColor = tableView.backgroundColor;
    }
    
    CPRetrieveOrderDataModel *dataModel = self.models[indexPath.section];
    cell.type = self.type;
    cell.model = dataModel.info[indexPath.row];

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
    
    CPRetrieveOrderDataModel *dataModel = self.models[section];
    header.dataModel = dataModel;

    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CPRetrieveOrderDataModel *dataModel = self.models[indexPath.section];
    CPRetrieveOrderInfoModel *infoModel = dataModel.info[indexPath.row];;
    
    CPOrderDetailVC *vc = [[CPOrderDetailVC alloc] init];
    vc.orderID =  infoModel.ID;
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -  返佣查询

- (void)searchAction:(UIButton *)sender {
    
    
    __weak typeof(self) weakSelf = self;
    
    CPOrderSearchVC *searchVC = [[CPOrderSearchVC alloc] init];
    searchVC.searchDoneBlock = ^(id result) {
        [weakSelf handleSearchActionBlock:result];
    };
    if (self.type == CPRetrieveOrderListTypeSuccess) {
        searchVC.title = @"回收订单查询";
        searchVC.type = CPOrderSearchTypeOverFinishedOrder;
    } else if (self.type == CPRetrieveOrderListTypeFail) {
        searchVC.title = @"失效订单查询";
        searchVC.type = CPOrderSearchTypeOverDueOrder;
    }

    [self.navigationController pushViewController:searchVC animated:YES];
    
}

- (void)handleSearchActionBlock:(CPRetireveOrderModel *)result {
    
    [self.models removeAllObjects];
    
    if (!result.data ||
        ![result isKindOfClass:[CPRetireveOrderModel class]] ||
        ![result.data isKindOfClass:[NSArray class]]) {
        
        [self.models removeAllObjects];
        
    } else {
        [self.models addObjectsFromArray:result.data];
    }
    
    [self.dataTableView reloadData];
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
    
    NSString *requestUrl = nil;
    if (self.type == CPRetrieveOrderListTypeSuccess) {
        requestUrl = DOMAIN_ADDRESS@"api/order/getRecyclingInformation";
    } else if (self.type == CPRetrieveOrderListTypeFail) {
        requestUrl = DOMAIN_ADDRESS@"api/order/getFailureInformation";
    } else {
        
    }
    
    [CPRetireveOrderModel modelRequestWith:requestUrl
                         parameters:params
                              block:^(CPRetireveOrderModel *result) {
                                  [weakSelf handleLoadDataSuccessBlock:result];
                              } fail:^(CPError *error) {
                                  
                              }];
}

- (void)handleLoadDataSuccessBlock:(CPRetireveOrderModel *)result {
    
    
    if (!result.data ||
        ![result isKindOfClass:[CPRetireveOrderModel class]] ||
        ![result.data isKindOfClass:[NSArray class]]) {
        
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
