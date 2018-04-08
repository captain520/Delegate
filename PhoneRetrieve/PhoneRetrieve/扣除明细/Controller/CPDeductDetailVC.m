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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
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
    
    //    cell.model = self.models[indexPath.section];
    
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
    
    cell.title = @"2018-03-14";
    NSString *priceStr = [NSString stringWithFormat:@"扣除金额：¥123.00"];
    cell.detailTextLabel.text = priceStr;

    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end
