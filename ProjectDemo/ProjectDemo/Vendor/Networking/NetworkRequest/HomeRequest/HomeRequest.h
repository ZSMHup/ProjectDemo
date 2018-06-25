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

@interface HomeRequest : NSObject

+ (void)requestSubjectListWithParameters:(NSDictionary *)parameters
                          responseCaches:(void (^)(SubjectListModel *model))responseCaches
                                 success:(void (^)(SubjectListModel *model))success
                                 failure:(void (^)(NSError *error))failure;

+ (void)requestHomeListWithParameters:(NSDictionary *)parameters
                       responseCaches:(void (^)(HomeListModel *model))responseCaches
                              success:(void (^)(HomeListModel *model))success
                              failure:(void (^)(NSError *error))failure;
@end
