//
//  CPGoodSearchResultVC.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/3/21.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPGoodSearchResultVC.h"
#import "CPGoodModel.h"

@interface CPGoodSearchResultVC ()<UISearchBarDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;

@end

@implementation CPGoodSearchResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.dataTableView addSubview:self.searchBar];
    
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.searchBar becomeFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentify = @"CellIdentify";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.clipsToBounds = YES;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    CPGoodModel *model = self.dataArray[indexPath.section][indexPath.row];
    cell.textLabel.text = model.name;
    
    return cell;
}

- (UISearchBar *)searchBar {
    
    if (nil == _searchBar) {
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, CELL_HEIGHT_F)];
        _searchBar.barTintColor = MainColor;//[UIColor clearColor];
        _searchBar.showsCancelButton = YES;
        //        _searchBar.backgroundColor = [UIColor redColor];
        _searchBar.layer.borderColor = MainColor.CGColor;
        _searchBar.backgroundImage = [UIImage new];
        _searchBar.delegate = self;
    }
    
    return _searchBar;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
//    [self.view endEditing:YES];
//        [self push2VCWith:@"CPSearchVC" title:nil];
//    [self push2VCWith:@"CPGoodSearchResultVC" title:nil];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    DDLogInfo(@"i0i0i0i0i0i0i0i0i0i0");
    __weak typeof(self) weakSelf = self;
    
    NSDictionary *params= @{
                            @"name" : self.searchBar.text
                            };
    
    [CPGoodModel modelRequestWith:CPURL_SHOP_GOOD_LIST
                       parameters:params
                            block:^(id result) {
                                [weakSelf handleLoadGoodsBlock:result];
                            } fail:^(CPError *error) {
                                
                            }];
}

- (void)handleLoadGoodsBlock:(NSArray <CPGoodModel *> *)result {
    if (!result || ![result isKindOfClass:[NSArray class]]) {
        self.dataArray = @[];
    } else {
        self.dataArray = @[result];
    }

    [self.dataTableView reloadData];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self push2VCWith:@"CPFlowVC" title:@"手机是否存在以下问题？"];
}

@end
