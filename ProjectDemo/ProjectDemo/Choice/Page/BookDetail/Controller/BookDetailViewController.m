//
//  BookDetailViewController.m
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/26.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import "BookDetailViewController.h"
#import "CommentListViewController.h"

#import "BookDetailHeadView.h"
#import "SectionView.h"
#import "VideoPlayer.h"
#import "BookDetailDescCell.h"
#import "BookDetailRecCell.h"
#import "BookDetailPreviewCell.h"
#import "BookDetailCommentCell.h"

#import "BookDetailModel.h"
#import "BookListModel.h"
#import "BookDetailPreviewModel.h"
#import "EbBookModel.h"
#import "BookDetailEvaluateModel.h"

#import "HomeRequest.h"

@interface BookDetailViewController () <UITableViewDelegate, UITableViewDataSource, DidSelectItemDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) BookDetailHeadView *headerView;
@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) BookDetailModel *bookDetailModel;

@property (nonatomic, strong) NSMutableArray <BookListModel *>*bookListArray;
@property (nonatomic, strong) NSMutableArray <BookDetailPreviewModel *>*bookPreviewArray;
@property (nonatomic, strong) NSMutableArray <BookDetailEvaluateModel *>*evaluateArray;
@property (nonatomic, assign) NSInteger commentCount;

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
    self.commentCount = 0;
    [self addTableView];
    [self addBottomView];
    
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
    
    dispatch_group_enter(group);
    [HomeRequest requestBookDetailCommentWithBookCode:self.bookListModel.bookCode pageIndex:0 success:^(BookDetailEvaluateModel *model) {
        if (model.responseResultList.count > 0) {
            if (model.responseResultList.count > 5) {
                self.evaluateArray = [[model.responseResultList subarrayWithRange:NSMakeRange(0, 5)] mutableCopy];
            } else {
                self.evaluateArray = [model.responseResultList mutableCopy];
            }
        }
        dispatch_group_leave(group);
    } failure:^(NSError *error) {
        [AYProgressHUD showNetworkError];
        dispatch_group_leave(group);
    }];
    
    dispatch_group_enter(group);
    [HomeRequest requestBookDetailAllCommentCountWithBookCode:self.bookListModel.bookCode success:^(BookDetailEvaluateModel *model) {
        self.commentCount = [model.commentCount integerValue];
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

- (void)allCommentClick {
    CommentListViewController *commentListVC = [[CommentListViewController alloc] init];
    commentListVC.bookListModel = self.bookListModel;
    [self.navigationController pushViewController:commentListVC animated:YES];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 3) {
        return self.evaluateArray.count;
    }
    
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
            BookDetailCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookDetailCommentCell"];
            [cell setModel:self.evaluateArray[indexPath.item]];
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
    if (section == 3) {
        [sectionView setIsHiddenRightBtn:NO];
    }
    return sectionView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if (section == 3) {
        UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, AdaptH(50))];
        footer.backgroundColor = [UIColor whiteColor];
        UIButton *label = [[UIButton alloc] init];
        [label setTitle:NSStringFormat(@"查看全部%ld条评论", self.commentCount) forState:(UIControlStateNormal)];
        [label setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [label addTarget:self action:@selector(allCommentClick) forControlEvents:(UIControlEventTouchUpInside)];
        label.titleLabel.font = [UIFont systemFontOfSize:16];
        [footer addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.equalTo(footer);
        }];
        return footer;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
        case 3:
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
    if (section == 3) {
        return AdaptH(50);
    }
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
- (void)view:(UIView *)view didSelectItemAtIndexPath:(NSIndexPath *)indexPath model:(id)model {

    BookDetailViewController *bookDetailVC = [[BookDetailViewController alloc] init];
    bookDetailVC.bookListModel = (BookListModel *)model;
    [self.navigationController pushViewController:bookDetailVC animated:YES];
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
        _tableView.backgroundColor = [UIColor backgroundColor];
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 80;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableHeaderView = self.headerView;
        [_tableView registerClass:[BookDetailDescCell class] forCellReuseIdentifier:@"BookDetailDescCell"];
        [_tableView registerClass:[BookDetailRecCell class] forCellReuseIdentifier:@"BookDetailRecCell"];
        [_tableView registerClass:[BookDetailPreviewCell class] forCellReuseIdentifier:@"BookDetailPreviewCell"];
        [_tableView registerClass:[BookDetailCommentCell class] forCellReuseIdentifier:@"BookDetailCommentCell"];
        [self.view addSubview:_tableView];
        adjustsScrollViewInsets_NO(_tableView, self);
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.view);
            make.bottom.equalTo(self.view.mas_bottom).offset(AdaptH(-50));
        }];
    }
}

- (void)addBottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor whiteColor];
        _bottomView.layer.borderWidth = 1;
        _bottomView.layer.borderColor = [UIColor grayColor].CGColor;
        [self.view addSubview:_bottomView];
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.height.mas_equalTo(AdaptH(50));
        }];
        
        UILabel *label = [[UILabel alloc] init];
        label.text = @"免费试读";
        label.textColor = [UIColor blackColor];
        label.font = [UIFont systemFontOfSize:16];
        [self.bottomView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.equalTo(self.bottomView);
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

- (NSMutableArray<BookDetailEvaluateModel *> *)evaluateArray {
    if (!_evaluateArray) {
        _evaluateArray = [NSMutableArray array];
    }
    return _evaluateArray;
}

@end
