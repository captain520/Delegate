//
//  CPRegistStepView.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/5.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPView.h"

@interface CPRegistStepView : CPView

@property (nonatomic, strong) NSArray <NSString *> *titles;

@property (nonatomic, assign) NSInteger currentStep;

@end
