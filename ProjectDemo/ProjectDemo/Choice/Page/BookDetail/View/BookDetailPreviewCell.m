//
//  BookDetailPreviewCell.m
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/27.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import "BookDetailPreviewCell.h"

#import "BookDetailPreviewCollectionCell.h"
#import "VideoPlayer.h"
#import <YBImageBrowser.h>

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

- (NSArray *)photoBrowser {
    NSMutableArray *imgArr = [NSMutableArray array];
    for (NSInteger i = 0; i < self.dataSource.count; i++) {
        if ([self.dataSource[i].resourceType isEqualToString:@"PREVIEW_VIDEO"]) {
            continue;
        }
        [imgArr addObject:self.dataSource[i].ossUrl];
    }
    return imgArr;
}

- (void)showWithIndex:(NSUInteger)index {
    NSMutableArray *browserArr = [NSMutableArray array];
    for (NSInteger i = 0; i < [self photoBrowser].count; i++) {
        YBImageBrowserModel *browserModel = [[YBImageBrowserModel alloc] init];
        [browserModel setUrlWithDownloadInAdvance:[NSURL URLWithString:[self photoBrowser][i]]];
        [browserArr addObject:browserModel];
    }
    YBImageBrowser *browser = [YBImageBrowser new];
    [browser.toolBar setRightButtonHide:YES];
    browser.dataArray = [browserArr copy];
    browser.currentIndex = index;
    [browser show];
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

    BookDetailPreviewModel *previewModel = (BookDetailPreviewModel *)self.dataSource[indexPath.item];
    
    if ([previewModel.resourceType isEqualToString:@"PREVIEW_VIDEO"]) { // 视频播放
        [VideoPlayer showPlayerWithURL:previewModel.ossUrl coveUrl:previewModel.coverUrl];
    } else {
        [self showWithIndex:indexPath.item - 1];
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
