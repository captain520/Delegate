//
//  CPMemberManagerModel.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/4/9.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPMemberManagerModel.h"

@implementation CPMemberManagerModel


+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [CPMemberManagerDataModel class]};
}
@end
@implementation CPMemberManagerDataModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"Typeid" : @"typeid",@"ID": @"id", @"Code" : @"code"};
}

@end


