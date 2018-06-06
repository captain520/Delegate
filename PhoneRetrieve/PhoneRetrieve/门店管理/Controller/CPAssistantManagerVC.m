//
//  CPAssistantManagerVC.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/7.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPAssistantManagerVC.h"
#import "CPAssistantInfoCell.h"
#import "CPAssistantEditVC.h"
#import "CPMemeberListModel.h"
#import "CPAssistantRegisterVC.h"
#import "CPAssistantDetailVC.h"
#import "CPAssistantOrderListVC.h"
#import "CPTabBarView.h"
#import "CPAddShopVC.h"
#import "CPShopCheckVC.h"
#import "CPMemberManagerModel.h"

@interface CPAssistantManagerVC ()<UIAlertViewDelegate>

@property (nonatomic, strong) NSIndexPath *willDeleteidnexPath;
@property (nonatomic, strong) CPTabBarView *tabbarView;
@property (nonatomic, assign) NSInteger currentTabIndex;

@end

@implementation CPAssistantManagerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataArray = @[
                       @[@""],
                       @[@""],
                       @[@""],
                       @[@""],
                       @[@""],
                       @[@""],
                       @[@""],
                       @[@""],
                       @[@""]
                       ];

    
    self.dataTableView.separatorColor = [UIColor whiteColor];
    
//    [self loadData];
    
    [self loadNavItem];
    
    if (IS_SHOP) {
        self.tabbarView.dataArray = @[@"门店信息",@"门店审核"];
    } else if (IS_ASSISTANT) {
        self.tabbarView.dataArray = @[@"商家信息",@"商家审核"];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self loadData];
}

- (void)loadNavItem {
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(itemAction:)];
    
    self.navigationItem.rightBarButtonItem = item;
    
//    [self setTitle:@"店员管理"];
}

- (CPTabBarView *)tabbarView {
    
    if (_tabbarView == nil) {
        
        __weak typeof(self) weakSelf = self;
        
        _tabbarView = [[CPTabBarView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREENWIDTH, CELL_HEIGHT_F)];
        _tabbarView.backgroundColor = [UIColor whiteColor];
        _tabbarView.selectBlock = ^(NSInteger index) {
            weakSelf.currentTabIndex = index;
            
            [weakSelf loadData];
        };
        
        [self.view addSubview:_tabbarView];
    }
    
    return _tabbarView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.models.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return cellSpaceOffset / 2.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 5 * CELL_HEIGHT_F / 2 + CELL_HEIGHT_F;

    if (self.currentTabIndex == 0) {
        return 160;
    } else if (self.currentTabIndex == 1) {
        return 110;
    }
    
    return 150;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdenitifier = @"CPAssistantInfoCell";
    
    CPAssistantInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdenitifier];
    if (nil == cell) {
        cell = [[CPAssistantInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdenitifier];
        cell.clipsToBounds = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.shouldShowBottomLine = NO;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
//    if (self.currentTabIndex == 0) {
//        cell.accessoryType = UITableViewCellAccessoryNone;
//    } else {
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    }

    cell.model = self.models[indexPath.section];
    __weak CPAssistantManagerVC *weakSelf = self;
    
    cell.actionBlock = ^(CPAssistantInfoCellActionType actionType) {
        NSLog(@"section:%ld type:%ld",indexPath.section, actionType);
        [weakSelf handleButtonAction:actionType indexPath:indexPath];
    };
    
    return cell;
}

- (void)handleButtonAction:(CPAssistantInfoCellActionType)type indexPath:(NSIndexPath *)indexPath {
    switch (type) {
        case CPAssistantInfoCellActionTypeEdit:
            [self editAction:indexPath];
            break;
        case CPAssistantInfoCellActionTypeDelete:
            [self deleteAction:indexPath];
            break;
        case CPAssistantInfoCellActionTypeDetail:
            [self showOrderListAction:indexPath];
            break;

        default:
            break;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    CPMemberManagerDataModel *model = self.models[indexPath.section];
    
    NSString *title = @"门店详情";
    
    CPShopCheckVC *vc = [[CPShopCheckVC alloc] init];
    
    if (self.currentTabIndex == 0) {
        title = IS_SHOP ? @"门店详情" : @"商家详情";
        vc.type = CPShopCheckTypeDetail;
    } else if (self.currentTabIndex == 1) {
        title = IS_SHOP ? @"门店审核" : @"商家审核";
        vc.type = CPShopCheckTypeCheck;
    }
    
    vc.title = title;
    vc.userID = model.ID;

    [self.navigationController pushViewController:vc animated:YES];

    
//    [self push2VCWith:@"CPAssistantDetailVC" title:@"店员详情"];
    
//    CPMemeberListModel *model = self.models[indexPath.section];
//
//    CPAssistantDetailVC *vc = [[CPAssistantDetailVC alloc] init];
//    vc.hidesBottomBarWhenPushed = YES;
//    vc.userid = model.ID;
//
//    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Private method

- (void)itemAction:(id)sender {
    
    CPAddShopVC *vc = [[CPAddShopVC alloc] init];
    vc.title = IS_SHOP ? @"新增门店" : @"新增商家";

    [self.navigationController pushViewController:vc animated:YES];
}

- (void)editAction:(NSIndexPath *)indexPath {
    
    if (self.currentTabIndex == 0) {
        
        CPMemberManagerDataModel *dataModel = self.models[indexPath.section];
        
        CPAddShopVC *vc = [[CPAddShopVC alloc] init];
        vc.title = IS_SHOP ? @"编辑门店" : @"编辑商家";
        vc.type = 1;
        vc.ID = dataModel.ID.integerValue;
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }
//    else if (self.currentTabIndex == 1) {
//
//        CPShopCheckVC *vc = [[CPShopCheckVC alloc] init];
//        vc.title = @"门店审核";
//
//        [self.navigationController pushViewController:vc animated:YES];
//
//    }
    
}

- (void)deleteAction:(NSIndexPath *)indexPath {
    
    self.willDeleteidnexPath = indexPath;
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message: IS_SHOP ?  @"是否删除该店员信息" : @"是否删除该商家信息"
                                                       delegate:self
                                              cancelButtonTitle:@"取消"
                                              otherButtonTitles:@"确定", nil];

    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (1 == buttonIndex) {
        
        CPMemberManagerDataModel *model = self.models[self.willDeleteidnexPath.section];
        
        __weak typeof(self) weakSelf = self;

        [CPBaseModel modelRequestWith:@"http://api.leshouzhan.com/api/user/deleteUser"
                           parameters:@{@"userid" : model.ID}
                                block:^(id result) {
                                    [weakSelf handleDeleteSuccessBlock:result];
                                } fail:^(CPError *error) {
                                    [weakSelf.view makeToast:error.cp_msg duration:2.0f position:CSToastPositionCenter];
                                }];
    }
}


- (void)handleDeleteSuccessBlock:(CPBaseModel *)result {
    
    [self.view makeToast:result.msg duration:1.0f position:CSToastPositionCenter];
    
    [self loadData];
}

- (void)showOrderListAction:(NSIndexPath *)indexPath {
    
    CPMemeberListModel *model = self.models[indexPath.section];

    CPAssistantOrderListVC *vc = [[CPAssistantOrderListVC alloc] init];
    vc.userid = model.ID;
    vc.hidesBottomBarWhenPushed = YES;

    [self.navigationController pushViewController:vc animated:YES];
}

- (void)loadData {

    __weak typeof(self) weakSelf = self;
    
    NSMutableDictionary *params = @{
                             @"typeid" : @"1",
                             @"userid" : @([CPUserInfoModel shareInstance].loginModel.ID)
                             }.mutableCopy;
    
    if (self.currentTabIndex == 1) {
        [params setObject:@"1" forKey:@"type"];
        
        if (IS_SHOP) {
            [params setObject:@"3" forKey:@"typeid"];
        } else if (IS_ASSISTANT) {
            [params setObject:@"2" forKey:@"typeid"];
        }
    } else if (self.currentTabIndex == 0) {
        
        if (IS_SHOP) {
            [params setObject:@"3" forKey:@"typeid"];
        } else if (IS_ASSISTANT) {
            [params setObject:@"2" forKey:@"typeid"];
        }
    }

    [CPMemberManagerModel modelRequestWith:@"http://api.leshouzhan.com/api/user/findUserList"
                       parameters:params
                            block:^(CPMemberManagerModel *result) {
                                [weakSelf handleLoadDataBlock:result];
                            } fail:^(CPError *error) {
                                
                            }];
}

- (void)handleLoadDataBlock:(CPMemberManagerModel *)result {
    
    if (!result.data || ![result isKindOfClass:[CPMemberManagerModel class]]|| ![result.data isKindOfClass:[NSArray class]]) {
        [self.models removeAllObjects];
    } else {
        [self.models addObjectsFromArray:result.data];
    }
    
    if (self.models.count >= result.total) {
        [self.dataTableView.mj_header endRefreshing];
        [self.dataTableView.mj_footer endRefreshingWithNoMoreData];
    } else {
        [self.dataTableView.mj_header endRefreshing];
        [self.dataTableView.mj_footer endRefreshing];
    }
    
    [self.dataTableView reloadData];
    
//    if (!result || ![result isKindOfClass:[NSArray class]]) {
//
//        CPBaseModel *emptyModel = (CPBaseModel *)result;
//
//        [self.view makeToast:emptyModel.msg duration:1.0f position:CSToastPositionCenter];
//
//        return;
//    }
//
//    self.models = result;
//
//    [self.dataTableView reloadData];
//
    self.dataTableView.frame = CGRectMake(0, NAV_HEIGHT + CELL_HEIGHT_F, SCREENWIDTH, SCREENHEIGHT - NAV_HEIGHT - CELL_HEIGHT_F);
    
}

@end
