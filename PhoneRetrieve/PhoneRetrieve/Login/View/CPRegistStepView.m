//
//  CPRegistStepView.m
//  PhoneRetrieve
//
//  Created by wangzhangchuan on 2018/2/5.
//  Copyright © 2018年 Captain. All rights reserved.
//

#import "CPRegistStepView.h"

@implementation CPRegistStepView {
    CALayer *bottomLine;
}

- (id)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
    }
    
    return self;
}

- (void)setTitles:(NSArray<NSString *> *)titles {
    
    _titles = titles;
    
    [self setupUI];
}

- (void)setupUI {
    
    CGFloat width = SCREENWIDTH / self.titles.count;
    
    [self.titles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *titleLB = [[UILabel alloc] initWithFrame:CGRectMake(idx * width, 0, width, self.bounds.size.height)];
        titleLB.text = obj;
        titleLB.tag = 9527 + idx;
        titleLB.textAlignment = NSTextAlignmentCenter;
        titleLB.font = [UIFont systemFontOfSize:13.0f];
        
        [self addSubview:titleLB];
    }];
    
    bottomLine = [CALayer layer];
    bottomLine.backgroundColor = MainColor.CGColor;
    
    [self.layer insertSublayer:bottomLine atIndex:0];
    
    {
        UIView *sepLine = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height, SCREENWIDTH, 0.5f)];
        sepLine.backgroundColor = C99;
        
        [self addSubview:sepLine];
    }

}

- (void)setCurrentStep:(NSInteger)currentStep {
    
    _currentStep = currentStep;
    
    CGFloat width = SCREENWIDTH / self.titles.count;
    
    bottomLine.frame = CGRectMake((currentStep + 1) * width , self.bounds.size.height - 2, width, 2);
    
    UILabel *label = [self viewWithTag:9527 + currentStep + 1];
    label.textColor = UIColor.redColor;
}

@end
