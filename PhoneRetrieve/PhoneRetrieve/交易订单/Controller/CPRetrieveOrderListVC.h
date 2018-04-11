//
//  CPRetrieveOrderListVC.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/4/4.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPRefreshTableVC.h"
#import "CPRetireveOrderModel.h"

@interface CPRetrieveOrderListVC : CPRefreshTableVC

@property (nonatomic, assign) CPRetrieveOrderListType type;
@property (nonatomic, strong) CPRetireveOrderModel *model;

@end
