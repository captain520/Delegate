//
//  CPRewardModel.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/4/8.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPRewardModel.h"

@implementation CPRewardModel


+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [CPRewardDataModel class]};
}
@end


@implementation CPRewardDataModel

+ (NSDictionary *)objectClassInArray{
    return @{@"info" : [CPRewardInfoModel class]};
}

@end


@implementation CPRewardInfoModel

@end


