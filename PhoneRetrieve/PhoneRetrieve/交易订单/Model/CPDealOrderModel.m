//
//  CPDealOrderModel.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/4/9.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPDealOrderModel.h"

@implementation CPDealOrderModel


+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [CPDealOrderDataModel class]};
}
@end
@implementation CPDealOrderDataModel

+ (NSDictionary *)objectClassInArray{
    return @{@"info" : [CPDealOrderInfoModel class]};
}

@end


@implementation CPDealOrderInfoModel

@end


