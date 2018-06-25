//
//  HomeSubjectCollectionCell.m
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/25.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import "HomeSubjectCollectionCell.h"

@interface HomeSubjectCollectionCell ()

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation HomeSubjectCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
    }
    return self;
}

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    self.imgView.image = [UIImage imageNamed:imageName];
}

- (void)addSubViews {
    [self addImgView];
}

- (void)addImgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.imgView];
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(self.contentView.mas_top).offset(5);
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
        }];
    }
}

@end
