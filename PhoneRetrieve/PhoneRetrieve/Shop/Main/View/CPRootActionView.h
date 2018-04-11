//
//  CPRootActionView.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/4/2.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPView.h"

@interface CPRootActionView : CPView

@property (nonatomic, strong) UIButton *rewardBT;
@property (nonatomic, strong) UIButton *rewardRecordBT, *orderBT, *shopManagerBT, *logistisBT, *accountManagerBT;

@property (nonatomic, assign) BOOL isShop;

@end
