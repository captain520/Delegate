//
//  CPMemberManagerModel.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/4/9.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseModel.h"

@class CPMemberManagerDataModel;
@interface CPMemberManagerModel : CPBaseModel


@property (nonatomic, assign) NSInteger code;

@property (nonatomic, strong) NSArray<CPMemberManagerDataModel *> *data;


@property (nonatomic, assign) NSInteger currentpage;

@property (nonatomic, assign) NSInteger pagesize;

@property (nonatomic, assign) NSInteger total;


@end
@interface CPMemberManagerDataModel : NSObject

@property (nonatomic, assign) NSInteger Typeid;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *ID;

@property (nonatomic, copy) NSString *Code;

@property (nonatomic, copy) NSString *linkname;

@property (nonatomic, assign) NSInteger checkcfg;

@property (nonatomic, copy) NSString *companyname;

@property (nonatomic, copy) NSString *createtime;

@end

