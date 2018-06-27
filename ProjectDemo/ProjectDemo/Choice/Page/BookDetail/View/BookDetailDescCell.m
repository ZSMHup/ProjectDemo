//
//  BookDetailDescCell.m
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/27.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import "BookDetailDescCell.h"

#import "BookDetailModel.h"

@interface BookDetailDescCell ()

@property (nonatomic, strong) UILabel *descLabel;

@end

@implementation BookDetailDescCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addDescLabel];
    }
    return self;
}

- (void)setModel:(BookDetailModel *)model {
    _model = model;
    
    self.descLabel.text = model.bookIntroduction;
}

- (void)addDescLabel {
    if (!_descLabel) {
        _descLabel = [[UILabel alloc] init];
        _descLabel.numberOfLines = 0;
        _descLabel.textColor = [UIColor blackColor];
        _descLabel.font = [UIFont systemFontOfSize:14.0];
        [self.contentView addSubview:_descLabel];
        [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(AdaptH(10));
            make.left.equalTo(self.contentView.mas_left).offset(AdaptW(36));
            make.right.equalTo(self.contentView.mas_right).offset(AdaptW(-36));
            make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        }];
    }
}

@end
