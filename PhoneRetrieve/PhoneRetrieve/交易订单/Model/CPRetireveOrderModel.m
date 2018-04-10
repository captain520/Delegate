//
//  CPRetireveOrderModel.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/4/9.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPRetireveOrderModel.h"

@implementation CPRetireveOrderModel


+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [CPRetrieveOrderDataModel class]};
}
@end
@implementation CPRetrieveOrderDataModel

+ (NSDictionary *)objectClassInArray{
    return @{@"info" : [CPRetrieveOrderInfoModel class]};
}

@end


@implementation CPRetrieveOrderInfoModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"Typename" : @"typename", @"ID" : @"id"};
}

@end


