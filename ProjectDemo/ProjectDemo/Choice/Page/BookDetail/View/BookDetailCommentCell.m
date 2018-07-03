//
//  BookDetailCommentCell.m
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/28.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import "BookDetailCommentCell.h"

#import "BookDetailEvaluateModel.h"

#import "AudioPlayerManager.h"

@interface BookDetailCommentCell ()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) TQStarRatingView *starRatingView;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIButton *audioBtn;

@end

@implementation BookDetailCommentCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubViews];
    }
    return self;
}

- (void)setModel:(BookDetailEvaluateModel *)model {
    _model = model;
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.userAvatar] placeholderImage:[UIImage imageNamed:@"user_icon"]];
    self.nameLabel.text = model.userNick;
    [self.starRatingView setScore:model.commentScoreFormatter withAnimation:YES];
    self.dateLabel.text = model.commentTimeFormatter;
    
    if ([model.commentType isEqualToString:@"COMMENT_VOICE"]) { // 语音

        self.detailLabel.hidden = YES;
        self.audioBtn.hidden = NO;
        [self.audioBtn setTitle:NSStringFormat(@"%@s", model.commentDuration) forState:(UIControlStateNormal)];
        [self.dateLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-50);
        }];
        
    } else {
        self.detailLabel.hidden = NO;
        self.audioBtn.hidden = YES;
        self.detailLabel.text = model.commentContent;
    }
    
}

- (void)audioBtnClick:(UIButton *)sender {
    
    if (_model.isStopAudio) {
        sender.selected = YES;
        [sender.imageView startAnimating];
    } else {
        sender.selected = NO;
        [sender.imageView stopAnimating];
    }
    
    if (self.playerCallBack) {
        self.playerCallBack(sender);
    }
}

- (void)addSubViews {
    
    [self addImgView];
    [self addNameLabel];
    [self addStarRatingView];
    [self addDateLabel];
    [self addDetailLabel];
    [self addAudioBtn];
}

- (void)addImgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.layer.cornerRadius = 17;
        _imgView.layer.masksToBounds = YES;
        [self.contentView addSubview:_imgView];
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(AdaptW(36));
            make.top.equalTo(self.contentView.mas_top).offset(AdaptW(16));
            make.size.mas_equalTo(CGSizeMake(35, 35));
        }];
    }
}

- (void)addNameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(AdaptW(16));
            make.left.equalTo(self.imgView.mas_right).offset(AdaptW(10));
            make.height.mas_equalTo(AdaptH(15));
        }];
    }
}

- (void)addStarRatingView {
    if (!_starRatingView) {
        _starRatingView = [[TQStarRatingView alloc] initWithFrame:CGRectMake(160, 19, 65, 13) numberOfStar:kNUMBER_OF_STAR];
        _starRatingView.isScroll = YES;
        [self.contentView addSubview:_starRatingView];
        [_starRatingView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.nameLabel.mas_centerY);
            make.left.equalTo(self.nameLabel.mas_right).offset(AdaptW(5));
            make.size.mas_equalTo(CGSizeMake(65, 13));
        }];
    }
}

- (void)addDateLabel {
    if (!_dateLabel) {
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.textColor = [UIColor blackColor:0.38];
        _dateLabel.font = [UIFont systemFontOfSize:12.0];
        [self.contentView addSubview:_dateLabel];
        [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLabel.mas_bottom).offset(AdaptH(5));
            make.left.equalTo(self.nameLabel.mas_left);
            make.right.equalTo(self.contentView.mas_right).offset(AdaptW(-36));
        }];
    }
}

- (void)addDetailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.textColor = [UIColor blackColor];
        _detailLabel.font = [UIFont systemFontOfSize:14.0];
        _detailLabel.numberOfLines = 0;
        [self.contentView addSubview:_detailLabel];
        [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.dateLabel.mas_bottom).offset(AdaptH(6));
            make.left.equalTo(self.nameLabel.mas_left);
            make.right.equalTo(self.contentView.mas_right).offset(AdaptW(-36));
            make.bottom.equalTo(self.contentView.mas_bottom).offset(AdaptW(-10));
        }];
    }
}

- (void)addAudioBtn {
    if (!_audioBtn) {
        _audioBtn = [[UIButton alloc] init];
        [_audioBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [_audioBtn setBackgroundImage:[UIImage imageNamed:@"voice_bg_icon"] forState:(UIControlStateNormal)];
        [_audioBtn setImage:[UIImage imageNamed:@"play_voice_icon_2"] forState:(UIControlStateNormal)];
        _audioBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 60);
        _audioBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -30, 0, 10);
        _audioBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [_audioBtn addTarget:self action:@selector(audioBtnClick:) forControlEvents:(UIControlEventTouchUpInside)];
        _audioBtn.imageView.animationImages = @[[UIImage imageNamed:@"play_voice_icon_0"],
                                                [UIImage imageNamed:@"play_voice_icon_1"],
                                                [UIImage imageNamed:@"play_voice_icon_2"]];
        _audioBtn.imageView.animationDuration = 1;
        _audioBtn.imageView.animationRepeatCount = 0;
        [self.contentView addSubview:_audioBtn];
        [_audioBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.nameLabel.mas_left);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(AdaptW(-10));
            make.size.mas_equalTo(CGSizeMake(112.5, 30));
        }];
    }
}


@end
