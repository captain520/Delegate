//
//  CPShopCheckVC.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/4/3.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPShopCheckVC.h"
#import "CPShopCheckUserInfoCell.h"
#import "CPPayInfoCell.h"
#import "CPSuccessVC.h"
#import "CPUserDetailInfoModel.h"

@interface CPShopCheckVC ()

@property (nonatomic, strong) CPButton *passBT, *refuseBT;
@property (nonatomic, strong) CPUserDetailInfoModel *model;

@end

@implementation CPShopCheckVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataArray = @[
                       @[@"",@"",@"",@"",@""]
                       ];
    
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
            return 270;
            break;
        case 1:
            return 295;
            break;
            
        default:
            break;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
            return [self configCheckUserInfoCell:indexPath];
            break;
        case 1:
            return [self configPayMethodCell:indexPath];
            break;
            
        default:
            break;
    }
    return [self configCheckUserInfoCell:indexPath];
}

- (CPShopCheckUserInfoCell *)configCheckUserInfoCell:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentify = @"CPShopCheckUserInfoCell";
    
    CPShopCheckUserInfoCell *cell = [self.dataTableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell =[[CPShopCheckUserInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.clipsToBounds = YES;
    }
    
    cell.model = self.model;
    
    return cell;
}

- (CPPayInfoCell *)configPayMethodCell:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentify = @"CPPayInfoCell";
    
    CPPayInfoCell *cell = [self.dataTableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[CPPayInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.clipsToBounds  = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.model = self.model;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CELL_HEIGHT_F;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if (0 == section) {
        return @"门店信息";
    } else if (1 == section) {
        return @"收款信息";
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 0.00000000001;
            break;
        case 1:
            return 100.0f;
            break;
        default:
            break;
    }
    
    return 0.00000000001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if (self.type == CPShopCheckTypeDetail) {
        return nil;
    }
    
    if (0 == section) {
        return nil;
    }
   
    NSString *headerIdentify = @"UITableViewHeaderFooterView";
    
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentify];
    if (!header) {
        header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerIdentify];
        header.contentView.backgroundColor = UIColor.clearColor;
        
        {
            self.passBT  = [CPButton new];
            
            [header.contentView addSubview:self.passBT];
            
            [self.passBT setTitle:@"审核通过" forState:0];
            [self.passBT addTarget:self action:@selector(pushSuccessVC) forControlEvents:64];
            [self.passBT mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(cellSpaceOffset);
                make.left.mas_equalTo(cellSpaceOffset);
//                make.right.mas_equalTo(-cellSpaceOffset);
                make.height.mas_equalTo(CELL_HEIGHT_F);
            }];
        }
        
        {
            self.refuseBT  = [CPButton new];
            self.refuseBT.type = CPButtonTypeDestructive;
            
            [header.contentView addSubview:self.refuseBT];
            
            [self.refuseBT setTitle:@"审核不通过" forState:0];
            [self.refuseBT addTarget:self action:@selector(refuseAction:) forControlEvents:64];
            [self.refuseBT mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(cellSpaceOffset);
                make.left.mas_equalTo(self.passBT.mas_right).offset(cellSpaceOffset);
                make.right.mas_equalTo(-cellSpaceOffset);
                make.width.mas_equalTo(self.passBT.mas_width);
                make.height.mas_equalTo(CELL_HEIGHT_F);
            }];
            
        }

    }
    
    return header;
}

- (void)pushSuccessVC {
    
    __weak typeof(self) weakSelf = self;
    
    NSDictionary *params = @{
                             @"userid" : @(self.model.ID),
                             @"operatorid" : @([CPUserInfoModel shareInstance].loginModel.ID),
                             @"operatorname" : [CPUserInfoModel shareInstance].loginModel.linkname
                             }.copy;

    [CPBaseModel modelRequestWith:@"http://api.leshouzhan.com/api/user/updateUserCheck"
                       parameters:params
                            block:^(id result) {
                                [weakSelf handleCheckPassBlock:result];
                            } fail:^(CPError *error) {
                                
                            }];
    
}

- (void)handleCheckPassBlock:(CPBaseModel *)result {

    CPSuccessVC *vc = [[CPSuccessVC alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)refuseAction:(id)sender  {
    
    __weak typeof(self) weakSelf = self;
    
    NSDictionary *params = @{
                             @"userid" : @(self.model.ID)
                             }.copy;
    
    [CPBaseModel modelRequestWith:@"http://api.leshouzhan.com/api/user/unUserCheck"
                       parameters:params
                            block:^(id result) {
                                [weakSelf handleCheckPassBlock:result];
                            } fail:^(CPError *error) {
                                
                            }];
}

- (void)handleRefuseBlock:(CPBaseModel *)result {
    
    [self.view makeToast:result.msg duration:1.0f position:CSToastPositionCenter];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadData {
    
    DDLogInfo(@"------------------------------");
    
    __weak typeof(self) weakSelf = self;
    
    [CPUserDetailInfoModel modelRequestWith:@"http://api.leshouzhan.com/api/user/getDetailUserInfo"
                                 parameters:@{@"userid" : self.userID}//@([CPUserInfoModel shareInstance].loginModel.ID)}
                                      block:^(CPUserDetailInfoModel *result) {
                                          [weakSelf handleLoadDataSuccessBlock:result];
                                      } fail:^(NSError *error) {
                                          
                                      }];
}

- (void)handleLoadDataSuccessBlock:(CPUserDetailInfoModel *)result {
    
    if (!result || ![result isKindOfClass:[CPUserDetailInfoModel class]]) {
        
        [self.view makeToast:result.msg duration:1.0f position:CSToastPositionCenter];
        
        return;
    }
    
    self.model = result;
    
    [self.dataTableView reloadData];
}

@end
