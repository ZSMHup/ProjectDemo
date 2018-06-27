//
//  SectionView.m
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/27.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import "SectionView.h"

@interface SectionView ()

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation SectionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews {
    self.backgroundColor = [UIColor whiteColor];
    [self addLineView];
    [self addTitleLabel];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

- (void)addLineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"#58C2ED"];
        [self addSubview:_lineView];
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(AdaptW(36));
            make.bottom.equalTo(self.mas_bottom).offset(-12);
            make.size.mas_equalTo(CGSizeMake(6, 19.5));
        }];
    }
}

- (void)addTitleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"周一看什么";
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = [UIFont systemFontOfSize:20];
        [self addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lineView.mas_right).offset(6);
            make.centerY.equalTo(self.lineView.mas_centerY);
        }];
    }
}


@end
