//
//  CPShippingInformationListVC.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/28.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPRefreshTableVC.h"

typedef NS_ENUM(NSUInteger, CPTabBarType) {
    CPTabBarTypeShippingState,
    CPTabBarTypePayState,
//    CPTabBarType
//    CPTabBarType
    CPTabBarTypePayOther,
};

@interface CPShippingInformationListVC : CPRefreshTableVC

@property (nonatomic, assign) CPTabBarType tabbarType;

@end
