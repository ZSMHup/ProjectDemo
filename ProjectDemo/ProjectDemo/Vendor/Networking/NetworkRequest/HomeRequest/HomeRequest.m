//
//  HomeRequest.m
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/25.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import "HomeRequest.h"
#import "NetworkRequestManager.h"

#import "SubjectListModel.h"
#import "HomeListModel.h"
#import "BookDetailModel.h"
#import "BookListModel.h"
#import "BookDetailPreviewModel.h"
#import "BookDetailEvaluateModel.h"

@implementation HomeRequest

+ (void)requestSubjectListWithParameters:(NSDictionary *)parameters
                          responseCaches:(void (^)(SubjectListModel *model))responseCaches
                                 success:(void (^)(SubjectListModel *model))success
                                 failure:(void (^)(NSError *error))failure {
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:@"ella.book.listSubject" forKey:@"method"];
    [NetworkRequestManager postRequestWithParameters:parameter modelClass:[SubjectListModel class] responseCaches:^(id responseCache) {
        SubjectListModel *model = (SubjectListModel *)responseCache;
        if (responseCaches) {
            responseCaches(model);
        }
    } success:^(id responseObject) {
        SubjectListModel *model = (SubjectListModel *)responseObject;
        if (success) {
            success(model);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 首页全部数据
+ (void)requestHomeListWithParameters:(NSDictionary *)parameters
                          responseCaches:(void (^)(HomeListModel *model))responseCaches
                                 success:(void (^)(HomeListModel *model))success
                                 failure:(void (^)(NSError *error))failure {
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:@"ella.book.listAllPart" forKey:@"method"];
    [NetworkRequestManager postRequestWithParameters:parameter modelClass:[HomeListModel class] responseCaches:^(id responseCache) {
        HomeListModel *model = (HomeListModel *)responseCache;
        if (responseCaches) {
            responseCaches(model);
        }
    } success:^(id responseObject) {
        HomeListModel *model = (HomeListModel *)responseObject;
        if (success) {
            success(model);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 图书详情
+ (void)requestBookDetailWithBookCode:(NSString *)bookCode
                              success:(void (^)(BookDetailModel *model))success
                              failure:(void (^)(NSError *error))failure {
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setObject:bookCode forKey:@"bookCode"];
    [parameter setObject:@"normal" forKey:@"resource"];
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NetworkRequestManager convertToJsonData:parameter] forKey:@"content"];
    [dic setObject:@"ella.book.getBookByCode" forKey:@"method"];
    
    [NetworkRequestManager postRequestWithParameters:dic modelClass:[BookDetailModel class] responseCaches:nil success:^(id responseObject) {
        BookDetailModel *model = (BookDetailModel *)responseObject;
        if (success) {
            success(model);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 图书详情 -- 推荐
+ (void)requestBookDetailRecWithBookCode:(NSString *)bookCode
                              success:(void (^)(BookListModel *model))success
                              failure:(void (^)(NSError *error))failure {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:@(0) forKey:@"pageIndex"];
    [param setObject:@(20) forKey:@"pageSize"];
    [param setObject:bookCode forKey:@"bookCode"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NetworkRequestManager convertToJsonData:param] forKey:@"content"];
    [dic setObject:@"ella.book.listBooksRecommend" forKey:@"method"];
    
    [NetworkRequestManager postRequestWithParameters:dic modelClass:[BookListModel class] responseCaches:nil success:^(id responseObject) {
        BookListModel *model = (BookListModel *)responseObject;
        if (success) {
            success(model);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 图书详情 -- 绘本预览
+ (void)requestBookDetailPreviewWithBookCode:(NSString *)bookCode
                                    resource:(NSString *)resource
                                 success:(void (^)(BookDetailPreviewModel *model))success
                                 failure:(void (^)(NSError *error))failure {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:bookCode forKey:@"bookCode"];
    [param setObject:resource forKey:@"resource"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NetworkRequestManager convertToJsonData:param] forKey:@"content"];
    [dic setObject:@"ella.book.listBookPreview" forKey:@"method"];
    
    [NetworkRequestManager postRequestWithParameters:dic modelClass:[BookDetailPreviewModel class] responseCaches:nil success:^(id responseObject) {
        BookDetailPreviewModel *model = (BookDetailPreviewModel *)responseObject;
        if (success) {
            success(model);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 图书详情 -- 获取书籍详情底部评论数据
+ (void)requestBookDetailCommentWithBookCode:(NSString *)bookCode
                                    pageIndex:(NSInteger)pageIndex
                                     success:(void (^)(BookDetailEvaluateModel *model))success
                                     failure:(void (^)(NSError *error))failure {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:@(pageIndex) forKey:@"pageIndex"];
    [param setObject:@(20) forKey:@"pageSize"];
    [param setObject:bookCode forKey:@"bookCode"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NetworkRequestManager convertToJsonData:param] forKey:@"content"];
    [dic setObject:@"ella.book.listBookComment" forKey:@"method"];
    
    [NetworkRequestManager postRequestWithParameters:dic modelClass:[BookDetailEvaluateModel class] responseCaches:nil success:^(id responseObject) {
        BookDetailEvaluateModel *model = (BookDetailEvaluateModel *)responseObject;
        if (success) {
            success(model);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

// 图书详情 -- 获取评论总数
+ (void)requestBookDetailAllCommentCountWithBookCode:(NSString *)bookCode
                                     success:(void (^)(BookDetailEvaluateModel *model))success
                                     failure:(void (^)(NSError *error))failure {
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:bookCode forKey:@"bookCode"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:[NetworkRequestManager convertToJsonData:param] forKey:@"content"];
    [dic setObject:@"ella.book.bookCommentCount" forKey:@"method"];
    
    [NetworkRequestManager postRequestWithParameters:dic modelClass:[BookDetailEvaluateModel class] responseCaches:nil success:^(id responseObject) {
        BookDetailEvaluateModel *model = (BookDetailEvaluateModel *)responseObject;
        if (success) {
            success(model);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


@end
