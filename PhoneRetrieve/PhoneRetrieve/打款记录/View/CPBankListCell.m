//
//  CPBankListCell.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/4/11.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPBankListCell.h"

@implementation CPBankListCell {
    CPLabel *orderSnLB, *amountLB, *dateLB;
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
        orderSnLB =  [CPLabel new];
        
        [self.contentView addSubview:orderSnLB];
        [orderSnLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(CPTOP_BOTTOM_OFFSET_F);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(SMALL_CELL_HEIGHT_F);
        }];
    }
    
    {
        
        amountLB =  [CPLabel new];
        
        [self.contentView addSubview:amountLB];
        [amountLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(orderSnLB.mas_bottom);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(SMALL_CELL_HEIGHT_F);
        }];
    }
    
    {
        dateLB =  [CPLabel new];
        
        [self.contentView addSubview:dateLB];
        [dateLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(amountLB.mas_bottom);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(SMALL_CELL_HEIGHT_F);
        }];
    }
    
}


- (void)setModel:(CPBankListDataModel *)model {
   
    _model = model;
    
    orderSnLB.text = [NSString stringWithFormat:@"转款流水号：%@",model.ordersn];
    amountLB.text = [NSString stringWithFormat:@"准款金额：%@",model.balance];
    dateLB.text = [NSString stringWithFormat:@"打款日期：%@",model.createtime];
}

@end
