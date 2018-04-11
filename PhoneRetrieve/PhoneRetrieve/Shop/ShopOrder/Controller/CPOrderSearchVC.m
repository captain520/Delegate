//
//  CPOrderSearchVC.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/28.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPOrderSearchVC.h"
#import "CPDatePickerTF.h"
#import "CPAssistanteOrderDetailModel.h"
#import "CPAssistantOrderListVC.h"
#import "CPOrderListPageModel.h"
#import "CPPayStateSearchResultVCViewController.h"
#import "CPShippingStateVC.h"
#import "CPAssistantOrderListPageModel.h"
#import "CPAssistantOrderListPageModel.h"
#import "CPGoodOrderListVC.h"
#import "CPShopRewardListVC.h"
#import "CPRewardModel.h"
#import "CPDealOrderModel.h"
#import "CPShippingInformationListVC.h"
#import "CPRetireveOrderModel.h"
#import "CPRetrieveOrderListVC.h"

@interface CPOrderSearchVC ()<UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) CPDatePickerTF *begintInputTF, *endInputTF;
@property (nonatomic, strong) CPLabel *beginLB, *endLB;
@property (nonatomic, strong) CPButton *nextActionBT;

//@property (nonatomic, strong) UIDatePicker *datePicker;

@end

@implementation CPOrderSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setType:(CPOrderSearchType)type {
    
    _type = type;
}

- (void)setupUI {
  
//    self.datePicker = [[UIDatePicker alloc] init];
//    self.datePicker.datePickerMode = UIDatePickerModeDate;
    
    NSString *placeholder = @"物流单号/交易单号";
//    if (self.type == CPOrderSearchTypeOrder) {
    placeholder = @"订单号";
//    }

    self.searchBar = [[UISearchBar alloc] init];;
    self.searchBar.delegate           = self;
    self.searchBar.placeholder        = placeholder;
    self.searchBar.backgroundImage    = [UIImage new];
    self.searchBar.layer.borderColor  = CPBoardColor.CGColor;
    self.searchBar.layer.borderWidth  = CPBoardWidth;
    self.searchBar.layer.cornerRadius = 5.0f;
    
    [self.view addSubview:self.searchBar];

    [_searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(NAV_HEIGHT + cellSpaceOffset);
        make.left.mas_offset(cellSpaceOffset);
        make.right.mas_offset(-cellSpaceOffset);
        make.height.mas_offset(CELL_HEIGHT_F);
    }];
    
    
    _beginLB = [CPLabel new];
    _beginLB.font      = CPFont_S;
    _beginLB.text      = @"开始日期";
    _beginLB.textColor = C99;
    
    [self.view addSubview:_beginLB];
    
    [_beginLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_searchBar.mas_bottom).offset(cellSpaceOffset);
        make.left.mas_equalTo(cellSpaceOffset);
    }];

    _begintInputTF = [[CPDatePickerTF alloc] initWithFrame:CGRectMake(0, 0, 0, CELL_HEIGHT_F)];
    _begintInputTF.actionType = CPTextFieldActionTypeRightAction;
    _begintInputTF.rightActionImageName = @"data";
    [self.view addSubview:_begintInputTF];
    [_begintInputTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_beginLB.mas_bottom).offset(cellSpaceOffset);
        make.left.mas_equalTo(cellSpaceOffset);
        make.right.mas_equalTo(-cellSpaceOffset);
        make.height.mas_equalTo(CELL_HEIGHT_F);
    }];
    
    
    _endLB = [CPLabel new];
    _endLB.textColor = C99;
    _endLB.font = CPFont_S;
    _endLB.text = @"结束日期";
    [self.view addSubview:_endLB];
    
    [_endLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_begintInputTF.mas_bottom).offset(cellSpaceOffset);
        make.left.mas_equalTo(cellSpaceOffset);
    }];

    
    _endInputTF = [[CPDatePickerTF alloc] initWithFrame:CGRectMake(0, 0, 0, CELL_HEIGHT_F)];
    _endInputTF.actionType = CPTextFieldActionTypeRightAction;
    _endInputTF.rightActionImageName = @"data";
    [self.view addSubview:_endInputTF];
    [_endInputTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_endLB.mas_bottom).offset(cellSpaceOffset);
        make.left.mas_equalTo(cellSpaceOffset);
        make.right.mas_equalTo(-cellSpaceOffset);
        make.height.mas_equalTo(CELL_HEIGHT_F);
    }];
    
    self.nextActionBT = [CPButton new];
    [self.nextActionBT setTitle:@"搜 索" forState:0];
    [self.nextActionBT addTarget:self action:@selector(searchAction:) forControlEvents:64];
    
    [self.view addSubview:self.nextActionBT];
    [self.nextActionBT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_endInputTF.mas_bottom).offset(CELL_HEIGHT_F);;
        make.left.mas_equalTo(cellSpaceOffset);
        make.right.mas_equalTo(-cellSpaceOffset);
        make.height.mas_equalTo(CELL_HEIGHT_F);
    }];

}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    NSLog(@"%s",__FUNCTION__);
    
    [self.view endEditing:YES];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)searchAction:(id)sender {
    
#warning Debug
    
    if (self.type == CPOrderSearchTypeReward) {
        [self searchRewardData];
    } else if(self.type == CPOrderSearchTypeShopPayAndUnpaidOrder ||
              self.type == CPOrderSearchTypeShopUnpaidOrder ||
              self.type == CPOrderSearchTypeShopPaidOrder) {
        [self searchDealOrderData];
    } else if (self.type == CPOrderSearchTypeOverFinishedOrder || self.type == CPOrderSearchTypeOverDueOrder) {
        [self searchFinisheAdnOverDuedOrderData];
    }
    
//    CPShopRewardListVC *vc = [[CPShopRewardListVC alloc] init];
//    vc.title = @"返佣信息";
//
//    [self.navigationController pushViewController:vc animated:YES];

    return;
    
    
    if (self.type == CPOrderSearchTypeShopPaidOrder
        || self.type == CPOrderSearchTypeShopUnpaidOrder
        || self.type == CPOrderSearchTypeShipping
        ) {
        
        [self queryShopPayStateVC];
        
        return;
    } else if (self.type == CPOrderSearchTypeOverDueOrder || self.type == CPOrderSearchTypeOverFinishedOrder) {
        
        [self queryOrderState];
        
        return;
    }
    
    
    DDLogInfo(@">>>>>>>>>>>>>>>>>>>>%s",__FUNCTION__);
    __weak typeof(self) weakSelf = self;
    
    NSMutableDictionary *params = @{
                             @"typeid": @([CPUserInfoModel shareInstance].loginModel.Typeid),
                             @"userid": @([CPUserInfoModel shareInstance].loginModel.ID)
                             }.mutableCopy;
    if (self.searchBar.text.length > 0) {
        [params setObject:self.searchBar.text forKey:@"resultno"];
    }
    
    if (self.begintInputTF.text.length > 0 ) {
        [params setObject:self.begintInputTF.text forKey:@"starttime"];
    }
    
    if (self.endInputTF.text.length > 0 ) {
        [params setObject:self.endInputTF.text forKey:@"endtime"];
    }
    
    [CPAssistanteOrderDetailModel modelRequestWith:CPURL_ASSISTANT_GET_RETRIEVE_ORDER
                                        parameters:params
                                             block:^(NSArray <CPAssistanteOrderDetailModel *> *result) {
                                                 [weakSelf handleLoadDataSuccessBlock:result];
                                             } fail:^(CPError *error) {

                                             }];
}

- (void)handleLoadDataSuccessBlock:(NSArray <CPAssistanteOrderDetailModel *> *)result {
    
    if (!result || ![result isKindOfClass:[NSArray class]]) {
        
        [self.view makeToast:@"暂无符合的数据" duration:2.0 position:CSToastPositionCenter];

        return;
    }
    
    CPAssistantOrderListVC *vc = [[CPAssistantOrderListVC alloc] init];
    vc.dataArray = result;
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 门店订单查询

- (void)queryShopPayStateVC {
    
    __weak typeof(self) weakSelf = self;
    
    NSMutableDictionary *params = @{
                                    @"typeid": @([CPUserInfoModel shareInstance].loginModel.Typeid),
                                    @"userid": @([CPUserInfoModel shareInstance].loginModel.ID)
                                    }.mutableCopy;
    
    if (self.searchBar.text.length > 0) {
        [params setObject:self.searchBar.text forKey:@"ordersn"];
    }
    
    if (self.begintInputTF.text.length > 0 ) {
        [params setObject:self.begintInputTF.text forKey:@"starttime"];
    }
    
    if (self.endInputTF.text.length > 0 ) {
        [params setObject:self.endInputTF.text forKey:@"endtime"];
    }
    
    if (self.type == CPOrderSearchTypeShopUnpaidOrder
        || self.type == CPOrderSearchTypeShipping ||
        self.type == CPOrderSearchTypeShopPaidOrder
        ) {
        
        NSInteger paycfg = 0;//aycfg 支付状态：0未支付，1已支付
        if (self.type == CPOrderSearchTypeShopUnpaidOrder) {
            paycfg = 0;
        } else if (self.type == CPOrderSearchTypeShopPaidOrder) {
            paycfg = 1;
        }
        
        [params setObject:@(paycfg) forKey:@"paycfg"];
    }

    [CPOrderListPageModel modelRequestWith:@"http://leshouzhan.platline.com/api/Order/findOrderList"
                                parameters:params
                                     block:^(CPOrderListPageModel *result) {
                                         [weakSelf handlequeryShopPayStateVCBlock:result];
                                     } fail:^(CPError *error) {
                                         
                                     }];
}

- (void)handlequeryShopPayStateVCBlock:(CPOrderListPageModel *)resul {
    if (!resul || ![resul isKindOfClass:[CPOrderListPageModel class]] || resul.cp_data.count == 0) {
        [self.view makeToast:@"暂无符合的数据" duration:2.0 position:CSToastPositionCenter];
        return;
    }
    
    if (self.type == CPOrderSearchTypeShipping) {
        
        CPShippingStateVC *vc = [[CPShippingStateVC alloc] init];
        vc.title = self.title;
        vc.dataArray = resul.cp_data;
        
        [self.navigationController pushViewController:vc animated:YES];

    } else {
        
        CPPayStateSearchResultVCViewController *vc = [[CPPayStateSearchResultVCViewController alloc] init];
        //    vc.title = @"支付订单查询结果";
        vc.payStateOrderModel = resul;
        vc.title = self.title;
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (void)queryOrderState {

    DDLogInfo(@">>>>>>>>>>>>>>>>>>>>%s",__FUNCTION__);
    __weak typeof(self) weakSelf = self;
    
    NSString *statuscfg = @"0";
    if (self.type == CPOrderSearchTypeOverDueOrder) {
        statuscfg = @"1";
    } else if (self.type == CPOrderSearchTypeOverFinishedOrder) {
        statuscfg = @"0";
    }
    
    NSMutableDictionary *params = @{
                                    @"typeid": @([CPUserInfoModel shareInstance].loginModel.Typeid),
                                    @"userid": @([CPUserInfoModel shareInstance].loginModel.ID),
                                    @"statuscfg" : statuscfg
                                    }.mutableCopy;
    
    [CPAssistantOrderListPageModel modelRequestWith:CPURL_ASSISTANT_GET_RETRIEVE_ORDER
                                         parameters:params
                                              block:^(CPAssistantOrderListPageModel *result) {
                                                  [weakSelf handleQueryOrderStateSuccessBlock:result];
                                              } fail:^(CPError *error) {
                                                  
                                              }];
}

- (void)handleQueryOrderStateSuccessBlock:(CPAssistantOrderListPageModel *)result {
    
    if (!result || ![result isKindOfClass:[CPAssistantOrderListPageModel class]] || result.cp_data.count == 0) {
        [self.view makeToast:@"暂无符合的数据" duration:2.0 position:CSToastPositionCenter];
        
        return;
    }
    
    CPGoodOrderListVC *vc = [[CPGoodOrderListVC alloc] init];
    vc.result = result;
    
    if (self.type == CPOrderSearchTypeOverDueOrder) {
        vc.title = @"回收车失效订单查询";
        vc.goodOrderListType = CPGoodOrderListTypeCartOverDueOrder;
    } else {
        vc.goodOrderListType = CPGoodOrderListTypeShopRetrieveOrder;
        vc.title = @"门店回收订单查询";
    }

    [self.navigationController pushViewController:vc animated:YES];

}

//  反佣查询
- (void)searchRewardData {
    __weak typeof(self) weakSelf = self;
    
    NSMutableDictionary *params = @{
                             @"code" : @([CPUserInfoModel shareInstance].loginModel.ID),
                             @"pagesize" : @"100",
                             @"currentpage" : @(1)
                             }.mutableCopy;
    if (self.searchBar.text.length > 0) {
        [params setObject:self.searchBar.text forKey:@"ordersn"];
    }
    
    if (self.begintInputTF.text.length > 0) {
        [params setObject:self.begintInputTF.text forKey:@"start"];
    }
    
    if (self.endInputTF.text.length > 0) {
        [params setObject:self.endInputTF.text forKey:@"end"];
    }

    
    [CPRewardModel modelRequestWith:@"http://leshouzhan.platline.com/api/Distributionorder/getDistributionList"
                         parameters:params
                              block:^(CPRewardModel *result) {
                                  [weakSelf handleRewardSearchBlock:result];
                              } fail:^(CPError *error) {
                                  
                              }];
}

- (void)handleRewardSearchBlock:(CPRewardModel *)result {
    
    if ([result isKindOfClass:[CPRewardModel class]] && result.data.count > 0) {
        
        CPShopRewardListVC *vc = [[CPShopRewardListVC alloc] init];
        vc.model = result;
        vc.title = @"返佣查询结果";
        
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        [self.view makeToast:@"未查到符合的数据" duration:1.0f position:CSToastPositionCenter];
    }
    
}


#pragma mark - 成交订单查询

- (void)searchDealOrderData {
    
    __weak typeof(self) weakSelf = self;
    
    NSMutableDictionary *params = @{
                                    @"pagesize" : @"200",
                                    @"code" : @([CPUserInfoModel shareInstance].loginModel.ID),
                                    @"currentpage" : @(1)
                                    }.mutableCopy;
    
    if (self.searchBar.text.length > 0) {
        [params setObject:self.searchBar.text forKey:@"ordersn"];
    }
    
    if (self.begintInputTF.text.length > 0) {
        [params setObject:self.begintInputTF.text forKey:@"start"];
    }
    
    if (self.endInputTF.text.length > 0) {
        [params setObject:self.endInputTF.text forKey:@"end"];
    }
    
    if (self.type == CPOrderSearchTypeShopUnpaidOrder) {
        [params setObject:@"0" forKey:@"type"];
    } else if (self.type == CPOrderSearchTypeShopPaidOrder) {
        [params setObject:@"1" forKey:@"type"];
    }


    [CPDealOrderModel modelRequestWith:@"http://leshouzhan.platline.com/api/order/getTransactionOrder"
                            parameters:params
                                 block:^(CPDealOrderModel *result) {
                                     [weakSelf handleDealOrderSearchBlock:result];
                                 } fail:^(CPError *error) {
                                     
                                 }];
    
}

- (void)handleDealOrderSearchBlock:(CPDealOrderModel *)result {
    
    if ([result isKindOfClass:[CPDealOrderModel class]] && result.data.count > 0) {
        CPShippingInformationListVC *vc = [[CPShippingInformationListVC alloc] init];
        vc.model = result;
        
        if(self.type == CPOrderSearchTypeShopPayAndUnpaidOrder) {
            vc.title = @"交易订单查询结果-全部";
        } else if(self.type == CPOrderSearchTypeShopUnpaidOrder) {
            vc.title = @"交易订单查询结果-待支付";
        } else if( self.type == CPOrderSearchTypeShopPaidOrder) {
            vc.title = @"交易订单查询结果-已支付";
        }

        [self.navigationController pushViewController:vc animated:YES];

    } else {
        [self.view makeToast:@"未查到符合的数据" duration:1.0f position:CSToastPositionCenter];
    }
    
}

#pragma mark - 回收订单查询
- (void)searchFinisheAdnOverDuedOrderData {
    
    __weak typeof(self) weakSelf = self;
    
    NSMutableDictionary *params = @{
                                    @"pagesize" : @"100",
                                    @"code" : @([CPUserInfoModel shareInstance].loginModel.ID),
                                    @"currentpage" : @(1)
                                    }.mutableCopy;

    NSString *requestUrl = nil;
    if (self.type == CPOrderSearchTypeOverFinishedOrder) {
        requestUrl = @"http://leshouzhan.platline.com/api/order/getRecyclingInformation";
    } else if (self.type == CPOrderSearchTypeOverDueOrder) {
        requestUrl = @"http://leshouzhan.platline.com/api/order/getFailureInformation";
    }
    
    if (self.searchBar.text.length > 0) {
        [params setObject:self.searchBar.text forKey:@"ordersn"];
    }
    
    if (self.begintInputTF.text.length > 0) {
        [params setObject:self.begintInputTF.text forKey:@"start"];
    }
    
    if (self.endInputTF.text.length > 0) {
        [params setObject:self.endInputTF.text forKey:@"end"];
    }
    
    [CPRetireveOrderModel modelRequestWith:requestUrl
                                parameters:params
                                     block:^(CPRetireveOrderModel *result) {
                                         [weakSelf handlesearchFinisheAdnOverDuedOrderDataBlock:result];
                                     } fail:^(CPError *error) {
                                         
                                     }];
}

- (void)handlesearchFinisheAdnOverDuedOrderDataBlock:(CPRetireveOrderModel *)result {
    
    if ([result isKindOfClass:[CPRetireveOrderModel class]] && result.data.count > 0) {
        
        CPRetrieveOrderListVC *vc = [[CPRetrieveOrderListVC alloc] init];
        if (self.type == CPOrderSearchTypeOverDueOrder) {
            vc.title = @"失效订单";
        } else if (self.type == CPOrderSearchTypeOverFinishedOrder) {
            vc.title = @"回收订单";
        }
        vc.model = result;
        
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        [self.view makeToast:@"未查到符合的数据" duration:1.0f position:CSToastPositionCenter];
    }
    
}


@end
