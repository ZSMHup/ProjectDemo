//
//  CommentListViewController.m
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/29.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import "CommentListViewController.h"

#import "BookDetailCommentCell.h"

#import "BookDetailEvaluateModel.h"

#import "HomeRequest.h"
#import "AudioPlayerManager.h"


@interface CommentListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray <BookDetailEvaluateModel *>*evaluateArray;

@property (nonatomic, assign) NSInteger page;

@end

@implementation CommentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBarAlpha:1];
    [self addSubViews];
}

- (void)addSubViews {
    self.navigationItem.title = @"全部评论";
    [self addTableView];
    kWeakSelf(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        weakself.page = 0;
        [weakself requestCommentList];
    }];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        weakself.page++;
        [weakself requestCommentList];
    }];
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)requestCommentList {
    [HomeRequest requestBookDetailCommentWithBookCode:self.bookListModel.bookCode pageIndex:self.page success:^(BookDetailEvaluateModel *model) {
        if ([self.tableView.mj_header isRefreshing]) {
            [self.tableView.mj_header endRefreshing];
            [self.evaluateArray removeAllObjects];
        }
        
        if ([self.tableView.mj_footer isRefreshing]) {
            [self.tableView.mj_footer endRefreshing];
        }
        
        [self.evaluateArray addObjectsFromArray:model.responseResultList];
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        [AYProgressHUD showNetworkError];
        if ([self.tableView.mj_header isRefreshing]) {
            [self.tableView.mj_header endRefreshing];
        }
        
        if ([self.tableView.mj_footer isRefreshing]) {
            [self.tableView.mj_footer endRefreshing];
        }
    }];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.evaluateArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    BookDetailCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookDetailCommentCell"];
    [cell setModel:self.evaluateArray[indexPath.row]];
    
    kWeakSelf(self);
    cell.playerCallBack = ^(UIButton *sender) {
        sender.selected = !sender.selected;
        
        if (sender.selected) {
            for (NSInteger i = 0; i < weakself.evaluateArray.count; i++) {
                weakself.evaluateArray[i].isStopAudio = NO;
            }
            weakself.evaluateArray[indexPath.row].isStopAudio = YES;
            
            [[AudioPlayerManager sharedInstance] playerWithURL:weakself.evaluateArray[indexPath.row].commentVoiceUrl];
        } else {
            for (NSInteger i = 0; i < weakself.evaluateArray.count; i++) {
                weakself.evaluateArray[i].isStopAudio = NO;
            }
        }
        [weakself.tableView reloadData];
        
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - getter
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
        [_tableView registerClass:[BookDetailCommentCell class] forCellReuseIdentifier:@"BookDetailCommentCell"];
        [self.view addSubview:_tableView];
        adjustsScrollViewInsets_NO(_tableView, self);
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self.view);
        }];
    }
}

- (NSMutableArray<BookDetailEvaluateModel *> *)evaluateArray {
    if (!_evaluateArray) {
        _evaluateArray = [NSMutableArray array];
    }
    return _evaluateArray;
}

@end
