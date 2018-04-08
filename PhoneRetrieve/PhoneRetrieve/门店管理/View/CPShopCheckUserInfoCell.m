//
//  CPShopCheckUserInfoCell.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/4/3.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPShopCheckUserInfoCell.h"

@implementation CPShopCheckUserInfoCell {
    
    CPLabel *shopNameLB, *shopAddressLB, *nameLB, *phoneLB, *emailLB, *licenseHintLB, *IDHintLB;
    UIImageView *licenseIV, *IDFrontIV, *IDBackIV;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupUI {
    
    {
        shopNameLB = [CPLabel new];
        shopNameLB.text = @"门店名称：望江店";
        
        [self.contentView addSubview:shopNameLB];
        [shopNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(cellSpaceOffset);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(SMALL_CELL_HEIGHT_F);
        }];
    }

    {
        shopAddressLB = [CPLabel new];
        shopAddressLB.text = @"门店地址：和平饭店";
        
        [self.contentView addSubview:shopAddressLB];
        [shopAddressLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(shopNameLB.mas_bottom);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(SMALL_CELL_HEIGHT_F);
        }];
    }
    
    {
        nameLB = [CPLabel new];
        nameLB.text = @"联系人：和平";
        
        [self.contentView addSubview:nameLB];
        [nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(shopAddressLB.mas_bottom);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(SMALL_CELL_HEIGHT_F);
        }];
    }
    
    {
        phoneLB = [CPLabel new];
        phoneLB.text = @"联系电话：15814099327";
        
        [self.contentView addSubview:phoneLB];
        [phoneLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(nameLB.mas_bottom);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(SMALL_CELL_HEIGHT_F);
        }];
    }
    
    {
        licenseHintLB = [CPLabel new];
        licenseHintLB.text = @"营业执照:";
        
        [self.contentView addSubview:licenseHintLB];
        [licenseHintLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(phoneLB.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(cellSpaceOffset);
            make.height.mas_equalTo(1.5 * CELL_HEIGHT_F);
            make.width.mas_equalTo(60);
        }];
    }
    
    {
        licenseIV = [UIImageView new];
        licenseIV.image = CPImage(@"camera");

        [self.contentView addSubview:licenseIV];
        [licenseIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(licenseHintLB.mas_top);
            make.left.mas_equalTo(licenseHintLB.mas_right).offset(cellSpaceOffset);
            make.bottom.mas_equalTo(licenseHintLB.mas_bottom);
            make.width.mas_equalTo(licenseIV.mas_height).multipliedBy(1.3);
        }];
    }
    
    {
        IDHintLB = [CPLabel new];
        IDHintLB.text = @"身 份 证:";

        [self.contentView addSubview:IDHintLB];
        [IDHintLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(licenseHintLB.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(cellSpaceOffset);
            make.height.mas_equalTo(1.5 * CELL_HEIGHT_F);
            make.width.mas_equalTo(60);
        }];
    }
    
    {
        IDFrontIV = [UIImageView new];
        IDFrontIV.image = CPImage(@"camera");

        [self.contentView addSubview:IDFrontIV];
        [IDFrontIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(IDHintLB.mas_top);
            make.left.mas_equalTo(IDHintLB.mas_right).offset(cellSpaceOffset);
            make.bottom.mas_equalTo(IDHintLB.mas_bottom);
            make.width.mas_equalTo(IDFrontIV.mas_height).multipliedBy(1.3);
        }];
    }
    
    {
        IDBackIV = [UIImageView new];
        IDBackIV.image = CPImage(@"camera");

        [self.contentView addSubview:IDBackIV];
        [IDBackIV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(IDHintLB.mas_top);
            make.left.mas_equalTo(IDFrontIV.mas_right).offset(cellSpaceOffset);
            make.bottom.mas_equalTo(IDHintLB.mas_bottom);
            make.width.mas_equalTo(IDBackIV.mas_height).multipliedBy(1.3);
        }];
    }
}

@end
