//
//  HomeSectionView.m
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/25.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import "HomeSectionView.h"

#import "HomeListModel.h"

@interface HomeSectionView ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *rightImgView;
@property (nonatomic, strong) UILabel *rightLabel;

@end

@implementation HomeSectionView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews {
    self.backgroundColor = [UIColor backgroundColor];
    [self addBgView];
    [self addLineView];
    [self addTitleLabel];
    [self addRightImgView];
    [self addRightLabel];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionClick)];
    [self addGestureRecognizer:tap];
}

- (void)setModel:(HomeListModel *)model {
    _model = model;
    self.titleLabel.text = model.partTitle;
    self.rightLabel.text = model.targetDesc;
    if ([model.partStyle isEqualToString:@"SLIDE_PORTRAIT"]) {
        self.lineView.backgroundColor = [UIColor colorWithHexString:@"#FF984D"];
    } else {
        self.lineView.backgroundColor = [UIColor colorWithHexString:@"#58C2ED"];
    }
    
    if ([model.partStyle isEqualToString:@"IMAGE_TEXT"]) {
        self.bgView.backgroundColor = [UIColor backgroundColor];
    } else {
        self.bgView.backgroundColor = [UIColor whiteColor];
    }
    
    
}

- (void)sectionClick {
    if (self.sectionViewClick) {
        self.sectionViewClick();
    }
}

- (void)addBgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        [self addSubview:_bgView];
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(10);
            make.left.bottom.right.equalTo(self);
        }];
    }
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

- (void)addRightImgView {
    if (!_rightImgView) {
        _rightImgView = [[UIImageView alloc] init];
        _rightImgView.image = [UIImage imageNamed:@"right_row"];
        [self addSubview:_rightImgView];
        [_rightImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.lineView.mas_centerY);
            make.right.equalTo(self.mas_right).offset(AdaptW(-36));
            make.size.mas_equalTo(CGSizeMake(7, 11));
        }];
    }
}

- (void)addRightLabel {
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.text = @"更多";
        _rightLabel.textColor = [UIColor whiteColor:0.5];
        _rightLabel.font = [UIFont systemFontOfSize:20];
        [self addSubview:_rightLabel];
        [_rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.rightImgView.mas_left).offset(-4);
            make.centerY.equalTo(self.lineView.mas_centerY);
        }];
    }
}

@end
