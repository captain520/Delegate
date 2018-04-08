//
//  CPPayInfoCell.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/4/3.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPPayInfoCell.h"

@implementation CPPayInfoCell {
    
    CPLabel *bankHintLB, *carOwnerLB, *carNumLB, *bankNameLB, *bankBranchNameLB;
    
    CPLabel *apliPayHintLB, *aliNameLB, *aliAccountLB;
    
    CPLabel *wxPayHintLB, *wxNameLB, *wxAccountLB;
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
        bankHintLB = [CPLabel new];
        bankHintLB.text = @"银行卡";
        bankHintLB.font = [UIFont boldSystemFontOfSize:13.0f];
        
        [self.contentView addSubview:bankHintLB];
        [bankHintLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(30);
        }];
    }
    
    {
        UIView *sepLine = [UIView new];
        sepLine.backgroundColor = CPBoardColor;
        
        [self.contentView addSubview:sepLine];
        [sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(bankHintLB.mas_bottom);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(CPBoardWidth);
        }];
    }
    
    {
        carOwnerLB = [CPLabel new];
        carOwnerLB.text = @"收款人：张三";

        [self.contentView addSubview:carOwnerLB];
        [carOwnerLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(bankHintLB.mas_bottom).offset(cellSpaceOffset/2);
            make.left.mas_equalTo(cellSpaceOffset + cellSpaceOffset / 2);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(SMALL_CELL_HEIGHT_F);
        }];
    }
    
    {
        carNumLB = [CPLabel new];
        carNumLB.text = @"银行卡号：123120012309391293";
        
        [self.contentView addSubview:carNumLB];
        [carNumLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(carOwnerLB.mas_bottom);
            make.left.mas_equalTo(cellSpaceOffset + cellSpaceOffset / 2);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(SMALL_CELL_HEIGHT_F);
        }];
    }
    
    {
        bankNameLB = [CPLabel new];
        bankNameLB.text = @"开户银行：招商银行";
        
        [self.contentView addSubview:bankNameLB];
        [bankNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(carNumLB.mas_bottom);
            make.left.mas_equalTo(cellSpaceOffset + cellSpaceOffset / 2);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(SMALL_CELL_HEIGHT_F);
        }];
    }
    
    {
        bankBranchNameLB = [CPLabel new];
        bankBranchNameLB.text = @"开户银行分行：招商银行南山支行";
        
        [self.contentView addSubview:bankBranchNameLB];
        [bankBranchNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(bankNameLB.mas_bottom);
            make.left.mas_equalTo(cellSpaceOffset + cellSpaceOffset / 2);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(SMALL_CELL_HEIGHT_F);
        }];
    }
    
    {
        UIView *sepLine = [UIView new];
        sepLine.backgroundColor = CPBoardColor;
        
        [self.contentView addSubview:sepLine];
        [sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(bankBranchNameLB.mas_bottom).offset(cellSpaceOffset/2);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(CPBoardWidth);
        }];
    }
    
    {
        apliPayHintLB = [CPLabel new];
        apliPayHintLB.text = @"支付宝";
        apliPayHintLB.font = [UIFont boldSystemFontOfSize:13.0f];
        
        [self.contentView addSubview:apliPayHintLB];
        [apliPayHintLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(bankBranchNameLB.mas_bottom).offset(cellSpaceOffset/2);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(30);
        }];
    }
    
    {
        UIView *sepLine = [UIView new];
        sepLine.backgroundColor = CPBoardColor;
        
        [self.contentView addSubview:sepLine];
        [sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(apliPayHintLB.mas_bottom);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(CPBoardWidth);
        }];
    }
    
    {
        aliNameLB = [CPLabel new];
        aliNameLB.text = @"账号名：张三";
        
        [self.contentView addSubview:aliNameLB];
        [aliNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(apliPayHintLB.mas_bottom).offset(cellSpaceOffset/2);
            make.left.mas_equalTo(cellSpaceOffset + cellSpaceOffset / 2);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(SMALL_CELL_HEIGHT_F);
        }];
    }
    
    {
        aliAccountLB = [CPLabel new];
        aliAccountLB.text = @"支付宝账号：15814099327";
        
        [self.contentView addSubview:aliAccountLB];
        [aliAccountLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(aliNameLB.mas_bottom);
            make.left.mas_equalTo(cellSpaceOffset + cellSpaceOffset / 2);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(SMALL_CELL_HEIGHT_F);
        }];
    }
    
    {
        UIView *sepLine = [UIView new];
        sepLine.backgroundColor = CPBoardColor;
        
        [self.contentView addSubview:sepLine];
        [sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(aliAccountLB.mas_bottom).offset(cellSpaceOffset/2);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(CPBoardWidth);
        }];
    }
    
    {
        wxPayHintLB = [CPLabel new];
        wxPayHintLB.text = @"微信";
        wxPayHintLB.font = [UIFont boldSystemFontOfSize:13.0f];
        
        [self.contentView addSubview:wxPayHintLB];
        [wxPayHintLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(aliAccountLB.mas_bottom).offset(cellSpaceOffset/2);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(30);
        }];
    }
    
    {
        UIView *sepLine = [UIView new];
        sepLine.backgroundColor = CPBoardColor;
        
        [self.contentView addSubview:sepLine];
        [sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(wxPayHintLB.mas_bottom);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(CPBoardWidth);
        }];
    }
    
    {
        wxNameLB = [CPLabel new];
        wxNameLB.text = @"账号名：张三";
        
        [self.contentView addSubview:wxNameLB];
        [wxNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(wxPayHintLB.mas_bottom).offset(cellSpaceOffset/2);
            make.left.mas_equalTo(cellSpaceOffset + cellSpaceOffset / 2);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(SMALL_CELL_HEIGHT_F);
        }];
    }
    
    {
        wxAccountLB = [CPLabel new];
        wxAccountLB.text = @"微信账号：15814099327";
        
        [self.contentView addSubview:wxAccountLB];
        [wxAccountLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(wxNameLB.mas_bottom);
            make.left.mas_equalTo(cellSpaceOffset + cellSpaceOffset / 2);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(SMALL_CELL_HEIGHT_F);
        }];
    }
    
    {
        UIView *sepLine = [UIView new];
        sepLine.backgroundColor = CPBoardColor;
        
        [self.contentView addSubview:sepLine];
        [sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(wxAccountLB.mas_bottom).offset(cellSpaceOffset/2);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(CPBoardWidth);
        }];
    }

}

@end
