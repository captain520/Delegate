//
//  CPRewardHeader.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/4/3.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPHeaderFooter.h"
#import "CPRewardModel.h"
#import "CPRetireveOrderModel.h"

@interface CPRewardHeader : CPHeaderFooter

@property (nonatomic, strong) CPRewardDataModel *model;

@property (nonatomic, strong) CPRetrieveOrderDataModel *dataModel;

@end
