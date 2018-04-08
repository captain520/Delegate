//
//  CPRefreshTableVC.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/4/4.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPRefreshTableVC.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

@interface CPRefreshTableVC ()<DZNEmptyDataSetDelegate,DZNEmptyDataSetSource>

@end

@implementation CPRefreshTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.currentPageIndex = 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setDataArray:(NSArray *)dataArray {
    _dataArray = dataArray;
    
    //    [self.dataTableView reloadData];
}

#pragma mark - Setter && Getter method implement

- (UITableView *)dataTableView {
    
    if (nil == _dataTableView) {
        
        __weak typeof(self) weakselff = self;
        
        CGRect frame = CGRectMake(0, NAV_HEIGHT, SCREENWIDTH, SCREENHEIGHT - NAV_HEIGHT);
        
        _dataTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        //        _dataTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _dataTableView.delegate             = self;
        _dataTableView.dataSource           = self;
        _dataTableView.separatorColor       = UIColor.clearColor;
        _dataTableView.backgroundColor      = BgColor;
        _dataTableView.keyboardDismissMode  = UIScrollViewKeyboardDismissModeOnDrag;
        _dataTableView.emptyDataSetSource   = self;
        _dataTableView.emptyDataSetDelegate = self;
        _dataTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            DDLogInfo(@"header refresh");
            
            self.currentPageIndex = 1;
            
            [weakselff loadData];
        }];
        _dataTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            DDLogInfo(@"footer refresh");
            
            self.currentPageIndex++;
            
            [weakselff loadData];
        }];
        
        [self.view addSubview:_dataTableView];
    }
    
    return _dataTableView;
}

#pragma mark - Tableview Delegate and datasouce method implement

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CELL_HEIGHT_F;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentify = @"CellIdentify";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.clipsToBounds = YES;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = @"-----";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.000000001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return CPImage(@"noData");
}


#pragma mark - Private method

- (void)loadData {
    
    DDLogInfo(@"---------Current Page: %ld-----------",self.currentPageIndex);
    [self.dataTableView.mj_header endRefreshing];
    [self.dataTableView.mj_footer endRefreshing];
    //    [self.dataTableView.mj_footer endRefreshingWithNoMoreData];
    
    [self.dataTableView reloadData];
}


@end
