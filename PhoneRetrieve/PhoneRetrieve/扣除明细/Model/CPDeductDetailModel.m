//
//  CPDeductDetailModel.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/4/9.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPDeductDetailModel.h"

@implementation CPDeductDetailModel


+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [CPDeductDetailDataModel class]};
}
@end
@implementation CPDeductDetailDataModel

+ (NSDictionary *)objectClassInArray{
    return @{@"info" : [CPDeductDetailInfoModel class]};
}

@end


@implementation CPDeductDetailInfoModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"Typename" : @"typename"};
}

@end


