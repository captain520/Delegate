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

@interface CPAssistantManagerVC ()<UIAlertViewDelegate>

@property (nonatomic, strong) NSArray <CPMemeberListModel *> *models;

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
    
    self.tabbarView.dataArray = @[@"门店信息",@"门店审核"];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self loadData];
}

- (void)loadNavItem {
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(itemAction:)];
    
    self.navigationItem.rightBarButtonItem = item;
    
    [self setTitle:@"店员管理"];
}

- (CPTabBarView *)tabbarView {
    
    if (_tabbarView == nil) {
        
        __weak typeof(self) weakSelf = self;
        
        _tabbarView = [[CPTabBarView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREENWIDTH, CELL_HEIGHT_F)];
        _tabbarView.backgroundColor = [UIColor whiteColor];
        _tabbarView.selectBlock = ^(NSInteger index) {
            weakSelf.currentTabIndex = index;
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
    return 130;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdenitifier = @"CPAssistantInfoCell";
    
    CPAssistantInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdenitifier];
    if (nil == cell) {
        cell = [[CPAssistantInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdenitifier];
        cell.clipsToBounds = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.shouldShowBottomLine = NO;
    }
    
    
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
//    [self push2VCWith:@"CPAssistantDetailVC" title:@"店员详情"];
    
    CPMemeberListModel *model = self.models[indexPath.section];
    
    CPAssistantDetailVC *vc = [[CPAssistantDetailVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.userid = model.ID;

    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Private method

- (void)itemAction:(id)sender {
    
    CPAddShopVC *vc = [[CPAddShopVC alloc] init];
    vc.title = @"新增门店";

    [self.navigationController pushViewController:vc animated:YES];
}

- (void)editAction:(NSIndexPath *)indexPath {
    
    if (self.currentTabIndex == 0) {
        
        CPAddShopVC *vc = [[CPAddShopVC alloc] init];
        vc.title = @"编辑门店";
        
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if (self.currentTabIndex == 1) {
        
        CPShopCheckVC *vc = [[CPShopCheckVC alloc] init];
        vc.title = @"门店审核";
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}

- (void)deleteAction:(NSIndexPath *)indexPath {
    
    self.willDeleteidnexPath = indexPath;
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否删除该店员信息" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];

    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (1 == buttonIndex) {
        
        CPMemeberListModel *model = self.models[self.willDeleteidnexPath.section];
        
        __weak typeof(self) weakSelf = self;

        [CPBaseModel modelRequestWith:@"http://leshouzhan.platline.com/api/user/deleteUser"
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
    
    [super loadData];
    
    __weak typeof(self) weakSelf = self;
    
    NSDictionary *params = @{
                             @"typeid" : @"4",
                             @"userid" : @([CPUserInfoModel shareInstance].loginModel.ID)
                             };
    
    [CPMemeberListModel modelRequestWith:@"http://leshouzhan.platline.com/api/user/findUserList"
                       parameters:params
                            block:^(id result) {
                                [weakSelf handleLoadDataBlock:result];
                            } fail:^(CPError *error) {
                                
                            }];
}

- (void)handleLoadDataBlock:(NSArray <CPMemeberListModel *> *)result {
    if (!result || ![result isKindOfClass:[NSArray class]]) {
        
        CPBaseModel *emptyModel = (CPBaseModel *)result;

        [self.view makeToast:emptyModel.msg duration:1.0f position:CSToastPositionCenter];

        return;
    }
    
    self.models = result;
    
    [self.dataTableView reloadData];
    
    self.dataTableView.frame = CGRectMake(0, NAV_HEIGHT + CELL_HEIGHT_F, SCREENWIDTH, SCREENHEIGHT - NAV_HEIGHT - CELL_HEIGHT_F);
    
}

@end
