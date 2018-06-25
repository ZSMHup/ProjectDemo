//
//  HomeChoiceViewController.m
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/25.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import "HomeChoiceViewController.h"

#import "HomeSubjectCell.h"
#import "HomeSectionView.h"

#import "SubjectListModel.h"
#import "HomeListModel.h"

#import "HomeRequest.h"

@interface HomeChoiceViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

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
        
    } success:^(SubjectListModel *model) {
        
        self.subjectArray = [model.responseResultList mutableCopy];
        
        dispatch_group_leave(group);
    } failure:^(NSError *error) {
        [AYProgressHUD showNetworkError];
        dispatch_group_leave(group);
    }];
    
    dispatch_group_enter(group);
    [HomeRequest requestHomeListWithParameters:nil responseCaches:^(HomeListModel *model) {
        
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
        NSLog(@"%@", self.dataSource);
        [weakself.collectionView reloadData];
    });
    
}

#pragma mark - UICollectionView DataSource, delegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataSource.count + (kArrayIsEmpty(self.subjectArray) ? 0 : 1);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    switch (section) {
            case 0:
            return 1;
        default:
            return 1;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
            case 0:{
            HomeSubjectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeSubjectCell" forIndexPath:indexPath];
            return cell;
            }
        default: {
            UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
            return cell;
        }
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        // 头部
        if (indexPath.section != 0) {
            UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind   withReuseIdentifier:@"UICollectionReusableViewHeader" forIndexPath:indexPath];
            UILabel *sectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200.0, 40.0)];
            sectionLabel.text = @"精彩";
            sectionLabel.font = [UIFont systemFontOfSize:20.0];
            [view addSubview:sectionLabel];
            return view;
        } else {
            UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind   withReuseIdentifier:@"UICollectionReusableViewHeaderDefault" forIndexPath:indexPath];
            return view;
        }
    }
    return nil;
}

#pragma mark - UICollectionView flowlayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
            case 0:
            return CGSizeMake(kScreenWidth, AdaptH(130));
        default:
            return CGSizeMake(kScreenWidth, AdaptH(130));
    }
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 6.0;
}

/** 头部的尺寸 */
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section != 0) {
        return CGSizeMake(kScreenWidth, 60.0);
    }
    return CGSizeMake(kScreenWidth, CGFLOAT_MIN);
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
        _collectionView.backgroundColor = [UIColor backgroundColor];
        [_collectionView registerClass:[HomeSubjectCell class] forCellWithReuseIdentifier:@"HomeSubjectCell"];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
        
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"UICollectionReusableViewHeader"];
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
