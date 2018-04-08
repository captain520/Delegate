//
//  CPShopOrderVC.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/27.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPShopOrderVC.h"
#import "CPDeviceProblemCell.h"
#import "CPShippingInformationListVC.h"
#import "CPLeftRightCell.h"
#import "CPGoodOrderListVC.h"
#import "CPOrderTypeCell.h"
#import "CPRetrieveOrderListVC.h"

@interface CPShopOrderVC ()


@end

@implementation CPShopOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataArray = @[
//                       @[@"平台-结算订单-查询",@"平台-提交订单-查询",@"回首车-失效订单-查询",@"门店-回收订单-查询"]
                       @[@"交易订单",@"回收订单",@"失效订单"]
                       ];
    
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//    return self.models.count;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 1;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return cellSpaceOffset;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentify = @"CellIdentify";
    
    CPOrderTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[CPOrderTypeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.shouldShowBottomLine = NO;
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.backgroundColor = UIColor.clearColor;
    }
    
    cell.content = self.dataArray[indexPath.section][indexPath.row];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
            [self push2PlatPayStateVC];
            return;
        case 1:
            [self push2OrderListVC:CPGoodOrderListTypeCartOverDueOrder];
            return;
        case 2:
            [self push2OrderListVC:CPGoodOrderListTypeShopRetrieveOrder];
            return;

        default:
            break;
    }
    
    [self push2VCWith:@"CPGoodOrderListVC" title:@"CPGoodOrderListVC"];
}

//  跳转到支付状态列表页面
- (void)push2PlatPayStateVC {
    
    CPShippingInformationListVC *vc = [[CPShippingInformationListVC alloc] init];
    vc.title                    = @"平台结算订单";
    vc.tabbarType               = CPTabBarTypePayState;
    vc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:vc animated:YES];
    
    
    //    [self push2VCWith:@"CPShippingInformationListVC" title:@"订单"];
}

- (void)push2OrderListVC:(CPGoodOrderListType)type {
    
    CPRetrieveOrderListVC *vc = [[CPRetrieveOrderListVC alloc] init];
    if (type == CPGoodOrderListTypeCartOverDueOrder) {
        vc.title = @"回收订单";
    } else if (type == CPGoodOrderListTypeShopRetrieveOrder) {
        vc.title = @"失效订单";
    }
    
    [self.navigationController pushViewController:vc animated:YES];
}


@end
