//
//  CPBankListModel.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/4/11.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseModel.h"

@class CPBankListDataModel;
@interface CPBankListModel : CPBaseModel


@property (nonatomic, assign) NSInteger code;

@property (nonatomic, strong) NSArray<CPBankListDataModel *> *data;

@property (nonatomic, copy) NSString *msg;

@property (nonatomic, assign) NSInteger currentpage;

@property (nonatomic, assign) NSInteger pagesize;

@property (nonatomic, assign) NSInteger total;


@end
@interface CPBankListDataModel : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) NSInteger userid;

@property (nonatomic, copy) NSString *createtime;

@property (nonatomic, copy) NSString *ordersn;

@property (nonatomic, copy) NSString *balance;

@property (nonatomic, assign) NSInteger statuscfg;

@end

