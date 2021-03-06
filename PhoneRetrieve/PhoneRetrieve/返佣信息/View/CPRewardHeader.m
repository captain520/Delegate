//
//  CPRewardHeader.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/4/3.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPRewardHeader.h"

@implementation CPRewardHeader {
    CPLabel *dateLB, *rewardAmountLB, *deviceNumLB, *dealAmountLB;
}

- (void)setupUI {
   
    {
        dateLB               = [CPLabel new];
        dateLB.text          = @"2018-12-13";
        dateLB.font          = CPBoldFont_M;
        dateLB.lineBreakMode = NSLineBreakByClipping;

        [self.contentView addSubview:dateLB];
        [dateLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(cellSpaceOffset);
            make.bottom.mas_equalTo(0);
            make.width.mas_equalTo(80);
        }];
    }
    

    {
        rewardAmountLB               = [CPLabel new];
        rewardAmountLB.font          = CPBoldFont_M;
        rewardAmountLB.text          = @"返佣金额：¥2010.21";
        rewardAmountLB.textColor     = CPERROR_COLOR;
        rewardAmountLB.textAlignment = NSTextAlignmentRight;
        
        [self.contentView addSubview:rewardAmountLB];
        [rewardAmountLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(dateLB.mas_top);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(dateLB.mas_height);
        }];
    }
    
    {
        dealAmountLB               = [CPLabel new];
        dealAmountLB.font          = CPBoldFont_M;
        dealAmountLB.text          = @"交易金额：¥1234.02";
        dealAmountLB.textColor     = UIColor.redColor;
        dealAmountLB.textAlignment = NSTextAlignmentCenter;
//        dealAmountLB.backgroundColor = UIColor.redColor;
        
        [self.contentView addSubview:dealAmountLB];
        [dealAmountLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(dateLB.mas_top);
            make.left.mas_equalTo(dateLB.mas_right).offset(cellSpaceOffset/2);
            make.height.mas_equalTo(dateLB.mas_height);
        }];
    }
    
    {
        UIView *sepLine = [UIView new];
        sepLine.backgroundColor = CPBoardColor;

        [self.contentView addSubview:sepLine];
        [sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(CPBoardWidth);
            make.bottom.mas_equalTo(0);
        }];
    }

//    {
//        UIView *sepLine = [UIView new];
//        sepLine.backgroundColor = CPBoardColor;
//
//        [self.contentView addSubview:sepLine];
//        [sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(0);
//            make.right.mas_equalTo(0);
//            make.height.mas_equalTo(CPBoardWidth);
//            make.bottom.mas_equalTo(self.contentView.mas_bottom);
//        }];
//    }
}

- (void)setModel:(CPRewardDataModel *)model {
    _model = model;
    
    dateLB.text = _model.createtime;
    dealAmountLB.text = [NSString stringWithFormat:@"交易金额：¥%.2f",_model.total_price];
    rewardAmountLB.text = [NSString stringWithFormat:@"返佣金额：¥%.2f",_model.distribution_price];
}

- (void)setDataModel:(CPRetrieveOrderDataModel *)dataModel {
    
    _dataModel = dataModel;
    
    dateLB.text = _dataModel.createtime;
    dealAmountLB.text = [NSString stringWithFormat:@"机器数量：%ld",_dataModel.number];
    rewardAmountLB.text = [NSString stringWithFormat:@"金额：¥%.2f",_dataModel.total_price];
}

@end
