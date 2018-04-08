//
//  CPRewardDetailCell.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/4/3.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPRewardDetailCell.h"

@implementation CPRewardDetailCell {
    CPLabel *shopNameLB, *rewardAmountLB, *dealAmountLB, *resultLB, *deviceNameLB, *orderNoLB;
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
        dealAmountLB = [CPLabel new];
        dealAmountLB.text = @"交易金额：¥0.12";

        [self.contentView addSubview:dealAmountLB];
        [dealAmountLB mas_makeConstraints:^(MASConstraintMaker *make) {
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
            make.top.mas_equalTo(dealAmountLB.mas_top);
            make.height.mas_equalTo(shopNameLB.mas_height);
            make.right.mas_equalTo(-cellSpaceOffset);
        }];
    }
    return;
    
    
    

    
    {
        resultLB = [CPLabel new];
        resultLB.text = @"实际返佣：¥20.12";
        resultLB.textColor = CPERROR_COLOR;
        
        [self.contentView addSubview:rewardAmountLB];
        [rewardAmountLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(shopNameLB.mas_top);
            make.left.mas_equalTo(dealAmountLB.mas_right).offset(cellSpaceOffset);
            make.height.mas_equalTo(shopNameLB.mas_height);
            make.width.mas_equalTo(shopNameLB.mas_width);
        }];
    }
    
    {
        deviceNameLB = [CPLabel new];
        deviceNameLB.text = @"iPhone 5s Plus (手机)";
        
        [self.contentView addSubview:deviceNameLB];
        [deviceNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(shopNameLB.mas_bottom);
            make.left.mas_equalTo(shopNameLB.mas_left);
            make.height.mas_equalTo(SMALL_CELL_HEIGHT_F);
        }];
    }
    

}

@end
