//
//  BookDetailPreviewCell.m
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/27.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import "BookDetailPreviewCell.h"

#import "BookDetailPreviewCollectionCell.h"

#import "BookDetailPreviewModel.h"

@interface BookDetailPreviewCell () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation BookDetailPreviewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addSubViews];
    }
    return self;
}

- (void)addSubViews {
    [self.contentView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (void)setDataSource:(NSArray<BookDetailPreviewModel *> *)dataSource {
    _dataSource = dataSource;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionView DataSource, delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    BookDetailPreviewCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BookDetailPreviewCollectionCell" forIndexPath:indexPath];
    [cell setModel:self.dataSource[indexPath.item]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(view:didSelectItemAtIndexPath:model:)]) {
        [self.delegate view:self didSelectItemAtIndexPath:indexPath model:self.dataSource[indexPath.item]];
    }
}

#pragma mark - UICollectionView flowlayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(AdaptW(340.5), AdaptH(159));
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return AdaptW(20);
}

#pragma mark - getter
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_flowLayout];
        _collectionView.contentInset = UIEdgeInsetsMake(0, AdaptW(36), 0, AdaptW(36));
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[BookDetailPreviewCollectionCell class] forCellWithReuseIdentifier:@"BookDetailPreviewCollectionCell"];
    }
    return _collectionView;
}

@end
