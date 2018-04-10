//
//  CPRetrieveDetailCell.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/4/4.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseCell.h"
#import "CPRetireveOrderModel.h"

@interface CPRetrieveDetailCell : CPBaseCell

@property (nonatomic, strong) CPRetrieveOrderInfoModel *model;

@property (nonatomic, assign) CPRetrieveOrderListType type;

@end
