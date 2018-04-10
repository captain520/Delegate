//
//  CPDeductDetailModel.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/4/9.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseModel.h"

@class CPDeductDetailDataModel,CPDeductDetailInfoModel;
@interface CPDeductDetailModel : CPBaseModel


@property (nonatomic, assign) NSInteger code;

@property (nonatomic, strong) NSArray<CPDeductDetailDataModel *> *data;

@property (nonatomic, copy) NSString *currentpage;

@property (nonatomic, copy) NSString *pagesize;

@property (nonatomic, assign) NSInteger total;


@end
@interface CPDeductDetailDataModel : NSObject

@property (nonatomic, copy) NSString *createtime;

@property (nonatomic, assign) CGFloat total_price;

@property (nonatomic, strong) NSArray<CPDeductDetailInfoModel *> *info;

@end

@interface CPDeductDetailInfoModel : NSObject

@property (nonatomic, copy) NSString *brandname;

@property (nonatomic, copy) NSString *Typename;

@property (nonatomic, copy) NSString *shopname;

@property (nonatomic, assign) CGFloat kou_price;

@property (nonatomic, assign) CGFloat price;

@property (nonatomic, copy) NSString *resultno;

@end

