//
//  CPRewardModel.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/4/8.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseModel.h"

@class CPRewardDataModel,CPRewardInfoModel;
@interface CPRewardModel : CPBaseModel

@property (nonatomic, assign) NSInteger code;

@property (nonatomic, strong) NSArray<CPRewardDataModel *> *data;

@property (nonatomic, copy) NSString *currentpage;

@property (nonatomic, copy) NSString *pagesize;

@property (nonatomic, assign) NSInteger total;

@end


@interface CPRewardDataModel : NSObject

@property (nonatomic, strong) NSArray<CPRewardInfoModel *> *info;

@property (nonatomic, copy) NSString *createtime;

@property (nonatomic, assign) CGFloat distribution_price;

@property (nonatomic, assign) CGFloat total_price;

@end

@interface CPRewardInfoModel : NSObject

@property (nonatomic, copy) NSString *doorname;

@property (nonatomic, assign) CGFloat totalprice;

@property (nonatomic, copy) NSString *createtime;

@property (nonatomic, copy) NSString *ordersn;

@property (nonatomic, assign) CGFloat price;

@property (nonatomic, copy) NSString *orderid;

@end

