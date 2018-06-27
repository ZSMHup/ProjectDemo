//
//  BookDetailViewController.m
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/26.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import "BookDetailViewController.h"

#import "BookDetailHeadView.h"
#import "SectionView.h"
#import "BookDetailDescCell.h"
#import "BookDetailRecCell.h"
#import "BookDetailPreviewCell.h"

#import "BookDetailModel.h"
#import "BookListModel.h"
#import "BookDetailPreviewModel.h"
#import "EbBookModel.h"

#import "HomeRequest.h"

@interface BookDetailViewController () <UITableViewDelegate, UITableViewDataSource, DidSelectItemDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) BookDetailHeadView *headerView;

@property (nonatomic, strong) BookDetailModel *bookDetailModel;

@property (nonatomic, strong) NSMutableArray <BookListModel *>*bookListArray;
@property (nonatomic, strong) NSMutableArray <BookDetailPreviewModel *>*bookPreviewArray;

@end

@implementation BookDetailViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self scrollViewDidScroll:self.tableView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self scrollViewDidScroll:self.tableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addSubViews];
    [self requestDetailData];
}

- (void)addSubViews {
    [self addTableView];
    
}

- (void)requestDetailData {
    [AYProgressHUD show];
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_enter(group);
    [HomeRequest requestBookDetailWithBookCode:self.bookListModel.bookCode success:^(BookDetailModel *model) {
        
        self.bookDetailModel = model;
        [self.headerView setBookDetailModel:model];
        dispatch_group_leave(group);
    } failure:^(NSError *error) {
        [AYProgressHUD showNetworkError];
        dispatch_group_leave(group);
    }];
    
    dispatch_group_enter(group);
    [HomeRequest requestBookDetailRecWithBookCode:self.bookListModel.bookCode success:^(BookListModel *model) {
        
        self.bookListArray = [model.responseResultList mutableCopy];
        dispatch_group_leave(group);
    } failure:^(NSError *error) {
        [AYProgressHUD showNetworkError];
        dispatch_group_leave(group);
    }];
    
    dispatch_group_enter(group);
    [HomeRequest requestBookDetailPreviewWithBookCode:self.bookListModel.bookCode resource:@"normal" success:^(BookDetailPreviewModel *model) {
        
        self.bookPreviewArray = [model.responseResultList mutableCopy];
        EbBookModel *listModel = self.bookListModel.ebBookResource.firstObject;
        for (NSInteger i = 0; i < self.bookPreviewArray.count; i++) {
            self.bookPreviewArray[i].coverUrl = listModel.ossUrl;
        }
        
        dispatch_group_leave(group);
    } failure:^(NSError *error) {
        [AYProgressHUD showNetworkError];
        dispatch_group_leave(group);
    }];
    
    kWeakSelf(self)
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [AYProgressHUD dismiss];
        
        
        [weakself.tableView reloadData];
    });
    
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0: {
            BookDetailDescCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookDetailDescCell"];
            [cell setModel:self.bookDetailModel];
            return cell;
        }
        case 1: {
            BookDetailPreviewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookDetailPreviewCell"];
            
            [cell setDataSource:self.bookPreviewArray];
            cell.delegate = self;
            return cell;
        }
        case 2: {
            BookDetailRecCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookDetailRecCell"];
            [cell setDataSource:self.bookListArray];
            cell.delegate = self;
            return cell;
        }
        default: {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
            
            return cell;
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return nil;
    }
    
    NSArray *titles = @[@"绘本预览", @"更多推荐", @"评价"];
    SectionView *sectionView = [[SectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 54)];
    [sectionView setTitle:titles[section - 1]];
    return sectionView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
            return UITableViewAutomaticDimension;
        case 1:
            return AdaptH(184);
        case 2:
            return AdaptH(175);
        default:
            return 150;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGFLOAT_MIN;
    }
    return AdaptH(54);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    
    scrollView.scrollEnabled = YES;
    if (offsetY < 0) {
        scrollView.scrollEnabled = NO;
        [self setNavBarAlpha:0];
    } else {
        if (offsetY > 104) {
            self.navigationItem.title = self.bookListModel.bookName;
            [self setNavBarAlpha:1.0];
        } else {
            CGFloat alpha = (offsetY / 104);
            [self setNavBarAlpha:alpha];
            self.navigationItem.title = @"";
        }
    }
}

#pragma mark - DidSelectItemDelegate
- (void)view:(UIView *)view didSelectItemAtIndexPath:(NSIndexPath *)indexPath model:(id)mdoel {
    if ([view isKindOfClass:[BookDetailPreviewCell class]]) {

        NSLog(@"BookDetailPreviewCell: %ld", indexPath.item);
    } else {
        BookDetailViewController *bookDetailVC = [[BookDetailViewController alloc] init];
        bookDetailVC.bookListModel = (BookListModel *)mdoel;
        [self.navigationController pushViewController:bookDetailVC animated:YES];
    }
}

#pragma mark - getter
- (BookDetailModel *)bookDetailModel {
    if (!_bookDetailModel) {
        _bookDetailModel = [[BookDetailModel alloc] init];
    }
    return _bookDetailModel;
}

- (BookDetailHeadView *)headerView {
    if (!_headerView) {
        _headerView = [[BookDetailHeadView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, AdaptH(295)) bookDetailModel:self.bookDetailModel];
    }
    return _headerView;
}

- (void)addTableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 80;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = self.headerView;
        [_tableView registerClass:[BookDetailDescCell class] forCellReuseIdentifier:@"BookDetailDescCell"];
        [_tableView registerClass:[BookDetailRecCell class] forCellReuseIdentifier:@"BookDetailRecCell"];
        [_tableView registerClass:[BookDetailPreviewCell class] forCellReuseIdentifier:@"BookDetailPreviewCell"];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        [self.view addSubview:_tableView];
        adjustsScrollViewInsets_NO(_tableView, self);
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
}

- (NSMutableArray<BookListModel *> *)bookListArray {
    if (!_bookListArray) {
        _bookListArray = [NSMutableArray array];
    }
    return _bookListArray;
}

- (NSMutableArray<BookDetailPreviewModel *> *)bookPreviewArray {
    if (!_bookPreviewArray) {
        _bookPreviewArray = [NSMutableArray array];
    }
    return _bookPreviewArray;
}

@end
