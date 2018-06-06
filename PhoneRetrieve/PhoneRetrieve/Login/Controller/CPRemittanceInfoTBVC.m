//
//  CPRemittanceInfoTBVC.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/6.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPRemittanceInfoTBVC.h"
#import "CPRegistStepView.h"
#import "CPShopRegisterModel.h"
#import "CPLoginVC.h"
#import "CPSuccessVC.h"
#import "CPAssistantManagerVC.h"

@interface CPRemittanceInfoTBVC ()<UITextFieldDelegate, UIPickerViewDelegate,UIPickerViewDataSource> {
    UIPickerView *consignCompanyPicker;
    NSArray *consignCompanys;
}

@property (nonatomic, strong) CPTextField *bankOwerTF,*bankAccountTF, *bankAreaTF,*bankBranchTF;
@property (nonatomic, strong) CPTextField *wechatNameTF, *wechatAccountTF;
@property (nonatomic, strong) CPTextField *alipayNameTF, *alipayAccountTF;
@property (nonatomic, strong) CPButton *nextAction;
//@property (nonatomic, strong) CPSelectTextField *paymethodTF;
@property (nonatomic, strong) CPTextField *paymethodTF;

@end

@implementation CPRemittanceInfoTBVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.dataArray = @[
//                       @[@"收款人名称",@"银行账号",@"开户支行"],
//                       @[@"微信名称",@"微信账号"],
//                       @[@"支付宝名称",@"支付宝账号"]
//                       ];
    
    self.dataArray = @[@[@""]];
    
    self.dataTableView.backgroundColor = UIColor.whiteColor;
    
    self.navigationItem.rightBarButtonItem = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 790.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentify = @"CellIdentify";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.clipsToBounds = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    CPRegistStepView *stepView = [[CPRegistStepView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 44.0f)];
    stepView.clipsToBounds = YES;
    stepView.titles =@[
                       @"注册只需3步",
                       @"1.登录信息",
                       @"2.商家信息",
                       @"3.账号信息"
                       ];
    stepView.currentStep = 2;
    
    [cell.contentView addSubview:stepView];
    [stepView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        if (self.registType == CPRegistTypePersonalEditShop) {
            make.height.mas_equalTo(0);
        } else {
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }
    }];
    
    //  银行账号
    UILabel *bankSectionLB = [UILabel new];
    bankSectionLB.text = @"银行账号";
    bankSectionLB.font = [UIFont systemFontOfSize:13.0f];
    
    [cell.contentView addSubview:bankSectionLB];
    
    [bankSectionLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(stepView.mas_bottom).offset(cellSpaceOffset);
        make.left.mas_equalTo(cellSpaceOffset);
    }];
    
    
    UIView *bankSepLine = [UIView new];
    bankSepLine.backgroundColor = C99;
    
    [cell.contentView addSubview:bankSepLine];
    
    [bankSepLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bankSectionLB.mas_bottom).offset(4);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5f);
    }];

    
    if (nil == self.bankOwerTF) {
        
        self.bankOwerTF = [CPTextField new];
        self.bankOwerTF.placeholder = @"收款人名称";
        self.bankOwerTF.font = [UIFont systemFontOfSize:13.0f];
        self.bankOwerTF.borderStyle = UITextBorderStyleRoundedRect;
        
        [cell.contentView addSubview:self.bankOwerTF];
         
        [self.bankOwerTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(bankSectionLB.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];
    }
    
    if (nil == self.bankAccountTF) {
        self.bankAccountTF = [CPTextField new];
        self.bankAccountTF.placeholder = @"银行账号";
        self.bankAccountTF.font = [UIFont systemFontOfSize:13.0f];
        self.bankAccountTF.borderStyle = UITextBorderStyleRoundedRect;
        
        [cell.contentView addSubview:self.bankAccountTF];
        
        [self.bankAccountTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.bankOwerTF.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];
    }
    
    if (nil == self.bankAreaTF) {
        self.bankAreaTF = [CPTextField new];
        self.bankAreaTF.placeholder = @"银行名称";
        self.bankAreaTF.font = [UIFont systemFontOfSize:13.0f];
        self.bankAreaTF.borderStyle = UITextBorderStyleRoundedRect;
        
        [cell.contentView addSubview:self.bankAreaTF];
        
        [self.bankAreaTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.bankAccountTF.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];
    }
    
    {
        self.bankBranchTF = [CPTextField new];
        self.bankBranchTF.placeholder = @"银行支行";
        self.bankBranchTF.font = [UIFont systemFontOfSize:13.0f];
        self.bankBranchTF.borderStyle = UITextBorderStyleRoundedRect;
        
        [cell.contentView addSubview:self.bankBranchTF];
        
        [self.bankBranchTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.bankAreaTF.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];
    }

    
    //  微信账号
    UILabel *wechatSectionLB = [UILabel new];
    wechatSectionLB.text = @"微信";
    wechatSectionLB.font = [UIFont systemFontOfSize:13.0f];
    
    [cell.contentView addSubview:wechatSectionLB];
    
    [wechatSectionLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bankBranchTF.mas_bottom).offset(cellSpaceOffset);
        make.left.mas_equalTo(cellSpaceOffset);
    }];
    
    
    UIView *wechatSepLine = [UIView new];
    wechatSepLine.backgroundColor = C99;
    
    [cell.contentView addSubview:wechatSepLine];
    
    [wechatSepLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(wechatSectionLB.mas_bottom).offset(4);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5f);
    }];
    
    if (nil == self.wechatNameTF) {
        self.wechatNameTF = [CPTextField new];
        self.wechatNameTF.placeholder = @"微信名称";
        self.wechatNameTF.font = [UIFont systemFontOfSize:13.0f];
        self.wechatNameTF.borderStyle = UITextBorderStyleRoundedRect;
        
        [cell.contentView addSubview:self.wechatNameTF];
        
        [self.wechatNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(wechatSepLine.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];
    }
    
    if (nil == self.wechatAccountTF) {
        self.wechatAccountTF = [CPTextField new];
        self.wechatAccountTF.placeholder = @"微信账号";
        self.wechatAccountTF.font = [UIFont systemFontOfSize:13.0f];
        self.wechatAccountTF.borderStyle = UITextBorderStyleRoundedRect;
        
        [cell.contentView addSubview:self.wechatAccountTF];
        
        [self.wechatAccountTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.wechatNameTF.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];
    }
    
    //  支付宝账号
    UILabel *aplipaySectionLB = [UILabel new];
    aplipaySectionLB.text = @"支付宝";
    aplipaySectionLB.font = [UIFont systemFontOfSize:13.0f];
    
    [cell.contentView addSubview:aplipaySectionLB];
    
    [aplipaySectionLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.wechatAccountTF.mas_bottom).offset(cellSpaceOffset);
        make.left.mas_equalTo(cellSpaceOffset);
    }];
    
    
    UIView *alipaySepLine = [UIView new];
    alipaySepLine.backgroundColor = C99;
    
    [cell.contentView addSubview:alipaySepLine];
    
    [alipaySepLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(aplipaySectionLB.mas_bottom).offset(4);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5f);
    }];
    
    if (nil == self.alipayNameTF) {
        self.alipayNameTF = [CPTextField new];
        self.alipayNameTF.placeholder = @"支付宝名称";
        self.alipayNameTF.font = [UIFont systemFontOfSize:13.0f];
        self.alipayNameTF.borderStyle = UITextBorderStyleRoundedRect;
        
        [cell.contentView addSubview:self.alipayNameTF];
        
        [self.alipayNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(alipaySepLine.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];
    }
    
    if (nil == self.alipayAccountTF) {
        self.alipayAccountTF = [CPTextField new];
        self.alipayAccountTF.placeholder = @"支付宝账号";
        self.alipayAccountTF.font = [UIFont systemFontOfSize:13.0f];
        self.alipayAccountTF.borderStyle = UITextBorderStyleRoundedRect;
        
        [cell.contentView addSubview:self.alipayAccountTF];
        
        [self.alipayAccountTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.alipayNameTF.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];
    }
    

    UIView *paymethodSepLine = [UIView new];
    paymethodSepLine.backgroundColor = C99;
    
    [cell.contentView addSubview:paymethodSepLine];
    
    [paymethodSepLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.alipayAccountTF.mas_bottom).offset(cellSpaceOffset);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(0.5f);
    }];
    
    UILabel *paymethodLB = [UILabel new];
    paymethodLB.font = [UIFont systemFontOfSize:13.0f];
    paymethodLB.text = @"选择付款方式";
    
    [cell.contentView addSubview:paymethodLB];
    
    [paymethodLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(paymethodSepLine.mas_bottom).offset(cellSpaceOffset);
        make.left.mas_equalTo(cellSpaceOffset);
    }];
    
    
    if (nil == self.paymethodTF) {
        
        consignCompanys = @[@"银行卡",@"微信",@"支付宝"];
        
        consignCompanyPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 220)];
        consignCompanyPicker.delegate = self;
        consignCompanyPicker.dataSource = self;
        
        _paymethodTF = [CPTextField new];
        _paymethodTF.text = @"银行卡";
        _paymethodTF.delegate = self;
        _paymethodTF.textAlignment = NSTextAlignmentCenter;
        _paymethodTF.actionType = CPTextFieldActionTypeRightAction;
        _paymethodTF.rightActionImageName = @"home_down";
        _paymethodTF.tintColor = [UIColor clearColor];
        _paymethodTF.borderStyle = UITextBorderStyleRoundedRect;
        _paymethodTF.font = CPFont_M;
        _paymethodTF.inputView = consignCompanyPicker;
        [cell.contentView addSubview:_paymethodTF];
    
        CGFloat width = 120.0f;
//
//        self.paymethodTF = [[CPSelectTextField alloc] initWithFrame:CGRectMake(0, 0, width, CELL_HEIGHT_F)];
//
//        [cell.contentView addSubview:self.paymethodTF];
//
        [self.paymethodTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(paymethodLB.mas_top);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
            make.width.mas_equalTo(width);
        }];
        
    }

    if (nil == self.nextAction) {
        
        NSString *title = @"注册";
        
        if (self.registType == CPRegistTypePersonalEditShop) {
            title = @"保存修改";
        } else if (self.registType == CPRegistTypePersonalAddShop) {
            title = @"增加门店";
        }
        
        self.nextAction = [[CPButton alloc] initWithFrame:CGRectZero];
        [self.nextAction setTitle:title forState:0];
        [self.nextAction addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [cell.contentView addSubview:self.nextAction];
        
        [self.nextAction mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.paymethodTF.mas_bottom).mas_equalTo(CELL_HEIGHT_F);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];
        
        RAC(self.nextAction,enabled) = [RACSignal combineLatest:@[
                                                                  self.bankOwerTF.rac_textSignal,
                                                                  self.bankAccountTF.rac_textSignal,
                                                                  self.bankAreaTF.rac_textSignal,
                                                                  self.wechatNameTF.rac_textSignal,
                                                                  self.wechatAccountTF.rac_textSignal,
                                                                  self.alipayNameTF.rac_textSignal,
                                                                  self.alipayAccountTF.rac_textSignal,
                                                                  self.paymethodTF.rac_textSignal
                                                                  ]
                                                         reduce:^id{
                                                             return @(
                                                             self.bankOwerTF.text.length > 0
                                                             && self.bankAccountTF.text.length > 0
                                                             && self.bankAreaTF.text.length > 0
                                                             && self.wechatNameTF.text.length > 0
                                                             && self.wechatAccountTF.text.length > 0
                                                             && self.alipayNameTF.text.length > 0
                                                             && self.alipayAccountTF.text.length > 0
                                                             && self.paymethodTF.text.length > 0
                                                             );
                                                             
                                                         }];
        
    }
    
    if (self.userDetailModel) {
        self.bankOwerTF.text = self.userDetailModel.bname;
        self.bankAccountTF.text = self.userDetailModel.banknum;
        self.bankAreaTF.text = self.userDetailModel.bankname;
        self.bankBranchTF.text = self.userDetailModel.bankbranch;
        
        self.wechatNameTF.text = self.userDetailModel.wxname;
        self.wechatAccountTF.text = self.userDetailModel.wxnum;
        
        self.alipayNameTF.text = self.userDetailModel.aliname;
        self.alipayAccountTF.text = self.userDetailModel.alinum;
        
        switch (self.userDetailModel.paycfg) {
            case 1:
                self.paymethodTF.text = @"银行卡";
                break;
            case 2:
                self.paymethodTF.text = @"微信";
                break;
            case 3:
                self.paymethodTF.text = @"支付宝";
                break;

            default:
                break;
        }
    }
    

    return cell;
}

- (void)configBankCell:(NSIndexPath *)path {
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

#pragma mark - PickView delegate and datasource

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return consignCompanys.count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component {
    
    return consignCompanys[row];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    NSString *content = consignCompanys[[consignCompanyPicker selectedRowInComponent:0]];
    self.paymethodTF.text = content;
}

#pragma mark - private method

- (void)nextAction:(UIButton *)sender {
    
//    [self push2VCWith:@"CPSuccessVC" title:@"提交成功"];
//
//    return;

    [CPRegistParam shareInstance].bname      = cp_noEmptyString(self.bankOwerTF.text);
    [CPRegistParam shareInstance].banknum    = cp_noEmptyString(self.bankAccountTF.text);
    [CPRegistParam shareInstance].bankname   = cp_noEmptyString(self.bankAreaTF.text);
    [CPRegistParam shareInstance].bankbranch = cp_noEmptyString(self.bankBranchTF.text);
    
    [CPRegistParam shareInstance].wxname     = cp_noEmptyString(self.wechatNameTF.text);
    [CPRegistParam shareInstance].wxnum      = cp_noEmptyString(self.wechatAccountTF.text);
    
    [CPRegistParam shareInstance].aliname    = cp_noEmptyString(self.alipayNameTF.text);
    [CPRegistParam shareInstance].alinum     = cp_noEmptyString(self.alipayAccountTF.text);

    if ([self.paymethodTF.text isEqualToString:@"银行卡"]) {
        [CPRegistParam shareInstance].paycfg = @"1";
    } else if ([self.paymethodTF.text isEqualToString:@"微信"]) {
        [CPRegistParam shareInstance].paycfg = @"2";
    } else if ([self.paymethodTF.text isEqualToString:@"支付宝"]) {
        [CPRegistParam shareInstance].paycfg = @"3";
    }
    
    if (self.registType == CPRegistTypeShop) {
        [self shopRegist];
    } else if (self.registType == CPRegistTypeCompanyDelegate) {
        [self companyRegistDelegate];
    } else if (self.registType == CPRegistTypePersonalDelegate) {
        [self personalRegistDelegate];
    } else if (self.registType == CPRegistTypePersonalAddShop) {
        [self addShop];
    } else if (self.registType == CPRegistTypePersonalEditShop) {
        [self updateShop];
    }

//    CPRegistParam *params = [CPRegistParam shareInstance];
//    NSDictionary *paramsDict = [params mj_keyValues];
//
//    __weak typeof(self) weakSelf = self;
//
//    [CPShopRegisterModel modelRequestWith:@"http://api.leshouzhan.com/api/user/register3"
//                               parameters:paramsDict
//                                    block:^(id result) {
//                                        [weakSelf handleRegiterBlock:result];
//                                    } fail:^(CPError *error) {
//
//                                    }];
}

- (void)handleRegiterBlock:(CPShopRegisterModel *)result {
    if (!result || ![result isKindOfClass:[CPShopRegisterModel class]]) {
        [self.view makeToast:result.msg duration:1.0f position:CSToastPositionCenter];
        return;
    }
    
    [[CPProgress Instance] showSuccess:self.view message:@"注册成功" finish:^(BOOL finished) {
//        [self.navigationController popToRootViewControllerAnimated:YES];
        
        [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass: [CPLoginVC class]]) {
                [self.navigationController popToViewController:obj animated:YES];
                *stop = YES;
            }
        }];
    }];
}

#pragma mark - private method
- (void)shopRegist {
    
    CPRegistParam *params = [CPRegistParam shareInstance];
    NSDictionary *paramsDict = [params mj_keyValues];
    params.type = @"2";

    __weak typeof(self) weakSelf = self;
    
    [CPShopRegisterModel modelRequestWith:@"http://api.leshouzhan.com/api/user/register2"
                               parameters:paramsDict
                                    block:^(id result) {
                                        [weakSelf handleRegiterBlock:result];
                                    } fail:^(CPError *error) {
                                        
                                    }];
}

- (void)companyRegistDelegate {
    CPRegistParam *params = [CPRegistParam shareInstance];
    params.type = @"2";
    NSDictionary *paramsDict = [params mj_keyValues];
    
    __weak typeof(self) weakSelf = self;
    
    [CPShopRegisterModel modelRequestWith:@"http://api.leshouzhan.com/api/user/register1"
                               parameters:paramsDict
                                    block:^(id result) {
                                        [weakSelf handleRegiterBlock:result];
                                    } fail:^(CPError *error) {
                                        
                                    }];
}

- (void)personalRegistDelegate {
    CPRegistParam *params = [CPRegistParam shareInstance];
    params.type = @"2";
    NSDictionary *paramsDict = [params mj_keyValues];
    
    __weak typeof(self) weakSelf = self;
    
    [CPShopRegisterModel modelRequestWith:@"http://api.leshouzhan.com/api/user/register5"
                               parameters:paramsDict
                                    block:^(id result) {
                                        [weakSelf handleRegiterBlock:result];
                                    } fail:^(CPError *error) {
                                        
                                    }];
}

- (void)addShop {
    
    CPRegistParam *params = [CPRegistParam shareInstance];
    NSDictionary *paramsDict = [params mj_keyValues];
    
    __weak typeof(self) weakSelf = self;
    
    [CPShopRegisterModel modelRequestWith:@"http://api.leshouzhan.com/api/user/addStore"
                               parameters:paramsDict
                                    block:^(id result) {
                                        [weakSelf handleAddShopBlock];
                                    } fail:^(CPError *error) {
                                        
                                    }];
}

- (void)handleAddShopBlock {
    [[CPProgress Instance] showSuccess:self.view message:@"新增成功" finish:^(BOOL finished) {
        [self pop2MemberManager];
    }];
}

- (void)updateShop {
    CPRegistParam *params = [CPRegistParam shareInstance];
    NSDictionary *paramsDict = [params mj_keyValues];
    
    __weak typeof(self) weakSelf = self;
    
    [CPShopRegisterModel modelRequestWith:@"http://api.leshouzhan.com/api/user/updStore"
                               parameters:paramsDict
                                    block:^(id result) {
                                        [weakSelf handleUpdateShopBlock];
                                    } fail:^(CPError *error) {
                                        
                                    }];
}

- (void)handleUpdateShopBlock {
    [[CPProgress Instance] showSuccess:self.view message:@"修改成功" finish:^(BOOL finished) {
        [self pop2MemberManager];
    }];
}

- (void)pop2MemberManager {
    
    [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:[CPAssistantManagerVC class]]) {
            [self.navigationController popToViewController:obj animated:YES];
            *stop = YES;
        }
    }];
}

@end
