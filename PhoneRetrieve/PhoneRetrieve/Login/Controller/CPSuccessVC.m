//
//  CPSuccessVC.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/4/2.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPSuccessVC.h"

@interface CPSuccessVC ()

@property (nonatomic, strong) UIImageView *iconIV;
@property (nonatomic, strong) CPLabel *desLB;

@end

@implementation CPSuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

- (void)setupUI {
    
    {
        self.navigationItem.rightBarButtonItem = nil;
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:CPImage(@"left") style:UIBarButtonItemStyleDone target:self action:@selector(pop:)];
    }
    
    {
        self.iconIV = [UIImageView new];
        self.iconIV.image = CPImage(@"complete");
        [self.view addSubview:self.iconIV];
        [self.iconIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.top.mas_equalTo(NAV_HEIGHT + CELL_HEIGHT_F);
            make.size.mas_equalTo(CGSizeMake(100, 100));
        }];
    }
    
    {
        self.desLB = [CPLabel new];
        self.desLB.font = CPFont_XL;
        self.desLB.text = @"我们已经收到您提交的信息，我们的工作人员会尽快给您审核。请您耐心等待!!!🙂";
        [self.view addSubview:self.desLB];
        [self.desLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.iconIV.mas_bottom).offset(CELL_HEIGHT_F);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private medtho

- (void)pop:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
//    [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if ([NSStringFromClass(obj.class) isEqualToString:@"CPLoginVC"]) {
//            [self.navigationController popToViewController:obj animated:YES];
//
//            *stop = YES;
//        }
//    }];
}

@end
