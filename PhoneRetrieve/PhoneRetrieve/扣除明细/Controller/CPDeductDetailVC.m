//
//  CPDeductDetailVC.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/4/4.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPDeductDetailVC.h"
#import "CPRewardHeader.h"
#import "CPLeftRightCell.h"
#import "CPDeductDetailCell.h"
#import "CPDeductDetailModel.h"
#import "CPConsignResultVC.h"

@interface CPDeductDetailVC ()

@end

@implementation CPDeductDetailVC

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
    return self.models.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    CPDeductDetailDataModel *deductDetailModel = self.models[section];
    return deductDetailModel.info.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 4 * SMALL_CELL_HEIGHT_F + 2 * CPTOP_BOTTOM_OFFSET_F;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentify = @"CPShippingListCell";
    
    CPDeductDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (nil == cell) {
        cell = [[CPDeductDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        //        cell.clipsToBounds = YES;
        cell.shouldShowBottomLine = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //        cell.contentView.backgroundColor = tableView.backgroundColor;
    }
    
    CPDeductDetailDataModel *dataModel = self.models[indexPath.section];
    cell.model = dataModel.info[indexPath.row];

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CELL_HEIGHT_F;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    NSString *headerIdentify = @"headerIdentify";
    
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentify];
    CPLeftRightCell *cell = [header.contentView viewWithTag:CPBASETAG];
    if (!header) {
        header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerIdentify];
        header.contentView.backgroundColor = [UIColor whiteColor];
        
        cell       = [[CPLeftRightCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"CPTitleDetailCell"];
        cell.tag   = CPBASETAG;
        cell.title = @"待支付数量：50";
        cell.frame = CGRectMake(0, 0, SCREENWIDTH, CELL_HEIGHT_F);
        cell.detailTextLabel.attributedText = cp_commonRedAttr(@"待支付金额: ", @"¥53631.00");
        
        [header.contentView addSubview:cell];
    }
    
    CPDeductDetailDataModel *dataModel = self.models[section];
    
    cell.title =  dataModel.createtime;
    NSString *priceStr = [NSString stringWithFormat:@"扣除金额：¥%.2f",dataModel.total_price];
    cell.detailTextLabel.text = priceStr;

    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CPDeductDetailDataModel *dataModel = self.models[indexPath.section];
    CPDeductDetailInfoModel *infoModel = dataModel.info[indexPath.row];
    
    CPConsignResultVC *vc = [[CPConsignResultVC alloc] init];
    vc.ID = infoModel.orderid;
    vc.title = @"交易订单详情";
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)loadData {
    
    __weak typeof(self) weakSelf = self;
    
    NSDictionary *params = @{
                             @"code" : @([CPUserInfoModel shareInstance].loginModel.ID),
                             @"pagesize" : @"20",
                             @"currentpage" : @(self.currentPageIndex)
                             };

    [CPDeductDetailModel modelRequestWith:DOMAIN_ADDRESS@"api/Order/getDeductTheDetailsList"
                               parameters:params
                                    block:^(CPDeductDetailModel *result) {
                                        [weakSelf handleLoadDataSuccessBlock:result];
                                    } fail:^(CPError *error) {
                                        
                                    }];
}

- (void)handleLoadDataSuccessBlock:(CPDeductDetailModel *)result {
    
    if (!result.data ||
        ![result isKindOfClass:[CPDeductDetailModel class]] ||
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
