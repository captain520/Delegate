//
//  CPOrderSearchVC.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/28.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseVC.h"
#import "CPOrderListPageModel.h"

typedef NS_ENUM(NSUInteger,CPOrderSearchType) {
    CPOrderSearchTypeShipping,
    CPOrderSearchTypeOrder,
    CPOrderSearchTypeOther,
    CPOrderSearchTypeShopPaidOrder,
    CPOrderSearchTypeShopPayAndUnpaidOrder,
    CPOrderSearchTypeShopUnpaidOrder,
    CPOrderSearchTypeOverDueOrder,
    CPOrderSearchTypeOverFinishedOrder,
    CPOrderSearchTypeReward
};

@interface CPOrderSearchVC : CPBaseVC

@property (nonatomic, assign) CPOrderSearchType type;

@end
