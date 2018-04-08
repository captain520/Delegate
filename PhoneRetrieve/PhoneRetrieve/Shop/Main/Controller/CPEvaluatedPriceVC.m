//
//  CPEvaluatedPriceVC.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/27.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPEvaluatedPriceVC.h"
#import "CPEvaluatePriceHeader.h"
#import "CPEvaluatedTypeHeader.h"
#import "CPEvaluatedContentCell.h"
#import "CPSelectCell.h"
#import "CPDeviceOwnerInfoVC.h"
#import "CPShopGoodsListVC.h"

@interface CPEvaluatedPriceVC ()

@property (nonatomic, strong) NSMutableArray <NSIndexPath *> *selectedIndexPath;
@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) NSMutableArray *itemDatas;
@property (nonatomic, assign) BOOL hasAgreeProtocol;

@end

@implementation CPEvaluatedPriceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataArray = @[
                       @[@""],
                       @[@"",@"",@""],
                       @[@"备份手机数据",@"接触ID锁",@"回复出厂设置"]
                       ];
    
    self.selectedIndexPath = @[].mutableCopy;
    
    self.dataTableView.allowsMultipleSelection = YES;
    
    [self.nextButton addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.dataTableView.frame = CGRectMake(0, NAV_HEIGHT, SCREENWIDTH, SCREENHEIGHT - NAV_HEIGHT - NAV_HEIGHT);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIButton *)nextButton {
    
    if (nil == _nextButton) {
        _nextButton = [UIButton new];
        _nextButton.titleLabel.font = CPFont_L;
        [_nextButton setTitle:@"下一步" forState:0];
        [_nextButton setBackgroundColor:MainColor];
        [_nextButton setTitleColor:UIColor.whiteColor forState:0];

        _nextButton.enabled = NO;
        [_nextButton setBackgroundImage:CPEnableImage forState:UIControlStateNormal];
        [_nextButton setBackgroundImage:CPDisableImage forState:UIControlStateDisabled];
        
        [self.view addSubview:_nextButton];
        
        [_nextButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_offset(0);
            make.height.mas_equalTo(CELL_HEIGHT_F * 3 / 2);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
        }];
    }
    
    return _nextButton;
}

- (void)setItemDicts:(NSArray<NSDictionary *> *)itemDicts {
    _itemDicts = itemDicts;
    
    
    self.itemDatas = @[].mutableCopy;
    
    [itemDicts enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *tempArray = obj[@"data"];
        [tempArray enumerateObjectsUsingBlock:^(NSDictionary *obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
            NSDictionary *tempDict = @{obj[@"name"] : obj1[@"name"]};
            [self.itemDatas addObject:tempDict];
        }];
    }];

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {

    switch (section) {
        case 0:
            return 200.0f;
        case 1:
            return cellSpaceOffset;
            break;

        default:
            break;
    }
    
    return CELL_HEIGHT_F;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if (section == 0) {
       
        NSString *headerIdenitfier = @"headerIdenitfier";
        
        CPEvaluatePriceHeader *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdenitfier];
        if (!footer) {
            CGFloat height = [self tableView:tableView heightForFooterInSection:section];
            footer = [[CPEvaluatePriceHeader alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, height)];
        }
        
        [footer.reevaluedButton addTarget:self action:@selector(revalueAction:) forControlEvents:64];
        
        footer.cp_content = self.model.price;

        return footer;
    } else {
        
//        NSString *headerIdenitfier = @"CPEvaluatedTypeHeader";
//        CPEvaluatedTypeHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdenitfier];
//        if (!header) {
//            header = [[CPEvaluatedTypeHeader alloc] initWithReuseIdentifier:headerIdenitfier];
//        }
//
//        header.title = @"评估详情";
//
//        return header;
    }
    
    return nil;
}

- (void)revalueAction:(id)sender {
    
    [self.navigationController popToRootViewControllerAnimated:YES];
//    [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if ([obj isKindOfClass:[CPShopGoodsListVC class]]) {
//            [self.navigationController popViewControllerAnimated:YES];
//
//            *stop = YES;
//        }
//    }];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return cellSpaceOffset;
        case 2:
            return 0.000000001;
            break;
            
        default:
            break;
    }
    
    return 30.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (0 == section || 2 == section) {
        return nil;
    }
    
    NSString *headerIdenitfier = @"CPEvaluatedTypeHeader";
    CPEvaluatedTypeHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdenitfier];
    if (!header) {
        header = [[CPEvaluatedTypeHeader alloc] initWithReuseIdentifier:headerIdenitfier];
    }
    
    header.title = @"评估详情";
    
    return header;
    
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
        {
            return self.itemDatas.count;
//            __block NSUInteger itemCount = 0;
//
//            [self.itemDicts enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                NSArray *tempArray = obj[@"data"];
//
//                itemCount += tempArray.count;
//            }];
//
//            return itemCount;
        }
            break;
        case 2:
            return 1;
            break;
        default:
            break;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 1:
        case 2:
            return 30.0f;
            break;

        default:
            break;
    }
    
    return CELL_HEIGHT_F;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id cell = nil;
    
    switch (indexPath.section) {
        case 0:
            cell = [self configHintCell:indexPath];
            break;
        case 1:
            cell = [self configEvaluatedContentCell:indexPath];
            break;
        case 2:
            cell = [self configDataHandleCell:indexPath];
            break;
            
        default:
            cell = [self configHintCell:indexPath];
            break;
    }
    
//    static NSString *cellIdentify = @"CellIdentify";
    
//    CPDeviceProblemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
//    if (nil == cell) {
//        cell = [[CPDeviceProblemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
//        cell.clipsToBounds = YES;
//        cell.shouldShowBottomLine = NO;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        cell.contentView.backgroundColor = tableView.backgroundColor;
//    }
//
//    NSArray *tempArray = self.dataArray[indexPath.section];
//
//    cell.imageName = @"question_mark";
//    cell.title = tempArray[indexPath.row];
//    cell.shouldHighted = [self.selectedIndexPath containsObject:indexPath];
    
    return cell;
}

- (id)configHintCell:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentify = @"configHintCell";
    
    UITableViewCell *cell = [self.dataTableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentify];
        cell.imageView.image = CPImage(@"SafetyTips");
        cell.textLabel.text = @"苹果安全小帖士";
        cell.detailTextLabel.text = @"iOS系统恢复出厂设置, 无需担心数据泄漏风险";
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.contentView.backgroundColor = UIColor.clearColor;
        cell.backgroundColor = UIColor.clearColor;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return cell;
}

- (CPEvaluatedContentCell *)configEvaluatedContentCell:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentify = @"CPEvaluatedContentCell";
    
    CPEvaluatedContentCell *cell = [self.dataTableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[CPEvaluatedContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.itemDict = self.itemDatas[indexPath.row];
    
    return cell;
}

- (id)configDataHandleCell:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentify = @"CPSelectCell";
    
    CPSelectCell *cell = [self.dataTableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (!cell) {
        cell = [[CPSelectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.shouldShowBottomLine = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    NSArray <NSString * > *contents = self.dataArray[indexPath.section];
    cell.hasSelected = [self.selectedIndexPath containsObject:indexPath];
//    cell.content = [contents objectAtIndex:indexPath.row];
    cell.content = [CPUserInfoModel shareInstance].operationDes;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (2 == indexPath.section) {
        
        [self.selectedIndexPath containsObject:indexPath] ?
        [self.selectedIndexPath removeObject:indexPath] : [self.selectedIndexPath addObject:indexPath];
        
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        self.hasAgreeProtocol = [self.selectedIndexPath containsObject:indexPath];
        
        self.nextButton.enabled = self.hasAgreeProtocol;
    }
}

#pragma mark - private method

- (void)nextAction:(UIButton *)sender {
    NSLog(@"------------------------------");
    CPDeviceOwnerInfoVC *vc = [[CPDeviceOwnerInfoVC alloc] init];
    vc.model = self.model;
    
    [self.navigationController pushViewController:vc animated:YES];
//    [self push2VCWith:@"CPDeviceOwnerInfoVC" title:@"客户信息"];
}


@end
