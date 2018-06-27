//
//  BookDetailPreviewCollectionCell.m
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/27.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import "BookDetailPreviewCollectionCell.h"

#import "BookDetailPreviewModel.h"

@interface BookDetailPreviewCollectionCell()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIImageView *videoImgView;

@end

@implementation BookDetailPreviewCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
    }
    return self;
}

- (void)setModel:(BookDetailPreviewModel *)model {
    _model = model;
    
    if ([model.resourceType isEqualToString:@"PREVIEW_VIDEO"]) { // 视频
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.coverUrl]];
        self.maskView.hidden = NO;
        self.videoImgView.hidden = NO;
    } else {
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.ossUrl]];
        self.maskView.hidden = YES;
        self.videoImgView.hidden = YES;
    }
    
}

- (void)addSubViews {
    self.backgroundColor = [UIColor whiteColor];
    [self addImgView];
    [self addMaskView];
    [self addVideoImgView];
}

- (void)addImgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
        _imgView.layer.masksToBounds = YES;
        [self.contentView addSubview:_imgView];
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(self.contentView);
        }];
    }
}

- (void)addMaskView {
    if (!_maskView) {
        _maskView = [[UIView alloc] init];
        _maskView.hidden = YES;
        _maskView.backgroundColor = [UIColor blackColor:0.5];
        [self.contentView addSubview:_maskView];
        [_maskView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(self.contentView);
        }];
    }
}

- (void)addVideoImgView {
    if (!_videoImgView) {
        _videoImgView = [[UIImageView alloc] init];
        _videoImgView.image = [UIImage imageNamed:@"video_play"];
        _videoImgView.hidden = YES;
        _videoImgView.userInteractionEnabled = YES;
        [self.contentView addSubview:_videoImgView];
        [_videoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.centerY.equalTo(self.contentView);
            make.size.mas_equalTo(CGSizeMake(44, 44));
        }];
    }
}


@end
