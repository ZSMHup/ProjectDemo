//
//  HomeRequest.h
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/25.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SubjectListModel;
@class HomeListModel;
@class BookDetailModel;
@class BookListModel;
@class BookDetailPreviewModel;
@class BookDetailEvaluateModel;

@interface HomeRequest : NSObject

+ (void)requestSubjectListWithParameters:(NSDictionary *)parameters
                          responseCaches:(void (^)(SubjectListModel *model))responseCaches
                                 success:(void (^)(SubjectListModel *model))success
                                 failure:(void (^)(NSError *error))failure;
// 首页全部数据
+ (void)requestHomeListWithParameters:(NSDictionary *)parameters
                       responseCaches:(void (^)(HomeListModel *model))responseCaches
                              success:(void (^)(HomeListModel *model))success
                              failure:(void (^)(NSError *error))failure;
// 图书详情
+ (void)requestBookDetailWithBookCode:(NSString *)bookCode
                              success:(void (^)(BookDetailModel *model))success
                              failure:(void (^)(NSError *error))failure;
// 图书详情 -- 推荐
+ (void)requestBookDetailRecWithBookCode:(NSString *)bookCode
                                 success:(void (^)(BookListModel *model))success
                                 failure:(void (^)(NSError *error))failure;
// 图书详情 -- 绘本预览
+ (void)requestBookDetailPreviewWithBookCode:(NSString *)bookCode
                                    resource:(NSString *)resource
                                     success:(void (^)(BookDetailPreviewModel *model))success
                                     failure:(void (^)(NSError *error))failure;
// 图书详情 -- 获取书籍详情底部评论数据
+ (void)requestBookDetailCommentWithBookCode:(NSString *)bookCode
                                     success:(void (^)(BookDetailEvaluateModel *model))success
                                     failure:(void (^)(NSError *error))failure;
@end
