//
//  CPSearchBar.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/4/21.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPSearchBar.h"

@implementation CPSearchBar {
    UITextField *tf;
}

- (void)setupUI {
    
    tf = [UITextField new];
    tf.borderStyle = UITextBorderStyleRoundedRect;
    tf.leftViewMode = UITextFieldViewModeAlways;
    
    [self addSubview:tf];
    [tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(cellSpaceOffset);
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(-cellSpaceOffset);
        make.bottom.mas_equalTo(0);
    }];
    
    UIImageView *iv = [UIImageView new];
    iv.image = CPImage(@"search");
    tf.leftView = iv;
    

}

@end
