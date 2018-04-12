//
//  CPAddShopVC.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/4/3.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPAddShopVC.h"
#import "CPPhotoUploadBT.h"
#import "TZImagePickerController.h"
#import "CPRemittanceInfoTBVC.h"
#import "CPUserDetailInfoModel.h"

@interface CPAddShopVC ()<CPSelectTextFieldDelegat>

@property (nonatomic, strong) CPTextField *shopNameTF, *shopAddressTF, *shopOwnerTF, *shopPhoneTF, *shopEmailT;
@property (nonatomic, strong) CPSelectTextField *proviceTF, *cityTF, *areaTF;
@property (nonatomic, strong) CPPhotoUploadBT *businessLicenseBT, *IDFrontBT, *IDBackBT;
@property (nonatomic,strong) CPButton *nextAction;
@property (nonatomic, strong) NSArray  *proviceArray, *cityArray, *areaArray;
@property (nonatomic, strong) CPProviceCityAreaModel *cityModel, *proviceModel, *areaModel;

@property (nonatomic, strong) CPUserDetailInfoModel *model;

@end

@implementation CPAddShopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.dataTableView reloadData];
    
    [self loadProvice];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//    [self.shopNameTF becomeFirstResponder];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 700;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentify = @"CellIdentify";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentify];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentify];
        cell.clipsToBounds = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        if (nil == self.shopNameTF) {
            self.shopNameTF = [CPTextField new];
            self.shopNameTF.font = [UIFont systemFontOfSize:13.0f];
            self.shopNameTF.placeholder = @"公司名称";
            self.shopNameTF.borderStyle = UITextBorderStyleRoundedRect;
            //        self.shopNameTF.keyboardType = UIKeyboardTypeNumberPad;

            [cell.contentView addSubview:self.shopNameTF];
            [self.shopNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(cellSpaceOffset);
                make.left.mas_equalTo(cellSpaceOffset);
                make.right.mas_equalTo(-cellSpaceOffset);
                make.height.mas_equalTo(CELL_HEIGHT_F);
            }];
            
        }
        
        CGFloat width = (SCREENWIDTH - 4 * cellSpaceOffset) / 3;
        
        if (nil == self.proviceTF) {
            
            self.proviceTF = [[CPSelectTextField alloc] initWithFrame:CGRectMake(0, 0, width, CELL_HEIGHT_F)];
            self.proviceTF.placeholder = @"选择省";
            self.proviceTF.cp_editDelegate = self;
            self.proviceTF.type = 0;
            
            [cell.contentView addSubview:self.proviceTF];
            
            [self.proviceTF mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.shopNameTF.mas_bottom).offset(cellSpaceOffset);
                make.left.mas_equalTo(cellSpaceOffset);
                make.width.mas_equalTo(width);
                make.height.mas_equalTo(CELL_HEIGHT_F);
            }];
        }
        
        if (nil == self.cityTF) {
            
            self.cityTF = [[CPSelectTextField alloc] initWithFrame:CGRectMake(0, 0, width, CELL_HEIGHT_F)];
            self.cityTF.placeholder = @"选择市";
            //        self.cityTF.dataArray = @[@"aaa",@"bbb",@"ccc"];
            self.cityTF.cp_editDelegate = self;
            self.cityTF.type = 1;
            
            [cell.contentView addSubview:self.cityTF];
            
            [self.cityTF mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.shopNameTF.mas_bottom).offset(cellSpaceOffset);
                make.left.mas_equalTo(self.proviceTF.mas_right).offset(cellSpaceOffset);
                make.width.mas_equalTo(width);
                make.height.mas_equalTo(CELL_HEIGHT_F);
            }];
        }
        
        if (nil == self.areaTF) {
            
            self.areaTF = [[CPSelectTextField alloc] initWithFrame:CGRectMake(0, 0, width, CELL_HEIGHT_F)];
            self.areaTF.placeholder = @"选择区";
            //        self.areaTF.dataArray = @[@"----",@"xxxx",@">>>>>>"];
            self.areaTF.cp_editDelegate = self;
            self.areaTF.type = 2;
            
            [cell.contentView addSubview:self.areaTF];
            
            [self.areaTF mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.shopNameTF.mas_bottom).offset(cellSpaceOffset);
                make.left.mas_equalTo(self.cityTF.mas_right).offset(cellSpaceOffset);
                make.width.mas_equalTo(width);
                make.height.mas_equalTo(CELL_HEIGHT_F);
            }];
        }
        
        if (nil == self.shopAddressTF) {
            self.shopAddressTF = [CPTextField new];
            self.shopAddressTF.font = [UIFont systemFontOfSize:13.0f];
            self.shopAddressTF.placeholder = @"详细地址";
            self.shopAddressTF.borderStyle = UITextBorderStyleRoundedRect;
            //        self.shopAddressTF.keyboardType = UIKeyboardTypeNumberPad;
            
            [cell.contentView addSubview:self.shopAddressTF];
            
            [self.shopAddressTF mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.proviceTF.mas_bottom).offset(cellSpaceOffset);
                make.left.mas_equalTo(cellSpaceOffset);
                make.right.mas_equalTo(-cellSpaceOffset);
                make.height.mas_equalTo(CELL_HEIGHT_F);
            }];
            
        }
        
        if (nil == self.shopOwnerTF) {
            self.shopOwnerTF = [CPTextField new];
            self.shopOwnerTF.font = [UIFont systemFontOfSize:13.0f];
            self.shopOwnerTF.placeholder = @"联系人姓名";
            self.shopOwnerTF.borderStyle = UITextBorderStyleRoundedRect;
            //        self.shopOwnerTF.keyboardType = UIKeyboardTypeNumberPad;
            
            [cell.contentView addSubview:self.shopOwnerTF];
            
            [self.shopOwnerTF mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.shopAddressTF.mas_bottom).offset(cellSpaceOffset);
                make.left.mas_equalTo(cellSpaceOffset);
                make.right.mas_equalTo(-cellSpaceOffset);
                make.height.mas_equalTo(CELL_HEIGHT_F);
            }];
            
        }
        
        if (nil == self.shopPhoneTF) {
            
            self.shopPhoneTF = [CPTextField new];
            self.shopPhoneTF.font                   = [UIFont systemFontOfSize:13.0f];
            self.shopPhoneTF.placeholder            = @"负责人联系方式";
            self.shopPhoneTF.borderStyle            = UITextBorderStyleRoundedRect;
            self.shopPhoneTF.keyboardType           = UIKeyboardTypeNumberPad;
            self.shopPhoneTF.userInteractionEnabled = self.type == 0;

            [cell.contentView addSubview:self.shopPhoneTF];
            [self.shopPhoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.shopOwnerTF.mas_bottom).offset(cellSpaceOffset);
                make.left.mas_equalTo(cellSpaceOffset);
                make.right.mas_equalTo(-cellSpaceOffset);
                make.height.mas_equalTo(CELL_HEIGHT_F);
            }];
        }
        
        if (nil == self.shopEmailT) {
            self.shopEmailT             = [CPTextField new];
            self.shopEmailT.font        = [UIFont systemFontOfSize:13.0f];
            self.shopEmailT.placeholder = @"邮箱";
            self.shopEmailT.borderStyle = UITextBorderStyleRoundedRect;
            
            [cell.contentView addSubview:self.shopEmailT];
            
            [self.shopEmailT mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.shopPhoneTF.mas_bottom).offset(cellSpaceOffset);
                make.left.mas_equalTo(cellSpaceOffset);
                make.right.mas_equalTo(-cellSpaceOffset);
                make.height.mas_equalTo(CELL_HEIGHT_F);
            }];
        }
        
        if (nil == self.businessLicenseBT) {
            
            self.businessLicenseBT = [CPPhotoUploadBT new];
            
            [cell.contentView addSubview:self.businessLicenseBT];
            
            [self.businessLicenseBT setBackgroundImage:CPImage(@"add_pic") forState:UIControlStateNormal];
            [self.businessLicenseBT addTarget:self action:@selector(showImagePickVC:) forControlEvents:UIControlEventTouchUpInside];
            [self.businessLicenseBT mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.shopEmailT.mas_bottom).offset(cellSpaceOffset);
                make.left.mas_equalTo(cellSpaceOffset);
                make.size.mas_equalTo(CGSizeMake(2 * CELL_HEIGHT_F, 2 * CELL_HEIGHT_F));
            }];
        }
        
        
        CPLabel *licenseTitleLB = [CPLabel new];
        licenseTitleLB.text          = @"营业执照";
        licenseTitleLB.textColor     = [UIColor redColor];
        licenseTitleLB.textAlignment = NSTextAlignmentCenter;
        
        [cell.contentView addSubview:licenseTitleLB];
        
        [licenseTitleLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.businessLicenseBT.mas_bottom).offset(4);
            make.left.mas_equalTo(self.businessLicenseBT.mas_left);
            make.right.mas_equalTo(self.businessLicenseBT.mas_right);
        }];
        
        
        if (nil == self.IDFrontBT) {
            
            self.IDFrontBT = [CPPhotoUploadBT new];
            
            [cell.contentView addSubview:self.IDFrontBT];
            
            [self.IDFrontBT setBackgroundImage:CPImage(@"add_pic") forState:UIControlStateNormal];
            [self.IDFrontBT addTarget:self action:@selector(showImagePickVC:) forControlEvents:UIControlEventTouchUpInside];
            [self.IDFrontBT mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(licenseTitleLB.mas_bottom).offset(cellSpaceOffset);
                make.left.mas_equalTo(cellSpaceOffset);
                make.size.mas_equalTo(CGSizeMake(2 * CELL_HEIGHT_F, 2 * CELL_HEIGHT_F));
            }];
            
            CPLabel *titleLB = [CPLabel new];
            titleLB.text = @"身份证正面";
            titleLB.textAlignment = NSTextAlignmentCenter;
            titleLB.textColor = [UIColor redColor];
            
            [cell.contentView addSubview:titleLB];
            
            [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.IDFrontBT.mas_bottom).offset(4);
                make.left.mas_equalTo(self.IDFrontBT.mas_left);
                make.right.mas_equalTo(self.IDFrontBT.mas_right);
            }];
        }
        
        if (nil == self.IDBackBT) {
            
            self.IDBackBT = [CPPhotoUploadBT new];
            [self.IDBackBT setBackgroundImage:CPImage(@"add_pic") forState:UIControlStateNormal];
            [self.IDBackBT addTarget:self action:@selector(showImagePickVC:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.contentView addSubview:self.IDBackBT];
            
            [self.IDBackBT mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.IDFrontBT.mas_top);
                make.left.mas_equalTo(self.IDFrontBT.mas_right).offset(cellSpaceOffset);
                make.size.mas_equalTo(CGSizeMake(2 * CELL_HEIGHT_F, 2 * CELL_HEIGHT_F));
            }];
            
            CPLabel *titleLB = [CPLabel new];
            titleLB.text = @"身份证背面";
            titleLB.textAlignment = NSTextAlignmentCenter;
            titleLB.textColor = [UIColor redColor];
            
            [cell.contentView addSubview:titleLB];
            
            [titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.IDBackBT.mas_bottom).offset(4);
                make.left.mas_equalTo(self.IDBackBT.mas_left);
                make.right.mas_equalTo(self.IDBackBT.mas_right);
            }];
        }
        
        if (nil == self.nextAction) {
            
            self.nextAction = [[CPButton alloc] initWithFrame:CGRectZero];
            [self.nextAction setTitle:@"下一步" forState:0];
            [self.nextAction addTarget:self action:@selector(nextAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.contentView addSubview:self.nextAction];
            
            [self.nextAction mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.IDBackBT.mas_bottom).mas_equalTo(CELL_HEIGHT_F);
                make.left.mas_equalTo(cellSpaceOffset);
                make.right.mas_equalTo(-cellSpaceOffset);
                make.height.mas_equalTo(CELL_HEIGHT_F);
            }];
            
            RAC(self.nextAction,enabled) = [RACSignal combineLatest:@[
                                                                      self.shopNameTF.rac_textSignal,
                                                                      self.proviceTF.rac_textSignal,
                                                                      self.cityTF.rac_textSignal,
                                                                      self.areaTF.rac_textSignal,
                                                                      self.shopAddressTF.rac_textSignal,
                                                                      self.shopOwnerTF.rac_textSignal,
                                                                      self.shopPhoneTF.rac_textSignal,
                                                                      self.shopEmailT.rac_textSignal
                                                                      ] reduce:^id{
                                                                          return @(
                                                                          self.shopNameTF.text.length > 0 &&
                                                                          self.proviceTF.text.length > 0 &&
                                                                          self.cityTF.text.length > 0 &&
                                                                          self.areaTF.text.length > 0 &&
                                                                          self.shopAddressTF.text.length > 0 &&
                                                                          self.shopOwnerTF.text.length > 0 &&
                                                                          self.shopPhoneTF.text.length > 0 &&
                                                                          self.shopEmailT.text.length > 0 &&
                                                                          self.businessLicenseBT.imageUrl.length > 0&&
                                                                          self.IDFrontBT.imageUrl.length > 0
                                                                          && self.IDBackBT.imageUrl.length > 0);
                                                                      }];
            
        }
    }
    
    if (self.model) {
        self.shopNameTF.text            = self.model.companyname;
        self.proviceTF.text             = self.model.province;
        self.cityTF.text                = self.model.city;
        self.areaTF.text                = self.model.district;
        self.shopAddressTF.text         = self.model.address;
        self.shopOwnerTF.text           = self.model.linkname;
        self.shopPhoneTF.text           = self.model.phone;
        self.shopEmailT.text            = self.model.email;
        self.businessLicenseBT.imageUrl = self.model.licenseurl;
        self.IDFrontBT.imageUrl         = self.model.idcard1url;
        self.IDBackBT.imageUrl          = self.model.idcard2url;
        
        [self.businessLicenseBT sd_setImageWithURL:CPUrl(self.model.licenseurl) forState:0];
        [self.IDFrontBT sd_setImageWithURL:CPUrl(self.model.idcard1url) forState:0];
        [self.IDBackBT sd_setImageWithURL:CPUrl(self.model.idcard2url) forState:0];
    }

    return cell;
}

- (void)cp_textFieldDidBeginEditing:(UITextField *)textField model:(CPProviceCityAreaModel *)model {
    if (textField == self.proviceTF) {
        
    }
}

- (void)cp_textFieldDidEndEditing:(UITextField *)textField model:(CPProviceCityAreaModel *)model{
    
    if (model == nil) {
        return;
    }
    
    if (textField == self.proviceTF) {
        [self loadCity:model.Code];
        self.proviceModel = model;
    } else if (textField == self.cityTF) {
        [self loadArea:model.Code];
        self.cityModel = model;
    } else if (textField == self.areaTF) {
        self.areaModel = model;
    }
    
    [self handleImagePickImageBlock];
}

#pragma mark - private method

- (void)showImagePickVC:(CPPhotoUploadBT *)sender {
    
    __weak typeof(self) weakSelf = self;
    
    TZImagePickerController *vc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:nil];
    
    [vc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        NSLog(@"------");
        dispatch_async(dispatch_get_main_queue(), ^{
            [sender setImage:photos.firstObject forState:UIControlStateNormal];
            
            [[CPProgress Instance] showLoading:self.view message:@"图片上传中"];
            
            [CPBaseModel uploadImages:photos.firstObject block:^(NSString *filePath) {
                DDLogError(@">>>>>>>>>>>>>>>>>>>>%@",filePath);
                sender.imageUrl = filePath;
                [[CPProgress Instance] hidden];
                [weakSelf handleImagePickImageBlock];
            }];
            
        });
    }];
    
    
    UINavigationController *nav = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    [nav presentViewController:vc animated:YES completion:nil];
}

- (void)handleImagePickImageBlock {
    
    self.nextAction.enabled = (
                               self.shopNameTF.text.length > 0
                               && self.proviceTF.text.length > 0
                               && self.cityTF.text.length > 0
                               && self.areaTF.text.length > 0
                               && self.shopAddressTF.text.length > 0
                               && self.shopOwnerTF.text.length > 0
                               && self.shopEmailT.text.length > 0
                               && self.shopPhoneTF.text.length > 0
                               && self.businessLicenseBT.imageUrl.length > 0
                               && self.IDFrontBT.imageUrl.length > 0
                               && self.IDBackBT.imageUrl.length > 0
                               );
}

- (void)nextAction:(id)sender {
    
    DDLogInfo(@"%s------------------------------",__FUNCTION__);
    
    [CPRegistParam shareInstance].phone       = self.shopPhoneTF.text;
    [CPRegistParam shareInstance].companyname = self.shopNameTF.text;
    [CPRegistParam shareInstance].provinceid  = self.proviceModel.Code ? self.proviceModel.Code : self.model.provinceid;
    [CPRegistParam shareInstance].cityid      = self.cityModel.Code ? self.cityModel.Code : self.model.cityid;
    [CPRegistParam shareInstance].districtid  = self.areaModel.Code ? self.areaModel.Code : self.model.districtid;
    [CPRegistParam shareInstance].address     = self.shopAddressTF.text;
    [CPRegistParam shareInstance].linkname    = self.shopOwnerTF.text;
    [CPRegistParam shareInstance].email       = self.shopEmailT.text;
    [CPRegistParam shareInstance].licenseurl  = self.businessLicenseBT.imageUrl;
    [CPRegistParam shareInstance].idcard1url  = self.IDFrontBT.imageUrl;
    [CPRegistParam shareInstance].idcard2url  = self.IDBackBT.imageUrl;

    CPRemittanceInfoTBVC *vc = [[CPRemittanceInfoTBVC alloc] init];
    if (self.type == 0) {
        [CPRegistParam shareInstance].code = [NSString stringWithFormat:@"%ld",[CPUserInfoModel shareInstance].loginModel.ID];
        vc.registType = CPRegistTypePersonalAddShop;
    } else if (self.type == 1) {
        vc.registType = CPRegistTypePersonalEditShop;
        [CPRegistParam shareInstance].code = [NSString stringWithFormat:@"%ld",self.model.ID];
        vc.userDetailModel = self.model;
        vc.title = IS_SHOP ? @"编辑门店收款账号":@"编辑商家收款账号";
    }

    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - load data

- (void)loadProvice {
    
    __weak typeof(self) weakSelf = self;
    
    [CPProviceCityAreaModel modelRequestWith:@"http://leshouzhan.platline.com/api/area/findData?parentcode=0"
                                  parameters:nil
                                       block:^(id result) {
                                           [weakSelf handleLoadProviceBlock:result];
                                       } fail:^(CPError *error) {
                                           
                                       }];
}

- (void)handleLoadProviceBlock:(NSArray <CPProviceCityAreaModel *> *)result {
    if (!result || ![result isKindOfClass:[NSArray class]]) {
        return;
    }
    
    self.proviceArray = result;
    
    self.proviceTF.dataArray = self.proviceArray;
}

- (void)loadCity:(NSString *)paramCode {
    
    __weak typeof(self) weakSelf = self;
    
    [CPProviceCityAreaModel modelRequestWith:@"http://leshouzhan.platline.com/api/area/findData"
                                  parameters:@{@"parentcode" : paramCode}
                                       block:^(id result) {
                                           [weakSelf handleLoadCityBlock:result];
                                       } fail:^(CPError *error) {
                                           
                                       }];
}

- (void)handleLoadCityBlock:(NSArray <CPProviceCityAreaModel *> *)result {
    if (!result || ![result isKindOfClass:[NSArray class]]) {
        return;
    }
    
    self.cityArray = result;
    
    self.cityTF.dataArray = self.cityArray;
}

- (void)loadArea:(NSString *)paramCode {
    
    __weak typeof(self) weakSelf = self;
    
    [CPProviceCityAreaModel modelRequestWith:@"http://leshouzhan.platline.com/api/area/findData"
                                  parameters:@{@"parentcode" : paramCode}
                                       block:^(id result) {
                                           [weakSelf handleLoadAreaBlock:result];
                                       } fail:^(CPError *error) {
                                           
                                       }];
}

- (void)handleLoadAreaBlock:(NSArray <CPProviceCityAreaModel *> *)result {
    if (!result || ![result isKindOfClass:[NSArray class]]) {
        return;
    }
    
    self.areaArray = result;
    
    self.areaTF.dataArray = self.areaArray;
}

- (void)loadData {
    if (self.type == 0) {
        [self.dataTableView reloadData];
    } else if (self.type == 1) {
        [self loadUserDetail];
    }
}

- (void)loadUserDetail {
    
    DDLogInfo(@"------------------------------");
    
    __weak typeof(self) weakSelf = self;
    
    [CPUserDetailInfoModel modelRequestWith:@"http://leshouzhan.platline.com/api/user/getDetailUserInfo"
                                 parameters:@{@"userid" : @(self.ID)}
                                      block:^(CPUserDetailInfoModel *result) {
                                          [weakSelf handleLoadDataSuccessBlock:result];
                                      } fail:^(NSError *error) {
                                          
                                      }];
}

- (void)handleLoadDataSuccessBlock:(CPUserDetailInfoModel *)result {
    
    if (!result || ![result isKindOfClass:[CPUserDetailInfoModel class]]) {
        
        [self.view makeToast:result.msg duration:1.0f position:CSToastPositionCenter];
        
        return;
    }
    
    self.model = result;
    
    [self.dataTableView reloadData];
}

@end
