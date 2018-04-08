//
//  CPRefreshTableVC.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/4/4.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBaseVC.h"

@interface CPRefreshTableVC : CPBaseVC<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *dataTableView;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, assign) NSInteger currentPageIndex;

- (void)loadData;

@end
