//
//  CPRootVC.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/4/2.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPRootVC.h"
#import <SDCycleScrollView.h>
#import "CPHomeAdvModel.h"
#import "CPWebVC.h"
#import "CPRootActionView.h"
#import "CPOrderSearchVC.h"
#import "CPLoginVC.h"
#import "CPShippingInformationListVC.h"
#import "CPAssistantManagerVC.h"
#import "CPTabBarView.h"
#import "CPShopAccountManagerVC.h"
#import "CPDeductDetailVC.h"
#import "CPBankListVC.h"
#import <SCLoopScrollView/SCLoopScrollView.h>

@interface CPRootVC ()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *adSV;
//@property (nonatomic, strong) SCLoopScrollView *adSV;
@property (nonatomic, strong) NSArray <CPHomeAdvModel *> *advModels;
@property (nonatomic, strong) CPRootActionView *actionView;

@end


@implementation CPRootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    

    [self setupUI];
    
    [self loadData];
    
    
    if ([CPUserInfoModel shareInstance].isLogined == NO) {
        [self push2LoginVC];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    NSString *title = nil;
    NSString *code = [CPUserInfoModel shareInstance].loginModel.cp_code;;
    
    [self setTitle:code];
    
    self.adSV.imageURLStringsGroup = [self.advModels valueForKeyPath:@"imageurl"];

//    if (IS_SHOP) {
//        title = [NSString stringWithFormat:@"商家编号：%@",code];
//        [self setTitle:@"商家编号：123456"];
//    } else if (IS_ASSISTANT) {
//        title = [NSString stringWithFormat:@"代理编号：%@",code];
//    }
//
//    [self setTitle:title];
    
    self.actionView.isShop = IS_SHOP;
}

- (SDCycleScrollView *)adSV {
    
    if (nil == _adSV) {
        CGRect adFrame = CGRectMake(0, NAV_HEIGHT, SCREENWIDTH, 200.0f);
        self.adSV = [SDCycleScrollView cycleScrollViewWithFrame:adFrame
                                                       delegate:self
                                               placeholderImage:CPImage(@"Apple")];
        
        //        [self.adSV clearCache];
        //        self.adSV.bannerImageViewContentMode = UIViewContentModeScaleAspectFit;
        
        [self.view addSubview:self.adSV];
    }

    return _adSV;
}

- (void)setupUI {
    
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:CPImage(@"call") style:UIBarButtonItemStylePlain target:self action:@selector(showHelp)];
    
    {
        self.view.backgroundColor = BgColor;
    }
    
    {
//        CGRect adFrame = CGRectMake(0, NAV_HEIGHT, SCREENWIDTH, 200.0f);
//        self.adSV = [SDCycleScrollView cycleScrollViewWithFrame:adFrame
//                                                       delegate:self
//                                               placeholderImage:CPImage(@"Apple")];
//
////        [self.adSV clearCache];
////        self.adSV.bannerImageViewContentMode = UIViewContentModeScaleAspectFit;
//
//        [self.view addSubview:self.adSV];
//
//        self.adSV.imageURLStringsGroup = @[
//                                           @"http://f.hiphotos.baidu.com/image/pic/item/503d269759ee3d6db032f61b48166d224e4ade6e.jpg",
//                                           @"http://a.hiphotos.baidu.com/image/pic/item/500fd9f9d72a6059f550a1832334349b023bbae3.jpg",
//                                           @"http://d.hiphotos.baidu.com/image/pic/item/a044ad345982b2b713b5ad7d3aadcbef76099b65.jpg"
//                                           ];
//        _adSV = [[SCLoopScrollView alloc] initWithFrame:adFrame];
//        _adSV.backgroundColor = [UIColor redColor];
//        _adSV.dataSource = @[
//                             @"http://f.hiphotos.baidu.com/image/pic/item/503d269759ee3d6db032f61b48166d224e4ade6e.jpg",
//                             @"http://a.hiphotos.baidu.com/image/pic/item/500fd9f9d72a6059f550a1832334349b023bbae3.jpg",
//                             @"http://d.hiphotos.baidu.com/image/pic/item/a044ad345982b2b713b5ad7d3aadcbef76099b65.jpg"
//                             ];
//        [self.view addSubview:_adSV];
//
//        [_adSV showWithAutoScroll:YES
//                            taped:^(NSInteger index) {
//
//                            } scrolled:^(NSInteger index) {
//
//                            }];
//        [_adSV show:^(NSInteger index) {
//            NSLog(@"Tap Index:%@", @(index));
//        } scrolled:^(NSInteger index) {
//            NSLog(@"Current Index:%@", @(index));
//        }];
    }
    
    {
        self.actionView = [CPRootActionView new];
        [self.actionView.rewardRecordBT addTarget:self action:@selector(rewardAction:) forControlEvents:64];
        [self.actionView.orderBT addTarget:self action:@selector(push2PlatPayStateVC) forControlEvents:64];
        [self.actionView.shopManagerBT addTarget:self action:@selector(push2ShopManagerVC) forControlEvents:64];
        [self.actionView.accountManagerBT addTarget:self action:@selector(push2AccountManagerVC) forControlEvents:64];
        [self.actionView.logistisBT addTarget:self action:@selector(push2DeductVC) forControlEvents:64];
        [self.actionView.rewardBT addTarget:self action:@selector(push2BankListVC) forControlEvents:64];

        [self.view addSubview:self.actionView];
        [self.actionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.adSV.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(290);
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - SDCycleScrollViewDelegate
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"%s%@",__FUNCTION__,@(index));
    
    CPHomeAdvModel *advModel = self.advModels[index];

    [self push2WebView:advModel.clickurl title:advModel.name];
}

//  跳转到网页
- (void)push2WebView:(NSString *)url title:(NSString *)title {
    
    if (url == nil) {
        url = @"https://www.baidu.com";
    }
    
    CPWebVC *webVC = [[CPWebVC alloc] init];
    webVC.hidesBottomBarWhenPushed = YES;
    //    webVC.urlStr = url;
    webVC.contentStr = url;
    webVC.title = title;
    
    [self.navigationController pushViewController:webVC animated:YES];
    
}

- (void)loadData {
    
    __weak typeof(self) weakSelf = self;
    
    [CPHomeAdvModel modelRequestWith:CPURL_CONFIG_HOME_AD
                          parameters:nil
                               block:^(NSArray <CPHomeAdvModel *> *result) {
                                   [weakSelf handleLoadDataBlock:result];
                               } fail:^(CPError *error) {
                                   
                               }];
}

- (void)handleLoadDataBlock:(NSArray <CPHomeAdvModel *> *)result {
    self.advModels = result;
//    self.adSV.imageURLStringsGroup = [self.advModels valueForKeyPath:@"imageurl"];
//    self.adSV.dataSource = [self.advModels valueForKeyPath:@"imageurl"];
}

#pragma mark -  返佣查询

- (void)rewardAction:(UIButton *)sender {
    
//    CPOrderSearchVC *searchVC = [[CPOrderSearchVC alloc] init];
//    searchVC.title = @"返佣查询";
//
//    [self.navigationController pushViewController:searchVC animated:YES];
    
    [self push2VCWith:@"CPShopRewardListVC" title:@"返佣信息"];
}

#pragma mark - 交易订单信息

- (void)push2PlatPayStateVC {
    
    [self push2VCWith:@"CPShopOrderVC" title:@"订单中心"];
    
//    CPShippingInformationListVC *vc = [[CPShippingInformationListVC alloc] init];
//    vc.title = @"交易订单查询";
//    vc.tabbarType = CPTabBarTypePayState;
//    vc.hidesBottomBarWhenPushed = YES;
//
//    [self.navigationController pushViewController:vc animated:YES];
    
    
    //    [self push2VCWith:@"CPShippingInformationListVC" title:@"订单"];
}

#pragma mark - 门店管理

- (void)push2ShopManagerVC {
    
    CPAssistantManagerVC *vc = [[CPAssistantManagerVC alloc] init];
    if (IS_SHOP) {
        vc.title = @"门店管理";
    } else if (IS_ASSISTANT) {
        vc.title = @"商家管理";
    }

    [self.navigationController pushViewController:vc animated:YES];
}

- (void)push2LoginVC {
    
    CPLoginVC *vc = [[CPLoginVC alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:vc animated:NO];
}

- (void)push2AccountManagerVC {
    
//    CPAccountManagerVC *vc = [[CPAccountManagerVC alloc] init];
//
//    [self.navigationController pushViewController:vc animated:YES];
    
    CPShopAccountManagerVC *vc = [[CPShopAccountManagerVC alloc] init];

    [self.navigationController pushViewController:vc animated:YES];
}

- (void)push2DeductVC {
    
    CPDeductDetailVC *vc = [[CPDeductDetailVC alloc] init];
    vc.title = @"扣除明细";
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)push2BankListVC {
    
    CPBankListVC *bankListVC = [[CPBankListVC alloc] init];
    bankListVC.title = @"打款记录";
    
    [self.navigationController pushViewController:bankListVC animated:YES];
}

- (void)showHelp {
    [self push2VCWith:@"CPShopHelpVC" title:@"我的客服"];
}

@end
