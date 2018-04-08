//
//  CPButton.h
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/2.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CPButtonType) {
    CPButtonTypeCommon,             //  普通
    CPButtonTypeDestructive,        //  破环性操作
    CPButtonTypeOther,              //  其他
};


@interface CPButton : UIButton

@property (nonatomic, assign) CPButtonType type;

@end
