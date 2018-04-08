//
//  CPShopHelpVC.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/7.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPShopHelpVC.h"
#import "CPShopHelpHeader.h"
#import "CPImageLeftRightCell.h"
#import "CPCustomHelperModel.h"
#import "CPWebVC.h"

@interface CPShopHelpVC ()

@property (nonatomic, strong) CPCustomHelperModel *model;

@end

@implementation CPShopHelpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.dataArray = @[
                       @[@"",@"",@"",@""]
                       ];
    
    [self loadData];
    
    [self setupUI];
}

- (void)setupUI {
    
    UILabel *copyRightLB = [UILabel new];
    copyRightLB.font = CPFont_M;
    copyRightLB.textAlignment = NSTextAlignmentCenter;
    copyRightLB.text = @"深圳市奇积网络科技有限公司";

    [self.view addSubview:copyRightLB];
    
    [copyRightLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-cellSpaceOffset);
        make.height.mas_equalTo(CELL_HEIGHT_F);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 180.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    NSString *headerIdentifier = @"CPShopHelpHeader";
    
    CPShopHelpHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier];
    if (nil == header) {
        header = [[CPShopHelpHeader alloc] initWithReuseIdentifier:headerIdentifier];
    }
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CELL_HEIGHT_F;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdenitifier = @"CPImageLeftRightCell";
    
    CPImageLeftRightCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdenitifier];
    if (nil == cell) {
        cell = [[CPImageLeftRightCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdenitifier];
        cell.clipsToBounds = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (3 == indexPath.row) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    switch (indexPath.row) {
        case 0:
        {
            cell.image = @"WeChat";
            cell.leftValue = @"微信公众号";
            cell.rightValue = self.model.wx;
        }
            break;
        case 1:
        {
            cell.image = @"consumerhotline";
            cell.leftValue = @"客服电话";
            cell.rightValue = self.model.tel;//@"400-xxxx";
        }
            
            break;
        case 2:
        {
            cell.image = @"email";
            cell.leftValue = @"电子邮箱";
            cell.rightValue = self.model.email;//@"123456@163.com";
        }
            
            break;
        case 3:
        {
            cell.image = @"aboutme";
            cell.leftValue = @"关于我们";
            cell.rightValue = self.model.Description;//@"";
        }
            
            break;

        default:
            break;
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s",__FUNCTION__);
    
    if (3 == indexPath.row) {
        
        [self getConfigUrl:@"220" block:^(NSString *url, NSString *title) {
            CPWebVC *webVC = [[CPWebVC alloc] init];
            //        webVC.urlStr = @"https://www.baidu.com";
            webVC.contentStr = url;
            webVC.title = title;
            webVC.hidesBottomBarWhenPushed = YES;
            
            [self.navigationController pushViewController:webVC animated:YES];
        }];
    }
    
}

#pragma mark - private method

- (void)loadData {
    
    __weak CPShopHelpVC *weakSelf = self;
    
    [CPCustomHelperModel modelRequestWith:CPURL_CONFIG_CUSTOMER_HELP
                               parameters:nil
                                    block:^(CPCustomHelperModel *result) {
                                        [weakSelf handleLoadDataBlock:result];
                                    } fail:^(CPError *error) {
                                        
                                    }];
}

- (void)handleLoadDataBlock:(CPCustomHelperModel *)result {
    self.model = result;
    [self.dataTableView reloadData];
}

@end
