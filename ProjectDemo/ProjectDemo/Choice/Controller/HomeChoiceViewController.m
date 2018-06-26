//
//  HomeChoiceViewController.m
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/25.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import "HomeChoiceViewController.h"

#import "CommenWebViewController.h"
#import "BookDetailViewController.h"

#import "HomeSubjectCell.h"
#import "HomeH5Cell.h"
#import "HomeHorizontalHasButtonCell.h"
#import "HomeHorizontalCell.h"
#import "HomeHorizontalCollectionCell.h"
#import "HomeSectionView.h"

#import "SubjectListModel.h"
#import "HomeListModel.h"
#import "DailyListModel.h"

#import "HomeRequest.h"


@interface HomeChoiceViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, DidSelectItemDelegate>

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray <SubjectListModel *>*subjectArray;
@property (nonatomic, strong) NSMutableArray <HomeListModel *>*homeListArray;

@end

@implementation HomeChoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSubViews];
}

#pragma mark - setupUI

- (void)addSubViews {
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    kWeakSelf(self)
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself loadDate];
    }];
                                     
    [self.collectionView.mj_header beginRefreshing];
}

- (void)loadDate {
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_enter(group);
    [HomeRequest requestSubjectListWithParameters:nil responseCaches:^(SubjectListModel *model) {
        
        if ([self.collectionView.mj_header isRefreshing]) {
            self.subjectArray = [model.responseResultList mutableCopy];
        }
        
    } success:^(SubjectListModel *model) {
        
        self.subjectArray = [model.responseResultList mutableCopy];
        
        dispatch_group_leave(group);
    } failure:^(NSError *error) {
        [AYProgressHUD showNetworkError];
        dispatch_group_leave(group);
    }];
    
    dispatch_group_enter(group);
    [HomeRequest requestHomeListWithParameters:nil responseCaches:^(HomeListModel *model) {
        if ([self.collectionView.mj_header isRefreshing]) {
            self.homeListArray = [model.responseResultList mutableCopy];
        }
    } success:^(HomeListModel *model) {
        
        self.homeListArray = [model.responseResultList mutableCopy];
        
        dispatch_group_leave(group);
    } failure:^(NSError *error) {
        [AYProgressHUD showNetworkError];
        dispatch_group_leave(group);
    }];
    
    kWeakSelf(self)
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if ([weakself.collectionView.mj_header isRefreshing]) {
            [weakself.collectionView.mj_header endRefreshing];
        }
        [self.dataSource removeAllObjects];
        [self.dataSource addObjectsFromArray:self.homeListArray];
        [weakself.collectionView reloadData];
    });
}

/*
 1. targetType = H5;
    partStyle = DAILY_BOOK;
 
 2. targetType = BOOK_LIST;
 partStyle = IMAGE_TEXT;      btn
 
 3. targetType = BOOK_LIST;
    partStyle = SLIDE_HORIZONTAL; 横向
 
 4. targetType = BOOK_LIST;
    partStyle = SLIDE_PORTRAIT;
 
*/

#pragma mark - UICollectionView DataSource, delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataSource.count + (kArrayIsEmpty(self.subjectArray) ? 0 : 1);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (!kArrayIsEmpty(self.subjectArray)) {
        if (section == 0) {
            return 1;
        }
    }
    HomeListModel *model = self.dataSource[section - (kArrayIsEmpty(self.subjectArray) ? 0 : 1)];
    if ([model.partStyle isEqualToString:@"SLIDE_PORTRAIT"]) { // 竖向
        return model.bookList.count;
    } else { // 单个或者横向
        return 1;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!kArrayIsEmpty(self.subjectArray)) {
        if (indexPath.section == 0) {
            HomeSubjectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeSubjectCell" forIndexPath:indexPath];
            cell.delegate = self;
            return cell;
        }
    }
    
    HomeListModel *model = self.dataSource[indexPath.section - (kArrayIsEmpty(self.subjectArray) ? 0 : 1)];
    
    if ([model.partStyle isEqualToString:@"SLIDE_PORTRAIT"]) { // 竖向
        HomeHorizontalCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeHorizontalCollectionCell" forIndexPath:indexPath];
        [cell setBookListModel:model.bookList[indexPath.item]];
        return cell;
        
    } else { // 单个或者横向
        if ([model.partStyle isEqualToString:@"DAILY_BOOK"]) {
            HomeH5Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeH5Cell" forIndexPath:indexPath];
            [cell setModel:model.dailyList.firstObject];
            
            return cell;
        } else if ([model.partStyle isEqualToString:@"IMAGE_TEXT"]) {
            HomeHorizontalHasButtonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeHorizontalHasButtonCell" forIndexPath:indexPath];
            [cell setDataSource:model.bookList];
            cell.delegate = self;
            return cell;
        } else {
            HomeHorizontalCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeHorizontalCell" forIndexPath:indexPath];
            [cell setDataSource:model.bookList];
            cell.delegate = self;
            return cell;
        }
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        // 头部
        UICollectionReusableView *reusableview = nil;
        
        if (!kArrayIsEmpty(self.subjectArray)) {
            if (indexPath.section == 0) {
                UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind   withReuseIdentifier:@"UICollectionReusableViewHeaderDefault" forIndexPath:indexPath];
                return view;
            }
        }
        HomeListModel *model = self.dataSource[indexPath.section - (kArrayIsEmpty(self.subjectArray) ? 0 : 1)];
        HomeSectionView *view = (HomeSectionView *)[collectionView dequeueReusableSupplementaryViewOfKind:kind   withReuseIdentifier:@"UICollectionReusableViewHeader" forIndexPath:indexPath];
        [view setModel:model];
        view.sectionViewClick = ^{
            // MARK: 点击section
        };
        reusableview = view;
        return reusableview;
    }
    return nil;
}

// 处理滚动条被 UICollectionReusableView 遮挡
- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    view.layer.zPosition = 0.0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    HomeListModel *model = self.dataSource[indexPath.section - (kArrayIsEmpty(self.subjectArray) ? 0 : 1)];
    
    if ([model.targetType isEqualToString:@"H5"]) {
        DailyListModel *h5Model = model.dailyList.firstObject;
        CommenWebViewController *webViewVc = [[CommenWebViewController alloc] init];
        webViewVc.webUrl = h5Model.targetPage;
        webViewVc.navigationItem.title = @"每日读绘本";
        [self.navigationController pushViewController:webViewVc animated:YES];
    } else { // 单个或者横向

        BookDetailViewController *bookDetailVC = [[BookDetailViewController alloc] init];
        [self.navigationController pushViewController:bookDetailVC animated:YES];
    }
}

#pragma mark - UICollectionView flowlayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (!kArrayIsEmpty(self.subjectArray)) {
        if (indexPath.section == 0) {
            return CGSizeMake(kScreenWidth, AdaptH(143));
        }
    }
    HomeListModel *model = self.dataSource[indexPath.section - (kArrayIsEmpty(self.subjectArray) ? 0 : 1)];

    if ([model.partStyle isEqualToString:@"SLIDE_PORTRAIT"]) { // 竖向
        return CGSizeMake(AdaptW(156), AdaptH(258.5));
        
    } else { // 单个或者横向
        if ([model.partStyle isEqualToString:@"DAILY_BOOK"]) {
            return CGSizeMake(kScreenWidth, AdaptH(397.5));
        } else if ([model.partStyle isEqualToString:@"IMAGE_TEXT"]) {
            return CGSizeMake(kScreenWidth, AdaptH(175));
        } else {
            return CGSizeMake(kScreenWidth, AdaptH(165));
        }
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return AdaptW(24);
}

/** 头部的尺寸 */
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    if (!kArrayIsEmpty(self.subjectArray)) {
        if (section == 0) {
            return CGSizeMake(kScreenWidth, CGFLOAT_MIN);
        }
    }
    return CGSizeMake(kScreenWidth, 64.0);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (!kArrayIsEmpty(self.subjectArray)) {
        if (section == 0) {
            return UIEdgeInsetsMake(0, 0, 0, 0);
        }
    }
    HomeListModel *model = self.dataSource[section - (kArrayIsEmpty(self.subjectArray) ? 0 : 1)];
    if ([model.partStyle isEqualToString:@"SLIDE_PORTRAIT"]) { // 竖向
        return UIEdgeInsetsMake(10, AdaptW(36), 12, AdaptW(36));
    }
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark - DidSelectItemDelegate
- (void)view:(UICollectionViewCell *)view didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([view isKindOfClass:[HomeSubjectCell class]]) {
        NSLog(@"HomeSubjectCell: %ld", indexPath.item);
    } else {
        BookDetailViewController *bookDetailVC = [[BookDetailViewController alloc] init];
        [self.navigationController pushViewController:bookDetailVC animated:YES];
    }
    
}

#pragma mark - getter
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[HomeSubjectCell class] forCellWithReuseIdentifier:@"HomeSubjectCell"];
        [_collectionView registerClass:[HomeH5Cell class] forCellWithReuseIdentifier:@"HomeH5Cell"];
        [_collectionView registerClass:[HomeHorizontalHasButtonCell class] forCellWithReuseIdentifier:@"HomeHorizontalHasButtonCell"];
        [_collectionView registerClass:[HomeHorizontalCell class] forCellWithReuseIdentifier:@"HomeHorizontalCell"];
        [_collectionView registerClass:[HomeHorizontalCollectionCell class] forCellWithReuseIdentifier:@"HomeHorizontalCollectionCell"];
        
        [_collectionView registerClass:[HomeSectionView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableViewHeader"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableViewHeaderDefault"];
    }
    return _collectionView;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableArray *)subjectArray {
    if (!_subjectArray) {
        _subjectArray = [NSMutableArray array];
    }
    return _subjectArray;
}

- (NSMutableArray *)homeListArray {
    if (!_homeListArray) {
        _homeListArray = [NSMutableArray array];
    }
    return _homeListArray;
}

@end
