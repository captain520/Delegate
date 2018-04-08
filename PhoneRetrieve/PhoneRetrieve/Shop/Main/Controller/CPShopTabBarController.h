//
//  CPShopTabBarController.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/6.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPTabBarController.h"

typedef NS_ENUM(NSUInteger,CPTabVCType) {
   CPTabVCTypeShop,
   CPTabVCTypeAssistant,
   CPTabVCTypeOther
};

@interface CPShopTabBarController : CPTabBarController

- (void)initializedBaseViewControllersFor:(CPTabVCType)type;

@end
