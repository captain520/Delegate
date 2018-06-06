//
//  CPShippingStateVC.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/28.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPShippingStateVC.h"
#import "CPShopOrderDetailModel.h"
#import "CPTitleDetailCell.h"
#import "CPShippingListCell.h"
#import "CPOrderListPageModel.h"
#import "CPOrderSearchVC.h"
#import "CPConsignResultVC.h"

@interface CPShippingStateVC ()

@end

@implementation CPShippingStateVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.dataArray && self.dataArray.count > 0) {
        [self.dataTableView reloadData];
    } else {
        
        [self loadData];
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:CPImage(@"search") style:UIBarButtonItemStylePlain target:self action:@selector(searchAction:)];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView datasource && delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentify = @"CPShippingListCell";
    
    CPShippingListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (nil == cell) {
        cell = [[CPShippingListCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        //        cell.clipsToBounds = YES;
        cell.shouldShowBottomLine = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //        cell.contentView.backgroundColor = tableView.backgroundColor;
    }
    
    cell.logistModel = self.dataArray[indexPath.section];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CELL_HEIGHT_F;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    NSString *headerIdentify = @"headerIdentify";
    
    UITableViewHeaderFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentify];
    CPTitleDetailCell *cell = [footer.contentView viewWithTag:CPBASETAG];
    if (!footer) {
        footer = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerIdentify];
        footer.contentView.backgroundColor = [UIColor whiteColor];
        
        cell = [[CPTitleDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CPTitleDetailCell"];
        cell.shouldShowBottomLine = NO;
        cell.tag = CPBASETAG;
        cell.frame = CGRectMake(0, 0, SCREENWIDTH, CELL_HEIGHT_F);
        cell.actionBT.hidden = NO;
        cell.title = @"物流单号：";
        //        cell.content = @"92881828q12";
        cell.actionBT.hidden = YES;
//        [cell.actionBT addTarget:self action:@selector(push2ShippingStatesVC) forControlEvents:64];
        
        [footer.contentView addSubview:cell];
    }
    CPShopOrderDetailModel *sectionModel = self.dataArray[section];
    cell.content = sectionModel.logisticsno;
    
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {

    return cellSpaceOffset / 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DDLogInfo(@"--------------------");
    
    CPShopOrderDetailModel *sectionModel = self.dataArray[indexPath.section];
    
    CPConsignResultVC *vc = [[CPConsignResultVC alloc] init];
    vc.ID = sectionModel.ID;
    vc.title = @"交易订单详情";
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - private method

- (void)loadData {

    __weak typeof(self) weakSelf = self;
    
    [CPOrderListPageModel modelRequestWith:@"http://api.leshouzhan.com/api/Order/findOrderList"
                                  parameters:@{
                                               @"typeid" : @([CPUserInfoModel shareInstance].loginModel.Typeid),
                                               @"userid" : @([CPUserInfoModel shareInstance].loginModel.ID)
//                                               @"paycfg" : @(1)
                                               }
                                       block:^(CPOrderListPageModel *result) {
                                           [weakSelf handleLoadDataBlock:result];
                                       } fail:^(CPError *error) {
                                           
                                       }];
}

- (void)handleLoadDataBlock:(CPOrderListPageModel*)result {
    
    if (!result || result.cp_data.count == 0) {
        return;
    }

    self.dataArray = result.cp_data;

    [self.dataTableView reloadData];
}

- (void)searchAction:(id)sender {
    
    CPOrderSearchVC *vc = [[CPOrderSearchVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.title = @"订单物流信息查询";
    vc.type = CPOrderSearchTypeShipping;

    [self.navigationController pushViewController:vc animated:YES];
}

@end
