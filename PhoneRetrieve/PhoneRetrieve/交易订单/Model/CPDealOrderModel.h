//
//  CPDealOrderModel.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/4/9.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseModel.h"

@class CPDealOrderDataModel,CPDealOrderInfoModel;
@interface CPDealOrderModel : CPBaseModel

@property (nonatomic, assign) NSInteger code;

@property (nonatomic, strong) NSArray<CPDealOrderDataModel *> *data;

@property (nonatomic, copy) NSString *currentpage;

@property (nonatomic, copy) NSString *pagesize;

@property (nonatomic, assign) NSInteger total;

@end

@interface CPDealOrderDataModel : NSObject

@property (nonatomic, copy) NSString *createtime;

@property (nonatomic, assign) CGFloat total_price;

@property (nonatomic, strong) NSArray<CPDealOrderInfoModel *> *info;

@end

@interface CPDealOrderInfoModel : NSObject

@property (nonatomic, assign) NSInteger number;

@property (nonatomic, copy) NSString *ordersn;

@property (nonatomic, assign) NSInteger paycfg;

@property (nonatomic, assign) CGFloat total_price;

@property (nonatomic, assign) CGFloat distribution_price;

@property (nonatomic, assign) CGFloat kou_price;

@property (nonatomic, copy) NSString *doorname;

@property (nonatomic, copy) NSString *createtime;

@property (nonatomic, copy) NSString *orderid;

@end

