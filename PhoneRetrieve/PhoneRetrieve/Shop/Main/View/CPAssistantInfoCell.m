//
//  CPAssistantInfoCell.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/8.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPAssistantInfoCell.h"

@implementation CPAssistantInfoCell {
    UILabel *shopNoLB, *shopNameLB, *nameLB, *phoneLB, *performanceLB, *createTimeLB;
    
    UIButton *detailBT, *editBT, *deleteBT;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    if (nil == shopNoLB) {
        shopNoLB = [UILabel new];
        shopNoLB.font = CPFont_M;
        shopNoLB.text = @"门店编号：007";
        
        [self.contentView addSubview:shopNoLB];
        
        [shopNoLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F / 2);
        }];
    }
    
    if (nil == shopNameLB) {
        shopNameLB = [UILabel new];
        shopNameLB.font = CPFont_M;
        shopNameLB.text = @"门店名称：夜夜";
        
        [self.contentView addSubview:shopNameLB];
        
        [shopNameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(shopNoLB.mas_bottom);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F / 2);
        }];
    }
    
    if (nil == nameLB) {
        nameLB = [UILabel new];
        nameLB.font = CPFont_M;
        nameLB.text = @"联系人：Captain";

        [self.contentView addSubview:nameLB];
        
        [nameLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(shopNameLB.mas_bottom);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F / 2);
        }];
    }

    if (nil == phoneLB) {
        phoneLB      = [UILabel new];
        phoneLB.font = CPFont_M;
        phoneLB.text = @"联系电话：15814099327";
        
        [self.contentView addSubview:phoneLB];

        [phoneLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(nameLB.mas_bottom);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F / 2);
        }];
    }

    if (nil == createTimeLB) {
        createTimeLB = [UILabel new];
        createTimeLB.font = CPFont_M;
        createTimeLB.text = @"创建时间：2018-03-04 19:03:21";

        [self.contentView addSubview:createTimeLB];

        [createTimeLB mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(phoneLB.mas_bottom);
            make.left.mas_equalTo(cellSpaceOffset);
            make.right.mas_equalTo(-cellSpaceOffset);
            make.height.mas_equalTo(CELL_HEIGHT_F / 2);
        }];
    }
    
    UIView *sepline = [UIView new];
    sepline.backgroundColor = CPBoardColor;
    
    [self.contentView addSubview:sepline];
    
    [sepline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(createTimeLB.mas_bottom).offset(CPTOP_BOTTOM_OFFSET_F);
        make.left.mas_equalTo(cellSpaceOffset);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(0.25f);
    }];
    
    if (nil == detailBT) {
        
        detailBT = [CPButton new];
        detailBT.tag             = CPAssistantInfoCellActionTypeDetail;
        detailBT.hidden          = YES;
        detailBT.titleLabel.font = CPFont_M;
        
        [self.contentView addSubview:detailBT];
        
        [detailBT setTitle:@"查看订单" forState:UIControlStateNormal];
        [detailBT setBackgroundImage:nil forState:UIControlStateNormal];
        [detailBT setTitleColor:C33 forState:0];
        [detailBT addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [detailBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(sepline.mas_bottom).offset(cellSpaceOffset / 2);
            make.left.mas_equalTo(cellSpaceOffset);
//            make.bottom.mas_equalTo(0).offset(-cellSpaceOffset / 2);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(30.0f);
        }];
    }
    
    if (nil == deleteBT) {
        deleteBT = [CPButton new];
        deleteBT.titleLabel.font = CPFont_M;
        deleteBT.tag = CPAssistantInfoCellActionTypeDelete;
        [deleteBT setTitle:@"删除" forState:UIControlStateNormal];
        [deleteBT setBackgroundImage:nil forState:UIControlStateNormal];
        [deleteBT setTitleColor:C33 forState:0];
        [deleteBT addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:deleteBT];
        
        [deleteBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(detailBT.mas_top);
            make.right.mas_equalTo(-cellSpaceOffset);
//            make.bottom.mas_equalTo(detailBT.mas_bottom);
            make.width.mas_equalTo(50);
            make.height.mas_equalTo(detailBT.mas_height);
        }];
    }
    
    if (nil == editBT) {
        editBT = [CPButton new];
        editBT.titleLabel.font = CPFont_M;
        editBT.tag = CPAssistantInfoCellActionTypeEdit;
        [editBT setTitle:@"编辑" forState:UIControlStateNormal];
        [editBT setBackgroundImage:nil forState:UIControlStateNormal];
        [editBT setTitleColor:C33 forState:0];
        [editBT addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:editBT];
        
        [editBT mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(detailBT.mas_top);
            make.right.mas_equalTo(deleteBT.mas_left).offset(-cellSpaceOffset);
            make.bottom.mas_equalTo(detailBT.mas_bottom);
            make.width.mas_equalTo(50);
        }];
    }
}

- (void)buttonAction:(UIButton *)sender {
    !self.actionBlock ? : self.actionBlock(sender.tag);
}

- (void)setModel:(CPMemberManagerDataModel *)model {
    _model = model;
    
    shopNoLB.text     = cp_jointString(IS_SHOP ? @"门店编号：" : @"商家编号：",_model.Code);
    shopNameLB.text   = cp_jointString(IS_SHOP ? @"门店名称：" : @"商家名称：",_model.companyname);
    nameLB.text       = cp_jointString(@"联系人：" ,_model.linkname);
    phoneLB.text      = cp_jointString(@"联系电话：", _model.phone);
    createTimeLB.text = cp_jointString(@"创建时间：", _model.createtime);
    
    
//    numberLB.text = [NSString stringWithFormat:@"店员编号:%@",_model.Code];
//    nameLB.text = [NSString stringWithFormat:@"姓名:%@",_model.linkname];
//    phoneLB.text = [NSString stringWithFormat:@"联系电话:%@",_model.phone];
//    phoneLB.text = [NSString stringWithFormat:@"回收量:%@",_mdoel.count];

}

@end
