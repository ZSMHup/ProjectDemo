//
//  HomeH5Cell.m
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/26.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import "HomeH5Cell.h"

#import "DailyListModel.h"



@interface HomeH5Cell ()

@property (nonatomic, strong) UILabel *subjectLabel;
@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation HomeH5Cell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubViews];
    }
    return self;
}

- (void)setModel:(DailyListModel *)model {
    _model = model;
    self.subjectLabel.text = !model.dailyTitle ? @"" : model.dailyTitle;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.dailyImg]];
}

- (void)addSubViews {
    [self addSubjectLabel];
    [self addImgView];
}

- (void)addSubjectLabel {
    if (!_subjectLabel) {
        _subjectLabel = [[UILabel alloc] init];
        _subjectLabel.textColor = [UIColor blackColor];
        _subjectLabel.numberOfLines = 2;
        _subjectLabel.font = [UIFont systemFontOfSize:14];
        [self addSubview:_subjectLabel];
        [_subjectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(AdaptW(36));
            make.right.equalTo(self.contentView.mas_right).offset(AdaptW(-36));
            make.top.equalTo(self.contentView.mas_top);
        }];
    }
}

- (void)addImgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        [self addSubview:_imgView];
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.subjectLabel.mas_left);
            make.right.equalTo(self.subjectLabel.mas_right);
            make.top.equalTo(self.subjectLabel.mas_bottom).offset(AdaptH(12));
            make.bottom.equalTo(self.contentView.mas_bottom).offset(AdaptH(-20.5));
        }];
    }
}

@end
