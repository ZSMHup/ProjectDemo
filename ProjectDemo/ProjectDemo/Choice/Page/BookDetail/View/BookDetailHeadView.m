//
//  BookDetailHeadView.m
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/27.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import "BookDetailHeadView.h"

#import "EbBookModel.h"
#import "BookAuthorModel.h"
#import "BookPriceModel.h"

@interface BookDetailHeadView ()

@property (nonatomic, strong) UIImageView *bgImgView;
// top
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UILabel *bookNameLabel;

// bottom
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) TQStarRatingView *starRatingView;
@property (nonatomic, strong) UILabel *ratingLabel;
@property (nonatomic, strong) UILabel *ratingCountLabel;
@property (nonatomic, strong) UILabel *seriesLabel;
@property (nonatomic, strong) UILabel *PriceLabel;
@property (nonatomic, strong) UILabel *isVipLabel;

@property (nonatomic, strong) UIImageView *imgView;


@end

@implementation BookDetailHeadView

- (instancetype)initWithFrame:(CGRect)frame bookDetailModel:(BookDetailModel *)bookDetailModel {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubViews];
        self.bookDetailModel = bookDetailModel;
    }
    return self;
}

- (void)addSubViews {
    [self addBgImgView];
    [self addTopSubViews];
    [self addBottomSubViews];
    [self addImgView];
    
}

- (void)setBookDetailModel:(BookDetailModel *)bookDetailModel {
    _bookDetailModel = bookDetailModel;
    EbBookModel *bookModel = bookDetailModel.ebBookResource.firstObject;
    BookAuthorModel *authorModel = bookDetailModel.bookAuthor.firstObject;
    BookPriceModel *priceModel = bookDetailModel.bookPrice.firstObject;
    
    [self.bgImgView sd_setImageWithURL:[NSURL URLWithString:bookModel.ossUrl]];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:bookModel.ossUrl]];
    self.bookNameLabel.text = bookDetailModel.bookName;
    [self.starRatingView setScore:bookDetailModel.bookScoreFormatter withAnimation:YES];
    self.ratingLabel.text = NSStringFormat(@"%.1f", [bookDetailModel.bookScore floatValue]);
    self.ratingCountLabel.text = NSStringFormat(@"| %@人评分", bookDetailModel.scoreNum);
    self.seriesLabel.text = NSStringFormat(@"%@  |  %@", bookDetailModel.bookPressName, authorModel.authorName);
    self.PriceLabel.text = NSStringFormat(@"纸质书价格：￥%@", priceModel.goodsMarketprice);
    self.isVipLabel.text = NSStringFormat(@"孩子通会员：免费借阅");
}

#pragma mark --- 处理毛玻璃显示
- (void)handlerEffectView {
    NSArray *effectTypeArray = @[@(UIBlurEffectStyleLight), @(UIBlurEffectStyleDark)];
    for (NSInteger i = 0; i < effectTypeArray.count; i++) {
        UIBlurEffect * effect = [UIBlurEffect effectWithStyle:[effectTypeArray[i] integerValue]];
        UIVisualEffectView * effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        effectView.frame = self.bgImgView.bounds;
        [self.bgImgView addSubview:effectView];
    }
}

- (void)addBgImgView {
    if (!_bgImgView) {
        _bgImgView = [[UIImageView alloc] initWithFrame:self.frame];
        [self addSubview:_bgImgView];
        [self handlerEffectView];
    }
}

// top
- (void)addTopSubViews {
    [self addTopView];
    [self addBookNameLabel];
}

- (void)addTopView {
    if (!_topView) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = [UIColor clearColor];
        [self addSubview:_topView];
        [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.height.mas_equalTo(AdaptH(187));
        }];
    }
}

- (void)addBookNameLabel {
    if (!_bookNameLabel) {
        _bookNameLabel = [[UILabel alloc] init];
        _bookNameLabel.textColor = [UIColor whiteColor];
        _bookNameLabel.font = [UIFont systemFontOfSize:20.0];
        [self.topView addSubview:_bookNameLabel];
        [_bookNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.topView.mas_left).offset(AdaptW(208));
            make.top.equalTo(self.topView.mas_top).offset(AdaptH(80));
        }];
    }
}


// bottom
- (void)addBottomSubViews {
    [self addBottomView];
    [self addStarRatingView];
    [self addRatingLabel];
    [self addRatingCountLabel];
    [self addSeriesLabel];
    [self addPriceLabel];
    [self addIsVipLabel];
    
}


- (void)addBottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_bottomView];
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.top.equalTo(self.topView.mas_bottom);
        }];
    }
}

- (void)addStarRatingView {
    if (!_starRatingView) {
        _starRatingView = [[TQStarRatingView alloc] initWithFrame:CGRectMake(AdaptW(208), AdaptH(12), 100, 20) numberOfStar:kNUMBER_OF_STAR];
        _starRatingView.isScroll = YES;
        [self.bottomView addSubview:_starRatingView];
    }
}

- (void)addRatingLabel {
    if (!_ratingLabel) {
        _ratingLabel = [[UILabel alloc] init];
        _ratingLabel.textColor = [UIColor colorWithHexString:@"#F59523"];
        _ratingLabel.font = [UIFont systemFontOfSize:24.0];
        [self.bottomView addSubview:_ratingLabel];
        [_ratingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.starRatingView.mas_right).offset(AdaptW(15));
            make.centerY.equalTo(self.starRatingView.mas_centerY);
        }];
    }
}

- (void)addRatingCountLabel {
    if (!_ratingCountLabel) {
        _ratingCountLabel = [[UILabel alloc] init];
        _ratingCountLabel.textColor = [UIColor blackColor:0.38];
        _ratingCountLabel.font = [UIFont systemFontOfSize:18.0];
        [self.bottomView addSubview:_ratingCountLabel];
        [_ratingCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.ratingLabel.mas_right).offset(AdaptW(10));
            make.centerY.equalTo(self.starRatingView.mas_centerY);
        }];
    }
}

- (void)addSeriesLabel {
    if (!_seriesLabel) {
        _seriesLabel = [[UILabel alloc] init];
        _seriesLabel.textColor = [UIColor mainColor];
        _seriesLabel.font = [UIFont systemFontOfSize:13.0];
        [self.bottomView addSubview:_seriesLabel];
        [_seriesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.starRatingView.mas_left);
            make.top.equalTo(self.starRatingView.mas_bottom).offset(AdaptH(18));
        }];
    }
}

- (void)addPriceLabel {
    if (!_PriceLabel) {
        _PriceLabel = [[UILabel alloc] init];
        _PriceLabel.textColor = [UIColor blackColor:0.54];
        _PriceLabel.font = [UIFont systemFontOfSize:13.0];
        [self.bottomView addSubview:_PriceLabel];
        [_PriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.starRatingView.mas_left);
            make.top.equalTo(self.seriesLabel.mas_bottom).offset(AdaptH(10));
        }];
    }
}

- (void)addIsVipLabel {
    if (!_isVipLabel) {
        _isVipLabel = [[UILabel alloc] init];
        _isVipLabel.textColor = [UIColor blackColor:0.54];
        _isVipLabel.font = [UIFont systemFontOfSize:13.0];
        [self.bottomView addSubview:_isVipLabel];
        [_isVipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.starRatingView.mas_left);
            make.top.equalTo(self.PriceLabel.mas_bottom).offset(AdaptH(8.5));
        }];
    }
}

- (void)addImgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        [self addSubview:_imgView];
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(AdaptW(36));
            make.bottom.equalTo(self.mas_bottom);
            make.size.mas_equalTo(CGSizeMake(AdaptW(156), AdaptH(214.5)));
        }];
    }
}

@end
