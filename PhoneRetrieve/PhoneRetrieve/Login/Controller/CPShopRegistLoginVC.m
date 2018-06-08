//
//  CPShopRegistVC.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/2.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPShopRegistLoginVC.h"
#import "CPRegistStepView.h"
#import "CPSendCodeButton.h"
#import "CPCheckBox.h"
#import "CPWebVC.h"
#import "CPShopRegistInfoTBVC.h"

@interface CPShopRegistLoginVC ()

@property (nonatomic, strong) CPTextField *accountTF, *codeTF, *passwdTF, *confirmTF;
@property (nonatomic, strong) CPSendCodeButton *sendCodeBT;
@property (nonatomic, strong) CPCheckBox *checkBox;
@property (nonatomic, assign) BOOL agreeProtocol;
@property (nonatomic, strong) CPButton *nextBT;
@property (nonatomic, strong) UIButton *compayBT, *personalBT;

@property (nonatomic, strong) CPTextField *shopCodeTF;
@property (nonatomic, assign) CPRegistType currentRegistType;

@end

@implementation CPShopRegistLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
    
    self.navigationItem.rightBarButtonItem = nil;
}

- (void)setupUI {
    

    CPRegistStepView *stepView = [[CPRegistStepView alloc] initWithFrame:CGRectMake(0, NAV_HEIGHT, SCREENWIDTH, 44.9f)];
    if (self.registType == CPRegistTypeShop) {
        stepView.titles =@[
                           @"注册只需3步",
                           @"1.登录信息",
                           @"2.商家信息",
                           @"3.账号信息"
                           ];
    } else {
        stepView.titles =@[
                           @"注册只需3步",
                           @"1.登录信息",
                           @"2.代理信息",
                           @"3.账号信息"
                           ];

    }
    
    stepView.currentStep = 0;

    [self.view addSubview:stepView];
    
    if (nil == self.accountTF) {
        self.accountTF = [CPTextField new];
        self.accountTF.font = [UIFont systemFontOfSize:13.0f];
        self.accountTF.placeholder = @"手机号码";
        self.accountTF.borderStyle = UITextBorderStyleRoundedRect;
        self.accountTF.keyboardType = UIKeyboardTypeNumberPad;
        
        [self.view addSubview:self.accountTF];
        
        [self.accountTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(stepView.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];

    }
    
    if (nil == self.sendCodeBT) {
        self.sendCodeBT = [[CPSendCodeButton alloc] initWithFrame:CGRectMake(0, 110, 120, CELL_HEIGHT_F)];
        self.sendCodeBT.layer.cornerRadius = 5.0f;
        self.sendCodeBT.clipsToBounds = YES;
        [self.sendCodeBT setBackgroundImage:CPEnableImage forState:UIControlStateNormal];
        [self.sendCodeBT setBackgroundImage:CPDisableImage forState:UIControlStateDisabled];
        [self.sendCodeBT setTitle:@"获取验证码" forState:UIControlStateNormal];
        
        [self.view addSubview:self.sendCodeBT];
        
        [self.sendCodeBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-cellSpaceOffset);
            make.top.mas_equalTo(self.accountTF.mas_bottom).offset(cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
            make.width.mas_equalTo(120.0f);
        }];
        
        RAC(self.sendCodeBT,enabled) = [RACSignal combineLatest:@[self.accountTF.rac_textSignal] reduce:^id{
            self.sendCodeBT.phoneNumber = self.accountTF.text;
            return @(CheckPhone(self.accountTF.text));
        }];
    }
    
    if (nil == self.codeTF) {
        self.codeTF = [CPTextField new];
        self.codeTF.keyboardType = UIKeyboardTypeNumberPad;
        self.codeTF.font = [UIFont systemFontOfSize:13.0];
        self.codeTF.borderStyle = UITextBorderStyleRoundedRect;
        self.codeTF.placeholder = @"验证码(4位)";
        
        [self.view addSubview:self.codeTF];
        
        [self.codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.sendCodeBT.mas_top);
            make.left.mas_equalTo(cellSpaceOffset);
            make.bottom.mas_equalTo(self.sendCodeBT.mas_bottom);
            make.right.mas_equalTo(self.sendCodeBT.mas_left).offset(-8);
        }];

    }

    if (nil == self.passwdTF) {
        self.passwdTF = [CPTextField new];
//        self.passwdTF.keyboardType = UIKeyboardTypeNumberPad;
        self.passwdTF.font = [UIFont systemFontOfSize:13.0];
        self.passwdTF.borderStyle = UITextBorderStyleRoundedRect;
        self.passwdTF.placeholder = @"设置登录密码";
        self.passwdTF.secureTextEntry = YES;
        
        [self.view addSubview:self.passwdTF];
        
        [self.passwdTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.codeTF.mas_bottom).offset(cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            
        }];
    }
    
    if (nil == self.confirmTF) {
        self.confirmTF = [CPTextField new];
//        self.confirmTF.keyboardType = UIKeyboardTypeNumberPad;
        self.confirmTF.font = [UIFont systemFontOfSize:13.0];
        self.confirmTF.borderStyle = UITextBorderStyleRoundedRect;
        self.confirmTF.placeholder = @"确认登陆密码";
        self.confirmTF.secureTextEntry = YES;

        [self.view addSubview:self.confirmTF];
        
        [self.confirmTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.passwdTF.mas_bottom).offset(cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
        }];
    }
    
    {
        if (self.registType == CPRegistTypeAssistant) {
            
            {
                self.compayBT = [UIButton new];
                self.compayBT.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                self.compayBT.titleLabel.font = CPFont_M;
                [self.compayBT addTarget:self action:@selector(switchDeleateType:) forControlEvents:64];
                [self.compayBT setImage:CPImage(@"choose_preseed") forState:0];
                [self.compayBT setTitleColor:C33 forState:0];
                [self.compayBT setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
                [self.compayBT setTitle:@"公司代理注册" forState:0];
                
                [self.view addSubview:self.compayBT];
                [self.compayBT mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(self.confirmTF.mas_bottom).offset(cellSpaceOffset);
                    make.left.mas_equalTo(cellSpaceOffset);
                    make.height.mas_equalTo(30);
                }];
            }
            
            {
                self.personalBT = [UIButton new];
                self.personalBT.titleLabel.font = CPFont_M;
                self.personalBT.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                [self.personalBT addTarget:self action:@selector(switchDeleateType:) forControlEvents:64];
                [self.personalBT setTitleColor:C33 forState:0];
                [self.personalBT setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, 0)];
                [self.personalBT setImage:CPImage(@"choose_default") forState:0];
                [self.personalBT setTitle:@"个人代理注册" forState:0];
                
                [self.view addSubview:self.personalBT];
                [self.personalBT mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(self.compayBT.mas_top);
                    make.left.mas_equalTo(self.compayBT.mas_right).offset(cellSpaceOffset);
                    make.right.mas_equalTo(-cellSpaceOffset);
                    make.width.mas_equalTo(self.compayBT.mas_width);
                    make.height.mas_equalTo(self.compayBT.mas_height);
                }];
            }
        }
        
    }
    
    if (nil == self.checkBox) {
        
        NSDictionary *option0 = @{
                                  NSFontAttributeName : [UIFont systemFontOfSize:13.0f],
                                  NSForegroundColorAttributeName : C33
                                  };
        NSMutableAttributedString *attr0 = [[NSMutableAttributedString alloc] initWithString:@" 同意"
                                                                                  attributes:option0];
        NSDictionary *option1 = @{
                                  NSFontAttributeName : [UIFont systemFontOfSize:13.0f],
                                  NSForegroundColorAttributeName : C33,
                                  NSUnderlineStyleAttributeName : @1
                                  };
        NSAttributedString *attr1 = [[NSAttributedString alloc] initWithString:@"《乐收栈注册协议》" attributes:option1];
        
        [attr0 appendAttributedString:attr1];

        
        __weak CPShopRegistLoginVC *weakSelf = self;
        
        self.checkBox = [[CPCheckBox alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        self.checkBox.content = attr0;
        self.checkBox.actionBlock = ^(BOOL aggree) {
            [weakSelf handleAgreeProtocolBlock:aggree];
        };
        
        self.checkBox.showHintBlock = ^{
            [weakSelf getConfigUrl:@"201" block:^(NSString *url, NSString *title) {
                CPWebVC *webVC = [[CPWebVC alloc] init];
                //        webVC.urlStr = @"https://www.baidu.com";
                webVC.contentStr = url;
                webVC.title = title;
                webVC.hidesBottomBarWhenPushed = YES;
                
                [weakSelf.navigationController pushViewController:webVC animated:YES];
            }];
        };

        [self.view addSubview:self.checkBox];
        
        [self.checkBox mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.confirmTF.mas_bottom).offset(100);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(20);
        }];
    }
    
    if(nil == self.nextBT){
        self.nextBT = [[CPButton alloc] initWithFrame:CGRectZero];
        [self.nextBT setTitle:@"下一步" forState:0];
        [self.nextBT addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];

        [self.view addSubview:self.nextBT];
        
        [self.nextBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.checkBox.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F);
        }];
        
        RAC(self.nextBT,enabled) = [RACSignal combineLatest:@[
                                                         self.accountTF.rac_textSignal,
                                                         self.codeTF.rac_textSignal,
                                                         self.passwdTF.rac_textSignal,
                                                         self.confirmTF.rac_textSignal]
                                                reduce:^id{
                                                    return @(
                                                    CheckPhone(self.accountTF.text)
                                                    && self.codeTF.text.length == 4
                                                    && self.passwdTF.text.length > 0
                                                    && self.confirmTF.text.length > 0
                                                    && ([self.confirmTF.text isEqualToString: self.passwdTF.text])
                                                    && self.agreeProtocol);
        }];
        
    }
}

- (void)handleAgreeProtocolBlock:(NSInteger )agrree {
    self.agreeProtocol = agrree;
    
    self.nextBT.enabled = CheckPhone(self.accountTF.text)
    && self.codeTF.text.length == 4
    && self.passwdTF.text.length > 5
    && self.confirmTF.text.length > 5
    && ([self.confirmTF.text isEqualToString:self.passwdTF.text])
    && self.agreeProtocol;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private method

- (void)switchDeleateType:(UIButton *)sender {
    if (sender == self.compayBT) {
        
        self.currentRegistType = CPRegistTypeCompanyDelegate;
        
        [self.compayBT setImage:CPImage(@"choose_preseed") forState:0];
        [self.personalBT setImage:CPImage(@"choose_default") forState:0];
    } else if (sender == self.personalBT) {
        
        self.currentRegistType = CPRegistTypePersonalDelegate;
        
        [self.compayBT setImage:CPImage(@"choose_default") forState:0];
        [self.personalBT setImage:CPImage(@"choose_preseed") forState:0];
    }
}

- (void)nextAction:(UIButton *)sender {

    [CPRegistParam shareInstance].sms      = self.codeTF.text;
    [CPRegistParam shareInstance].phone    = self.accountTF.text;
    [CPRegistParam shareInstance].password = self.confirmTF.text;

    
    NSString *title = @"商家注册";
    
    if (self.registType == CPRegistTypeShop) {              //  商家
        self.currentRegistType = CPRegistTypeShop;
    } else if (self.registType == CPRegistTypeAssistant) {  //  代理

        if (self.currentRegistType == 0) {
            self.currentRegistType = CPRegistTypeCompanyDelegate;
        }
        
        switch (self.currentRegistType) {
            case CPRegistTypeCompanyDelegate:
                title = @"公司代理注册";
                break;
            case CPRegistTypePersonalDelegate:
                title = @"个人代理注册";
                break;
                
            default:
                break;
        }

    }
    
    CPShopRegistInfoTBVC *vc = [[CPShopRegistInfoTBVC alloc] init];
    vc.title      = title;
    vc.registType = self.currentRegistType;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
