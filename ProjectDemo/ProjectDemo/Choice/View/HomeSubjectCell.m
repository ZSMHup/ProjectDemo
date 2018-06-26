//
//  HomeSubjectCell.m
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/25.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import "HomeSubjectCell.h"
#import "HomeSubjectCollectionCell.h"

@interface HomeSubjectCell () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *subjectArray;

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation HomeSubjectCell

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

#pragma mark - UICollectionView DataSource, delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.subjectArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HomeSubjectCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeSubjectCollectionCell" forIndexPath:indexPath];
    [cell setImageName:self.subjectArray[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(view:didSelectItemAtIndexPath:model:)]) {
        [self.delegate view:self didSelectItemAtIndexPath:indexPath model:nil];
    }
}


#pragma mark - UICollectionView flowlayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(AdaptW(176), AdaptH(121));
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 6.0;
}

#pragma mark - getter
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_flowLayout];
        _collectionView.contentInset = UIEdgeInsetsMake(10.f, AdaptW(26), 0, AdaptW(26));
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[HomeSubjectCollectionCell class] forCellWithReuseIdentifier:@"HomeSubjectCollectionCell"];
    }
    return _collectionView;
}

- (NSArray *)subjectArray {
    if (!_subjectArray) {
        _subjectArray = @[@"all_category", @"free_ prefecture", @"hot_book", @"new_ putaway"];
    }
    return _subjectArray;
}

@end
