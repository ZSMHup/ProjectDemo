//
//  HomeHorizontalCollectionCell.m
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/26.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import "HomeHorizontalCollectionCell.h"

#import "BookListModel.h"
#import "EbBookModel.h"

@interface HomeHorizontalCollectionCell()

@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *subjectLabel;

@end

@implementation HomeHorizontalCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
    }
    return self;
}

- (void)setBookListModel:(BookListModel *)bookListModel {
    _bookListModel = bookListModel;
    EbBookModel *bookModel = bookListModel.ebBookResource.firstObject;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:bookModel.ossUrl]];
    self.subjectLabel.text = bookListModel.bookName;
}

- (void)setBookModel:(BookListModel *)bookModel {
    _bookModel = bookModel;
    
    [self.imgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(AdaptH(126));
    }];
    self.subjectLabel.numberOfLines = 1;
    EbBookModel *ebBookModel = bookModel.ebBookResource.firstObject;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:ebBookModel.ossUrl]];
    self.subjectLabel.text = bookModel.bookName;
}

- (void)addSubViews {
    self.backgroundColor = [UIColor whiteColor];
    [self addImgView];
    [self addSubjectLabel];
}

- (void)addImgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        [self.contentView addSubview:_imgView];
        [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self.contentView);
            make.height.mas_equalTo(AdaptH(214.5));
        }];
    }
}

- (void)addSubjectLabel {
    if (!_subjectLabel) {
        _subjectLabel = [[UILabel alloc] init];
        _subjectLabel.textColor = [UIColor blackColor];
        _subjectLabel.numberOfLines = 2;
        _subjectLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_subjectLabel];
        [_subjectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.imgView);
            make.top.equalTo(self.imgView.mas_bottom).offset(AdaptH(12));
        }];
    }
}



@end
