//
//  HomeHorizontalCell.m
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/26.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import "HomeHorizontalCell.h"

#import "HomeHorizontalCollectionCell.h"

#import "BookListModel.h"

@interface HomeHorizontalCell () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation HomeHorizontalCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
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

- (void)setDataSource:(NSArray<BookListModel *> *)dataSource {
    _dataSource = dataSource;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionView DataSource, delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeHorizontalCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeHorizontalCollectionCell" forIndexPath:indexPath];
    [cell setBookModel:self.dataSource[indexPath.item]];
    return cell;
}

#pragma mark - UICollectionView flowlayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(AdaptW(92), AdaptH(162));
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
        [_collectionView registerClass:[HomeHorizontalCollectionCell class] forCellWithReuseIdentifier:@"HomeHorizontalCollectionCell"];
    }
    return _collectionView;
}

@end
