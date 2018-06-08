//
//  CPChangeUserBaseInfoVC.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/4/9.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPChangeUserBaseInfoVC.h"

@interface CPChangeUserBaseInfoVC ()

@property (nonatomic, strong) CPTextField *nameTF, *pricipalTF, *phoneTF, *emailTF;

@property (nonatomic, strong) CPButton *nextActionBT;

@end

@implementation CPChangeUserBaseInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

- (void)setupUI {
   
    {
        _nameTF = [CPTextField new];
        _nameTF.placeholder = @"代理名称";
        
        [self.view addSubview:_nameTF];
        _nameTF.text = [CPUserInfoModel shareInstance].userDetaiInfoModel.companyname;
        [_nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(NAV_HEIGHT + cellSpaceOffset);
            make.left.mas_offset(cellSpaceOffset);
            make.right.mas_offset(-cellSpaceOffset);
            make.height.mas_offset(CELL_HEIGHT_F);
        }];
    }
    
    {
        _pricipalTF = [CPTextField new];
        _pricipalTF.placeholder = @"代理负责人";
        _pricipalTF.text = [CPUserInfoModel shareInstance].userDetaiInfoModel.linkname;

        [self.view addSubview:_pricipalTF];
        [_pricipalTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_nameTF.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_offset(cellSpaceOffset);
            make.right.mas_offset(-cellSpaceOffset);
            make.height.mas_offset(CELL_HEIGHT_F);
        }];
    }
    
    {
        _phoneTF = [CPTextField new];
        _phoneTF.placeholder = @"手机号码";
        _phoneTF.text = [CPUserInfoModel shareInstance].userDetaiInfoModel.phone;
        
        [self.view addSubview:_phoneTF];
        [_phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_pricipalTF.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_offset(cellSpaceOffset);
            make.right.mas_offset(-cellSpaceOffset);
            make.height.mas_offset(CELL_HEIGHT_F);
        }];
    }
    
    {
        _emailTF = [CPTextField new];
        _emailTF.placeholder = @"电子邮箱";
        _emailTF.text = [CPUserInfoModel shareInstance].userDetaiInfoModel.email;

        [self.view addSubview:_emailTF];
        [_emailTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_phoneTF.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_offset(cellSpaceOffset);
            make.right.mas_offset(-cellSpaceOffset);
            make.height.mas_offset(CELL_HEIGHT_F);
        }];
    }
    
    {
        _nextActionBT = [CPButton new];

        [self.view addSubview:_nextActionBT];
        [_nextActionBT addTarget:self action:@selector(nextAction:) forControlEvents:64];
        [_nextActionBT setTitle:@"确定修改" forState:0];
        [_nextActionBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_emailTF.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_offset(cellSpaceOffset);
            make.right.mas_offset(-cellSpaceOffset);
            make.height.mas_offset(CELL_HEIGHT_F);
        }];
        
        RAC(_nextActionBT, enabled) = [RACSignal combineLatest:@[
                                                                 self.nameTF.rac_textSignal,
                                                                 self.pricipalTF.rac_textSignal,
                                                                 self.phoneTF.rac_textSignal,
                                                                 self.emailTF.rac_textSignal
                                                                 ]
                                                        reduce:^id{
                                                            return @(
                                                            self.nameTF.text.length > 0 &&
                                                            self.pricipalTF.text.length > 0 &&
                                                            self.phoneTF.text.length > 0 &&
                                                            self.emailTF.text.length > 0 &&
                                                            CheckPhone(self.phoneTF.text)
                                                            );
                                                        }];
    }
    
    [self.nameTF becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)nextAction:(id)sender {
    
    __weak typeof(self) weakSelf = self;
    
    NSDictionary *params = @{
                             @"companyname" : self.nameTF.text,
                             @"linkname" : self.pricipalTF.text,
                             @"phone" : self.phoneTF.text,
                             @"email" : self.emailTF.text,
                             @"code" : [CPUserInfoModel shareInstance].userDetaiInfoModel.cpcode
                             }.copy;
    
    [CPBaseModel modelRequestWith:DOMAIN_ADDRESS@"api/user/updateUserInfo"
                       parameters:params
                            block:^(id result) {
                                [weakSelf handleUpdateBlock];
                            } fail:^(CPError *error) {
                                
                            }];
    
}

- (void)handleUpdateBlock {
    
    [[CPProgress Instance] showSuccess:self.view message:@"修改成功" finish:^(BOOL finished) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
}

@end
