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
    
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CPOrderDetailVC *vc = [[CPOrderDetailVC alloc] init];
    vc.orderID = @"319";
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -  返佣查询

- (void)searchAction:(UIButton *)sender {
    
    CPOrderSearchVC *searchVC = [[CPOrderSearchVC alloc] init];
    searchVC.title = @"返佣查询";
    
    [self.navigationController pushViewController:searchVC animated:YES];
    
}

@end
