//
//  CPDealDetailCell.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/4/4.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPDealDetailCell.h"

@implementation CPDealDetailCell {
    CPLabel *orderNoLB, *shopNameLB, *iitemCountLB,*rewardAmountLB, *deductAmountLB, *payStatesLB;
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
        payStatesLB = [CPLabel new];
        payStatesLB.text = @"待支付";
        payStatesLB.textColor = MainColor;
        
        [self.contentView addSubview:payStatesLB];
        [payStatesLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(CPTOP_BOTTOM_OFFSET_F);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(SMALL_CELL_HEIGHT_F);
        }];
    }
    
    {
        shopNameLB = [CPLabel new];
        shopNameLB.text = @"门店名称：望江店";
        
        [self.contentView addSubview:shopNameLB];
        [shopNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(cellSpaceOffset);
            make.top.mas_equalTo(orderNoLB.mas_bottom);
            make.height.mas_equalTo(SMALL_CELL_HEIGHT_F);
        }];
    }
    
    {
        iitemCountLB = [CPLabel new];
        iitemCountLB.text = @"共计3件商品，总计交易金额：¥0.12";
        
        [self.contentView addSubview:iitemCountLB];
        [iitemCountLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(shopNameLB.mas_bottom);
            make.left.mas_equalTo(cellSpaceOffset);
            make.height.mas_equalTo(SMALL_CELL_HEIGHT_F);
        }];
    }
    
    {
        rewardAmountLB = [CPLabel new];
        rewardAmountLB.text = @"返佣金额：¥20.12";
        rewardAmountLB.textColor = FONT_GREEN;
        
        [self.contentView addSubview:rewardAmountLB];
        [rewardAmountLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(iitemCountLB.mas_bottom);
            make.height.mas_equalTo(shopNameLB.mas_height);
            make.left.mas_equalTo(cellSpaceOffset);
        }];
    }
    
    {
        deductAmountLB = [CPLabel new];
        deductAmountLB.text = @"扣除金额：¥20.12";
        deductAmountLB.textColor = CPERROR_COLOR;
        
        [self.contentView addSubview:deductAmountLB];
        [deductAmountLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(rewardAmountLB.mas_top);
            make.height.mas_equalTo(shopNameLB.mas_height);
            make.right.mas_equalTo(-cellSpaceOffset);
        }];
    }
}

- (void)setModel:(CPDealOrderInfoModel *)model {
    _model = model;
    
    orderNoLB.text = [NSString stringWithFormat:@"交易订单：%@",_model.ordersn];
    payStatesLB.text = _model.paycfg == 0 ? @"未支付" : @"已支付";
    payStatesLB.textColor = _model.paycfg == 0 ? CPERROR_COLOR : MainColor;
    if (IS_SHOP) {
        shopNameLB.text = [NSString stringWithFormat:@"门店名称：%@",_model.shopname];
    } else {
        shopNameLB.text = [NSString stringWithFormat:@"商家名称：%@",_model.agentname];
    }
    iitemCountLB.text = [NSString stringWithFormat:@"共%ld件商品，共计¥%.2f",(long)_model.number,_model.total_price];
    rewardAmountLB.text = [NSString stringWithFormat:@"返佣金额：¥%.2f",_model.distribution_price];
    deductAmountLB.text = [NSString stringWithFormat:@"扣除金额：¥%.2f",_model.kou_price];
}


@end
