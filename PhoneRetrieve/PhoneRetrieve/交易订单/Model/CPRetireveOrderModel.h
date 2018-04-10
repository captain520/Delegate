//
//  CPRetireveOrderModel.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/4/9.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseModel.h"

@class CPRetrieveOrderDataModel,CPRetrieveOrderInfoModel;
@interface CPRetireveOrderModel : CPBaseModel


@property (nonatomic, assign) NSInteger code;

@property (nonatomic, strong) NSArray<CPRetrieveOrderDataModel *> *data;

@property (nonatomic, copy) NSString *currentpage;

@property (nonatomic, copy) NSString *pagesize;

@property (nonatomic, assign) NSInteger total;


@end
@interface CPRetrieveOrderDataModel : NSObject

@property (nonatomic, assign) NSInteger number;

@property (nonatomic, strong) NSArray<CPRetrieveOrderInfoModel *> *info;

@property (nonatomic, copy) NSString *createtime;

@property (nonatomic, assign) CGFloat total_price;

@end

@interface CPRetrieveOrderInfoModel : NSObject

@property (nonatomic, copy) NSString *Typename;

@property (nonatomic, assign) NSInteger sendcfg;

@property (nonatomic, assign) CGFloat price;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *doorname;

@property (nonatomic, copy) NSString *resultno;

@property (nonatomic, copy) NSString *brandname;

@end

