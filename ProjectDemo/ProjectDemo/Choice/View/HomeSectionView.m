//
//  HomeSectionView.m
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/25.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import "HomeSectionView.h"

@interface HomeSectionView ()

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation HomeSectionView

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title lineColor:(UIColor *)lineColor {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
        self.titleLabel.text = title;
        self.lineView.backgroundColor = lineColor;
    }
    return self;
}

- (void)addSubViews {
    [self addLineView];
    [self addTitleLabel];
}

- (void)addLineView {
    if (_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor mainColor];
        [self addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(26);
            make.bottom.equalTo(self.mas_bottom).offset(3);
            make.size.mas_equalTo(CGSizeMake(5, 15));
        }];
    }
}

- (void)addTitleLabel {
    if (_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"周一看什么";
        _titleLabel.font = [UIFont systemFontOfSize:20];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lineView.mas_right).offset(5);
            make.centerY.equalTo(self.lineView.mas_centerY);
        }];
    }
}

@end
