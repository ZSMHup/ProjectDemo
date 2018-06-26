//
//  HomeHorizontalHasButtonCollectionCell.m
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/26.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import "HomeHorizontalHasButtonCollectionCell.h"

#import "BookListModel.h"
#import "EbBookModel.h"

@interface HomeHorizontalHasButtonCollectionCell ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subjectLabel;
@property (nonatomic, strong) UILabel *readLabel;

@end

@implementation HomeHorizontalHasButtonCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
    }
    return self;
}

- (void)setModel:(BookListModel *)model {
    _model = model;
    EbBookModel *bookModel = model.ebBookResource.firstObject;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:bookModel.ossUrl]];
    self.titleLabel.text = model.bookName;
    self.subjectLabel.text = model.bookIntroduction;
}

- (void)addSubViews {
    self.backgroundColor = [UIColor clearColor];
    [self addBgView];
    [self addImgView];
    [self addTitleLabel];
    [self addSubjectLabel];
    [self addReadLabel];
}

- (void)addBgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.layer.cornerRadius = 10.0;
        _bgView.layer.masksToBounds = YES;
        _bgView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_bgView];
        [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left);
            make.top.equalTo(self.contentView.mas_top);
            make.right.equalTo(self.contentView.mas_right);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(AdaptH(-12));
        }];
    }
}

- (void)addImgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        [self.bgView addSubview:_imgView];
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bgView.mas_left).offset(AdaptW(16));
            make.top.equalTo(self.bgView.mas_top).offset(AdaptW(18));
            make.bottom.equalTo(self.bgView.mas_bottom).offset(AdaptH(-16));
            make.width.mas_equalTo(AdaptW(92));
        }];
    }
}

- (void)addTitleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.numberOfLines = 2;
        _titleLabel.font = [UIFont systemFontOfSize:16];
        [self.bgView addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imgView.mas_right).offset(AdaptW(15));
            make.right.equalTo(self.bgView.mas_right).offset(AdaptW(-15));
            make.top.equalTo(self.imgView.mas_top);
        }];
    }
}

- (void)addSubjectLabel {
    if (!_subjectLabel) {
        _subjectLabel = [[UILabel alloc] init];
        _subjectLabel.textColor = [UIColor blackColor];
        _subjectLabel.numberOfLines = 0;
        _subjectLabel.font = [UIFont systemFontOfSize:12];
        [self.bgView addSubview:_subjectLabel];
        [_subjectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_left);
            make.right.equalTo(self.titleLabel.mas_right);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(AdaptH(10));
            make.bottom.equalTo(self.bgView.mas_bottom).offset(AdaptH(-66));
        }];
    }
}

- (void)addReadLabel {
    if (!_readLabel) {
        _readLabel = [[UILabel alloc] init];
        _readLabel.textColor = [UIColor mainColor];
        _readLabel.font = [UIFont systemFontOfSize:12];
        _readLabel.textAlignment = NSTextAlignmentCenter;
        _readLabel.layer.borderColor = [UIColor mainColor].CGColor;
        _readLabel.layer.borderWidth = 1;
        _readLabel.layer.cornerRadius = 15;
        _readLabel.layer.masksToBounds = YES;
        _readLabel.text = @"立即阅读";
        [self.bgView addSubview:_readLabel];
        [_readLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.bgView.mas_right).offset(AdaptW(-15));
            make.bottom.equalTo(self.bgView.mas_bottom).offset(AdaptH(-18));
            make.size.mas_equalTo(CGSizeMake(80, 30));
        }];
    }
}

@end
