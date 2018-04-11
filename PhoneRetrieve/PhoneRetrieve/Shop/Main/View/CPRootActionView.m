//
//  CPRootActionView.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/4/2.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPRootActionView.h"

#define CPACTIOIN_HEIGHT_F      (80)

@implementation CPRootActionView {
    
    CPLabel *amountHintLB, *amountLB;
}

- (void)setupUI {
    {
        UIView *topLine = [CPView new];
        topLine.backgroundColor = CPBoardColor;
        
        [self addSubview:topLine];
        [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.height.mas_equalTo(CPBoardWidth);
            make.right.mas_equalTo(0);
        }];
        
        UIView *topMidLine = [CPView new];
        topMidLine.backgroundColor = CPBoardColor;
        
        [self addSubview:topMidLine];
        [topMidLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(topLine.mas_bottom).offset(cellSpaceOffset);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.height.mas_equalTo(CPACTIOIN_HEIGHT_F);
            make.width.mas_equalTo(CPBoardWidth);
        }];

        UIView *bottomLine = [CPView new];
        bottomLine.backgroundColor = CPBoardColor;
        
        [self addSubview:bottomLine];
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(topMidLine.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(0);
            make.height.mas_equalTo(CPBoardWidth);
            make.right.mas_equalTo(0);
        }];
        
        
//        amountHintLB = [CPLabel new];
//        amountHintLB.font          = CPFont_XL;
//        amountHintLB.text          = @"账户余额";
//        amountHintLB.textAlignment = NSTextAlignmentCenter;
//
//        [self addSubview:amountHintLB];
//        [amountHintLB mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(topLine.mas_bottom).offset(2 * cellSpaceOffset);
//            make.left.mas_equalTo(cellSpaceOffset);
//            make.right.mas_equalTo(topMidLine.mas_left).mas_equalTo(-cellSpaceOffset);;
//        }];
//
//
        CGFloat amount = [CPUserInfoModel shareInstance].loginModel.totalcommission;
//        amountLB = [CPLabel new];
//        amountLB.font          = CPFont_XL;
//        amountLB.text          =  [NSString stringWithFormat:@"¥%.2f",amount];
//        amountLB.textAlignment = NSTextAlignmentCenter;
//
//        [self addSubview:amountLB];
//        [amountLB mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(amountHintLB.mas_bottom).offset(cellSpaceOffset/3);
//            make.left.mas_equalTo(cellSpaceOffset);
//            make.right.mas_equalTo(topMidLine.mas_left).mas_equalTo(-cellSpaceOffset);;
//        }];

        
        NSString *title  = [NSString stringWithFormat:@"账户余额\n¥%.2f",amount];
        
        self.rewardBT = [UIButton new];
        self.rewardBT.titleLabel.numberOfLines = 0;
        self.rewardBT.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.rewardBT setTitleColor:C33 forState:0];
        [self.rewardBT setTitle:title forState:0];
        
        [self addSubview:self.rewardBT];
        [self.rewardBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(topLine.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(topMidLine.mas_left).offset(-cellSpaceOffset);
            make.bottom.mas_equalTo(bottomLine.mas_bottom).offset(-cellSpaceOffset);
//            make.left.mas_equalTo(cellSpaceOffset);
//            make.right.mas_equalTo(topMidLine.mas_right).offset(-cellSpaceOffset);
//            make.bottom.mas_equalTo(bottomLine.mas_top).offset(-cellSpaceOffset);
//            make.height.mas_equalTo(30.0f);
//            make.height.mas_equalTo(0);
        }];
        
        self.rewardRecordBT = [UIButton new];
        self.rewardRecordBT.titleLabel.font = CPFont_L;
        [self.rewardRecordBT setImage:CPImage(@"返佣查询") forState:0];
        [self.rewardRecordBT setTitle:@"返佣查询" forState:0];
        [self.rewardRecordBT setTitleColor:C33 forState:0];
        [self.rewardRecordBT setImageEdgeInsets:UIEdgeInsetsMake(0, -8, 0, 0)];

        [self addSubview:self.rewardRecordBT];
        [self.rewardRecordBT mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(topLine.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(topMidLine.mas_right).offset(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.bottom.mas_equalTo(bottomLine.mas_top).offset(-cellSpaceOffset);
        }];
    }
    
    {
        UIView *topLine = [CPView new];
        topLine.backgroundColor = CPBoardColor;
        
        [self addSubview:topLine];
        [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(CPACTIOIN_HEIGHT_F + cellSpaceOffset + 2 * cellSpaceOffset);
            make.left.mas_equalTo(0);
            make.height.mas_equalTo(CPBoardWidth);
            make.right.mas_equalTo(0);
        }];
        
        //  中间竖线
        UIView *topMidHLine = [CPView new];
        topMidHLine.backgroundColor = CPBoardColor;
        
        [self addSubview:topMidHLine];
        [topMidHLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(topLine.mas_bottom);
            make.centerX.mas_equalTo(self.mas_centerX);
            make.height.mas_equalTo(CPACTIOIN_HEIGHT_F * 2);
            make.width.mas_equalTo(CPBoardWidth);
        }];
        
        //  中间横线
        UIView *topMidVLine = [CPView new];
        topMidVLine.backgroundColor = CPBoardColor;
        
        [self addSubview:topMidVLine];
        [topMidVLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(topLine.mas_bottom).offset(CPACTIOIN_HEIGHT_F);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(CPBoardWidth);
        }];
        
        UIView *bottomLine = [CPView new];
        bottomLine.backgroundColor = CPBoardColor;
        
        [self addSubview:bottomLine];
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(topMidHLine.mas_bottom);
            make.left.mas_equalTo(0);
            make.height.mas_equalTo(CPBoardWidth);
            make.right.mas_equalTo(0);
        }];
        
        
        self.orderBT = [UIButton new];
        self.orderBT.titleLabel.font = CPFont_L;
        [self.orderBT setImage:CPImage(@"订单中心") forState:0];
        [self.orderBT setTitle:@"订单中心" forState:0];
        [self.orderBT setTitleColor:C33 forState:0];
        [self.orderBT setImageEdgeInsets:UIEdgeInsetsMake(0, -8, 0, 0)];
        
        [self addSubview:self.orderBT];
        [self.orderBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(topLine.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(topMidHLine.mas_left).offset(-cellSpaceOffset);
            make.bottom.mas_equalTo(topMidVLine.mas_bottom).offset(-cellSpaceOffset);
        }];
        
        self.shopManagerBT = [UIButton new];
        self.shopManagerBT.titleLabel.font = CPFont_L;
        [self.shopManagerBT setImage:CPImage(@"门店管理") forState:0];
//        if (IS_SHOP) {
//            [self.shopManagerBT setTitle:@"门店管理" forState:0];
//        } else if (IS_ASSISTANT) {
//            [self.shopManagerBT setTitle:@"商家管理" forState:0];
//        }

        [self.shopManagerBT setTitleColor:C33 forState:0];
        [self.shopManagerBT setImageEdgeInsets:UIEdgeInsetsMake(0, -8, 0, 0)];
        
        [self addSubview:self.shopManagerBT];
        [self.shopManagerBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(topLine.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(topMidHLine.mas_right).offset(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.bottom.mas_equalTo(topMidVLine.mas_bottom).offset(-cellSpaceOffset);
        }];
        
        self.logistisBT = [UIButton new];
        self.logistisBT.titleLabel.font = CPFont_L;
        [self.logistisBT setImage:CPImage(@"扣除明细") forState:0];
        [self.logistisBT setTitle:@"扣除明细" forState:0];
        [self.logistisBT setTitleColor:C33 forState:0];
        [self.logistisBT setImageEdgeInsets:UIEdgeInsetsMake(0, -8, 0, 0)];
        
        [self addSubview:self.logistisBT];
        [self.logistisBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(topMidVLine.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(topMidHLine.mas_left).offset(-cellSpaceOffset);
            make.bottom.mas_equalTo(bottomLine.mas_bottom).offset(-cellSpaceOffset);
        }];
        
        self.accountManagerBT = [UIButton new];
        self.accountManagerBT.titleLabel.font = CPFont_L;
        [self.accountManagerBT setImage:CPImage(@"账号管理") forState:0];
        [self.accountManagerBT setTitle:@"账号管理" forState:0];
        [self.accountManagerBT setTitleColor:C33 forState:0];
        [self.accountManagerBT setImageEdgeInsets:UIEdgeInsetsMake(0, -8, 0, 0)];

        [self addSubview:self.accountManagerBT];
        [self.accountManagerBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(topMidVLine.mas_bottom).offset(cellSpaceOffset);
            make.left.mas_equalTo(topMidHLine.mas_right).offset(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.bottom.mas_equalTo(bottomLine.mas_bottom).offset(-cellSpaceOffset);
        }];
    }
    
}

- (void)setIsShop:(BOOL)isShop {
    
    _isShop = isShop;
    
    if (_isShop == YES) {
        [self.shopManagerBT setTitle:@"门店管理" forState:0];
    } else {
        [self.shopManagerBT setTitle:@"商家管理" forState:0];
    }
}

@end
