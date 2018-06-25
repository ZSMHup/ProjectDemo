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

@end
