//
//  CPRetrieveDetailCell.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/4/4.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPRetrieveDetailCell.h"

@implementation CPRetrieveDetailCell {
    CPLabel *deviceNameLB, *priceuLB, *shopNameLB, *resultLB,*orderNoLB, *statesLB;
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
        orderNoLB.text = @"评估单号：1235239042394233";
        
        [self.contentView addSubview:orderNoLB];
        [orderNoLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(CPTOP_BOTTOM_OFFSET_F);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(SMALL_CELL_HEIGHT_F);
        }];
    }
    
    {
        statesLB = [CPLabel new];
        statesLB.text = @"已回收";
        
        [self.contentView addSubview:statesLB];
        [statesLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(CPTOP_BOTTOM_OFFSET_F);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(SMALL_CELL_HEIGHT_F);
        }];
    }
    
    
    {
        deviceNameLB = [CPLabel new];
        deviceNameLB.text = @"苹果 6s Plus (手机)";
        
        [self.contentView addSubview:deviceNameLB];
        [deviceNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(cellSpaceOffset);
            make.top.mas_equalTo(orderNoLB.mas_bottom);
            make.height.mas_equalTo(SMALL_CELL_HEIGHT_F);
        }];
    }
    
    {
        shopNameLB = [CPLabel new];
        shopNameLB.text = @"门店名称：望江店";
        
        [self.contentView addSubview:shopNameLB];
        [shopNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(deviceNameLB.mas_bottom);
            make.left.mas_equalTo(cellSpaceOffset);
            make.height.mas_equalTo(SMALL_CELL_HEIGHT_F);
        }];
    }
    
    {
        priceuLB = [CPLabel new];
        priceuLB.text = @"评估价：¥20.12";
        priceuLB.textColor = CPERROR_COLOR;
        
        [self.contentView addSubview:priceuLB];
        [priceuLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(deviceNameLB.mas_top);
            make.height.mas_equalTo(deviceNameLB.mas_height);
            make.right.mas_equalTo(-cellSpaceOffset);
        }];
    }

}


#pragma mark - setterr && getter

- (void)setModel:(CPRetrieveOrderInfoModel *)model {
    _model = model;
    
    orderNoLB.text    = [NSString stringWithFormat:@"评估单号：%@",_model.resultno];
    deviceNameLB.text = [NSString stringWithFormat:@"%@(%@)",_model.brandname,_model.Typename];
    priceuLB.text     = [NSString stringWithFormat:@"评估价格：¥：%.2f",_model.price];
    shopNameLB.text   = [NSString stringWithFormat:@"门店名称：%@",_model.doorname];
    
    if (self.type == CPRetrieveOrderListTypeSuccess) {
        statesLB.text = @"已回收";
        statesLB.textColor = MainColor;
    } else if (self.type == CPRetrieveOrderListTypeFail) {
        statesLB.text = @"已失效";
        statesLB.textColor = CPWARNING_COLOR;
    }
}

@end
