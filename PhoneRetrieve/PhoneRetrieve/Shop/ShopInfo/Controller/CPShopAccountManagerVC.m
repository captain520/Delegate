//
//  CPShopAccountManagerVC.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/27.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPShopAccountManagerVC.h"
#import "CPTitleDetailCell.h"
#import "CPLeftRightCell.h"
#import "CPModifyShopInfoVC.h"
#import "CPShopAboutHeader.h"
#import "CPLoginVC.h"
#import "CPUserDetailInfoModel.h"
#import "CPChangeUserBaseInfoVC.h"

@interface CPShopAccountManagerVC ()<UIAlertViewDelegate>

@property (nonatomic, strong) NSArray *tempDataArray;

@end

@implementation CPShopAccountManagerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.u
    
    if (IS_SHOP) {
//        self.dataArray = @[
//                           @[@"门店名称:",
//                             @"门店编号:",
//                             @"门店负责人:",
//                             @"手机号码:",
//                             @"邮箱:"
//                             ],
//                           @[@"安全设置"],
//                           @[@"门店信息"]
//                           ];
        
        self.dataArray = @[
                           @[
                               @"账号信息:",
                               @"商家负责人:",
                               @"手机号码:",
                               @"邮   箱:",
                               @"地   址:"
                               ],
                           @[@"登陆密码"],
                           @[
                               //                               @"收款账号",
                               @"收款方式"
                               ],
                           ];
        
        self.tempDataArray = @[
                               //                               @[@"茂业店",@"332*****",@"********:",@"158****3123",@"wang****@163.com"],
                               @[
                                   [CPUserInfoModel shareInstance].loginModel.companyname,
                                   [CPUserInfoModel shareInstance].loginModel.cp_code,
                                   [CPUserInfoModel shareInstance].loginModel.linkname,
                                   [CPUserInfoModel shareInstance].loginModel.phone,
                                   [CPUserInfoModel shareInstance].loginModel.email
                                   ],
                               @[@"登陆密码"],
                               @[@"更改收款方式(支付宝)"]
                               ];
    } else {
        
        self.dataArray = @[
                           @[
                               @"账号信息:",
                               @"代理负责人:",
                               @"手机号码:",
                               @"邮   箱:",
                               @"地   址:"
                               ],
                           @[@"登陆密码"],
                           @[
//                               @"收款账号",
                               @"收款方式"
                               ],
                           ];
        
        self.tempDataArray = @[
                               @[@"茂业",@"332234",@"158****3123"],
                               @[@"登陆密码"]
                               ];
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CELL_HEIGHT_F;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id cell = nil;
    
    switch (indexPath.section) {
        case 0:
            cell = [self configShopInfoCell:indexPath];
            break;
            
        default:
            cell = [self configActionCell:indexPath];
            break;
    }
    
    return cell;
}

- (id)configShopInfoCell:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentify = @"CPTitleDetailCell";
    
    CPTitleDetailCell *cell = [self.dataTableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[CPTitleDetailCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
//    if (IS_ASSISTANT && indexPath.section == 0 && indexPath.row == 2) {
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    } else {
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    }
//
//    if (/*IS_SHOP && */indexPath.section == 0) {
//        if (indexPath.row == 0 || indexPath.row == 1) {
//            cell.contentColor = CPERROR_COLOR;
//        }
//    }
    
    cell.shouldShowBottomLine = indexPath.row != [self.dataArray[0] count] - 1;
    
    NSArray *tempArray = self.dataArray[indexPath.section];
    
    cell.title = [tempArray objectAtIndex:indexPath.row];;
    cell.content = self.tempDataArray[indexPath.section][indexPath.row];
    
    return cell;
}

- (id)configActionCell:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentify = @"CPLeftRightCell";
    
    CPLeftRightCell *cell = [self.dataTableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[CPLeftRightCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.shouldShowBottomLine = NO;
    }
    
    NSArray *tempArray = self.tempDataArray[indexPath.section];
    
    cell.title = [tempArray objectAtIndex:indexPath.row];;
    cell.subTitle = @"修改";
//    if (2 == indexPath.section) {
//        cell.contentColor = CPERROR_COLOR;
//    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (0 == section) {
        return 200.0f;
    }
    
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (0 == section) {
        NSString *headerIdenitfier = @"CPShopAboutHeader";
        CPShopAboutHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdenitfier];
        if (!header) {
            header = [[CPShopAboutHeader alloc] initWithReuseIdentifier:headerIdenitfier];
        }
        
        if (IS_SHOP) {
            NSString *code = [CPUserInfoModel shareInstance].loginModel.cp_code;
            header.content = [NSString stringWithFormat:@"商家编号:%@",code];
            
            NSString *name = [CPUserInfoModel shareInstance].loginModel.companyname;
            header.detail = [NSString stringWithFormat:@"商家名称：%@",name];
        } else if (IS_ASSISTANT) {
            
            NSString *code = [CPUserInfoModel shareInstance].loginModel.companyname;
            header.content = [NSString stringWithFormat:@"代理姓名：%@",code];
            
            NSString *name = [CPUserInfoModel shareInstance].loginModel.cp_code;
            header.detail = [NSString stringWithFormat:@"代理编号：%@",name];

        }
        
        return header;
    }

    return nil;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//
//    if (0 == section ) {
//
//        NSString *headerIdenitfier = @"CPShopAboutHeader";
//        CPShopAboutHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdenitfier];
//        if (!header) {
//            header = [[CPShopAboutHeader alloc] initWithReuseIdentifier:headerIdenitfier];
//        }
//
//        if (IS_SHOP) {
//            NSString *code = [CPUserInfoModel shareInstance].loginModel.cp_code;
//            header.content = [NSString stringWithFormat:@"门店编号:%@",code];
//
//            NSString *name = [CPUserInfoModel shareInstance].loginModel.companyname;
//            header.detail = [NSString stringWithFormat:@"门店名称：%@",name];
//        } else if (IS_ASSISTANT) {
//
//            if (IS_SHOP) {
//                NSString *code = [CPUserInfoModel shareInstance].loginModel.linkname;
//                header.content = [NSString stringWithFormat:@"店员姓名:%@",code];
//
//                NSString *name = [CPUserInfoModel shareInstance].loginModel.cp_code;
//                header.detail = [NSString stringWithFormat:@"店员编号：%@",name];
//            }
//
//            return header;
//        }
//            //        NSString *headerIdenitfier = @"CPEvaluatedTypeHeader";
//            //
//            //        UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdenitfier];
//            //        if (!header) {
//            //            header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerIdenitfier];
//            //
//            //            CPLeftRightCell *cell = [[CPLeftRightCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:headerIdenitfier];
//            //            cell.contentView.backgroundColor = [UIColor whiteColor];
//            //            cell.backgroundColor = [UIColor whiteColor];
//            //            cell.title = @"门店信息";
//            ////            cell.subTitle = @"修改";
//            //            cell.frame = CGRectMake(0, 0, SCREENWIDTH, CELL_HEIGHT_F);
//            ////            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//            //
//            //            [header.contentView addSubview:cell];
//            //
//            ////            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(modifyInfoAction:)];
//            ////            [cell addGestureRecognizer:tap];
//            //        }
//            //
//            //        return header;
//
//        return nil;
//}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
//            return IS_SHOP ? @"" : @"账户信息";
            return @"";
            break;
        case 1:
            return @"安全设置";
            break;
        case 2:
            return @"收款信息";
            break;
            
        default:
            break;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (2 == section) {
        return 60.0f;
    }
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if (2 == section) {
        NSString *headerIdenitfier = @"footer";
        
        UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdenitfier];
        CPButton *loginoutBT = [header.contentView viewWithTag:CPBASETAG];
        if (!header) {
            header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:headerIdenitfier];
            header.contentView.backgroundColor = tableView.backgroundColor;
            
            loginoutBT = [CPButton new];
            [loginoutBT setTitle:@"退出当前登陆" forState:0];
            [loginoutBT setTitleColor:UIColor.whiteColor forState:0];
            [loginoutBT addTarget:self action:@selector(loginOutAction:) forControlEvents:64];
            [loginoutBT setBackgroundColor:CPERROR_COLOR];
            [loginoutBT setBackgroundImage:UIImage.new forState:0];
            
            [header.contentView addSubview:loginoutBT];
            [loginoutBT mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(cellSpaceOffset);
                make.right.mas_equalTo(-cellSpaceOffset);
                make.centerY.mas_equalTo(header.contentView.mas_centerY);
                make.height.mas_equalTo(CELL_HEIGHT_F);
            }];
            
        }
        
        return header;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"%s",__FUNCTION__);
    
    switch (indexPath.section) {
        case 0:
        {
            CPChangeUserBaseInfoVC *vc = [[CPChangeUserBaseInfoVC alloc] init];
            vc.title = @"用户信息修改";
            
            [self.navigationController pushViewController:vc animated:YES];
            
//            if (IS_ASSISTANT && 2 == indexPath.row) {
//                [self push2VCWith:@"CPAssistantModifyPhoneVC" title:@"修改手机号码"];
//            }
        }
            break;
        case 1:
            [self push2VCWith:@"CPModifyShopPasswdVC" title:@"修改密码"];
            break;
        case 2:
            [self push2VCWith:@"CPRemittanceAccountListVC" title:@"收款方式"];
            break;
            
        default:
            break;
    }
}

- (void)modifyInfoAction:(id)gst {
    NSLog(@"%s",__FUNCTION__);
    
    CPModifyShopInfoVC *vc = [[CPModifyShopInfoVC alloc] init];
    vc.title = @"修改门店信息";
    vc.type = CPModifyShopInfoTypeModifyShopInfo;
    
    [self.navigationController pushViewController:vc animated:YES];
    //    [self push2VCWith:@"CPModifyShopInfoVC" title:@"修改门店信息"];
}

- (void)loginOutAction:(CPButton *)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否要退出当前登陆" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    DDLogInfo(@"%@",@(buttonIndex));
    
    if (1 == buttonIndex) {
        
        CPLoginVC *vc = [[CPLoginVC alloc] init];
        vc.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)loadData {
    
    DDLogInfo(@"------------------------------");
    
    __weak typeof(self) weakSelf = self;
    
    [CPUserDetailInfoModel modelRequestWith:@"http://leshouzhan.platline.com/api/user/getDetailUserInfo"
                                 parameters:@{@"userid" : @([CPUserInfoModel shareInstance].loginModel.ID)}
                                      block:^(CPUserDetailInfoModel *result) {
                                          [weakSelf handleLoadDataSuccessBlock:result];
                                      } fail:^(NSError *error) {
                                          
                                      }];
}

- (void)handleLoadDataSuccessBlock:(CPUserDetailInfoModel *)result {
    
    [CPUserInfoModel shareInstance].userDetaiInfoModel = result;
    
    NSString *paytype = @"";
    
    if (result.paycfg == 1) {
        paytype = @"银行卡";
    } else if (result.paycfg == 2) {
        paytype = @"微信";
    } else if (result.paycfg == 3) {
        paytype = @"支付宝";
    }
    
//    if (result.Typeid == 2) {
//
//        NSString *paytype = @"";
//
//        if (result.paycfg == 1) {
//            paytype = @"银行卡";
//        } else if (result.paycfg == 2) {
//            paytype = @"微信";
//        } else if (result.paycfg == 3) {
//            paytype = @"支付宝";
//        }
//
//
//        self.tempDataArray = @[
//                               //                               @[@"茂业店",@"332*****",@"********:",@"158****3123",@"wang****@163.com"],
//                               @[
//                                   [CPUserInfoModel shareInstance].loginModel.companyname,
//                                   [CPUserInfoModel shareInstance].loginModel.cp_code,
//                                   [CPUserInfoModel shareInstance].loginModel.linkname,
//                                   [CPUserInfoModel shareInstance].loginModel.phone,
//                                   [CPUserInfoModel shareInstance].loginModel.email
//                                   ],
//                               @[@"登陆密码"],
//                               //                           @[@"更改收款方式(支付宝)"]
//                               @[
//                                   [NSString stringWithFormat:@"收款方式(%@)",paytype]
//                                   ]
//                               ];
//    } else if (result.Typeid == 1 || result.Typeid == 5) {
//
//
//        NSString *paytype = @"";
//
//        if (result.paycfg == 1) {
//            paytype = @"银行卡";
//        } else if (result.paycfg == 2) {
//            paytype = @"微信";
//        } else if (result.paycfg == 3) {
//            paytype = @"支付宝";
//        }

        self.tempDataArray = @[
                               @[
                                   @"",
                                   result.linkname,
                                   result.phone,
                                   result.email,
                                   result.address
                                   ],
                               @[
                                   @"登陆密码"
                                   ],
                               @[
//                                   @"收款账号",
                                   [NSString stringWithFormat:@"收款方式(%@)",paytype]
                                   ]
                               ];
        
//    }
    
    
    [self.dataTableView reloadData];
    
    CGFloat height = self.tabBarController.tabBar.frame.size.height;
    self.dataTableView.frame = CGRectMake(0, NAV_HEIGHT, SCREENWIDTH, SCREENHEIGHT - NAV_HEIGHT - height);
}

@end

