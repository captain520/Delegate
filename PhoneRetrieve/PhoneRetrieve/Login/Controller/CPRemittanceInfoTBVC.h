//
//  CPRemittanceInfoTBVC.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/6.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseTableVC.h"
#import "CPUserDetailInfoModel.h"

@interface CPRemittanceInfoTBVC : CPBaseTableVC

@property (nonatomic, assign) CPRegistType registType;

@property (nonatomic,strong) CPUserDetailInfoModel *userDetailModel;

@end
