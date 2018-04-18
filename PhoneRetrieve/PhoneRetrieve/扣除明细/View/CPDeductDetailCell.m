//
//  CPDeductDetailCell.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/4/4.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPDeductDetailCell.h"

@implementation CPDeductDetailCell {
    CPLabel *orderNoLB, *deviceNameLB, *priceLB,*shopNameLB, *deductAmountLB;
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
        orderNoLB = [CPLabel new];
        orderNoLB.text = @"交易订单号：1235239042394233";
        
        [self.contentView addSubview:orderNoLB];
        [orderNoLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(CPTOP_BOTTOM_OFFSET_F);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(SMALL_CELL_HEIGHT_F);
        }];
    }

    {
        deviceNameLB = [CPLabel new];
        deviceNameLB.text = @"iPhone 6s Plus (手机)";
        
        [self.contentView addSubview:deviceNameLB];
        [deviceNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(cellSpaceOffset);
            make.top.mas_equalTo(orderNoLB.mas_bottom);
            make.height.mas_equalTo(SMALL_CELL_HEIGHT_F);
        }];
    }
    
    {
        priceLB = [CPLabel new];
        priceLB.textColor = FONT_GREEN;
        priceLB.text = @"评估价：¥500.12";
        
        [self.contentView addSubview:priceLB];
        [priceLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(deviceNameLB.mas_bottom);
            make.left.mas_equalTo(cellSpaceOffset);
            make.height.mas_equalTo(SMALL_CELL_HEIGHT_F);
        }];
    }
    
    {
        shopNameLB = [CPLabel new];
        shopNameLB.text = @"门店名称：望江路店";

        [self.contentView addSubview:shopNameLB];
        [shopNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(priceLB.mas_bottom);
            make.height.mas_equalTo(deviceNameLB.mas_height);
            make.left.mas_equalTo(cellSpaceOffset);
        }];
    }
    
    {
        deductAmountLB = [CPLabel new];
        deductAmountLB.text = @"扣除金额：¥20.12";
        deductAmountLB.textColor = CPERROR_COLOR;
        
        [self.contentView addSubview:deductAmountLB];
        [deductAmountLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(priceLB.mas_top);
            make.height.mas_equalTo(deviceNameLB.mas_height);
            make.left.mas_equalTo(priceLB.mas_right).offset(cellSpaceOffset);
//            make.right.mas_equalTo(-cellSpaceOffset);
        }];
    }
}

- (void)setModel:(CPDeductDetailInfoModel *)model {
    
    _model = model;
    
    orderNoLB.text      = [NSString stringWithFormat:@"交易订单：%@",_model.resultno];
    deviceNameLB.text   = [NSString stringWithFormat:@"%@(%@)",_model.goodsname,_model.Typename];
    priceLB.text        = [NSString stringWithFormat:@"评估价格：¥：%.2f",_model.price];
    deductAmountLB.text = [NSString stringWithFormat:@"扣除金额：¥%.2f",_model.kou_price];
    shopNameLB.text     = [NSString stringWithFormat:@"门店名称：%@",_model.shopname];
}


@end
