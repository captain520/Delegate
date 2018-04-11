//
//  CPBankListModel.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/4/11.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBankListModel.h"

@implementation CPBankListModel


+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [CPBankListDataModel class]};
}
@end
@implementation CPBankListDataModel

@end


