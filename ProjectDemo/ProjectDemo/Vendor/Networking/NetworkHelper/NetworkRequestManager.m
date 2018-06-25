//
//  NetworkRequestManager.m
//  Tools
//
//  Created by 张书孟 on 2017/11/10.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "NetworkRequestManager.h"

#define kWindow [UIApplication sharedApplication].delegate.window

//#define kApiPrefix@"http://dev.ellabook.cn/rest/api/service"
#define kApiPrefix @"http://api.ellabook.cn/rest/api/service"

@implementation NetworkRequestManager


#pragma mark - 请求的公共方法

+ (NSURLSessionTask *)postRequestWithParameters:(NSDictionary *)parameter
                                     modelClass:(Class)modelClass
                                  responseCaches:(HttpRequestCache)responseCaches
                                        success:(HttpRequestSuccess)success
                                        failure:(HttpRequestFailed)failure {
    
    NetworkRequestManager *manager = [[NetworkRequestManager alloc] init];
    parameter = [self configParameters:parameter];
    manager.modelClass = modelClass;
    
    [NetworkHelper openLog];
    
    return [NetworkHelper POST:kApiPrefix parameters:parameter responseCache:^(id responseCache) {
//        if (responseCache) {
//            id object = [manager convertToModel:[responseCache yy_modelToJSONString]];
//            
//            if (responseCaches) {
//                responseCaches(object);
//            }
//        }
    } success:^(id responseObject) {
        id object = [manager convertToModel:[responseObject yy_modelToJSONString]];
        if (success) {
            success(object);
        }
    } failure:^(NSError *error) {
        NSDictionary *userInfo = [error.userInfo[NSUnderlyingErrorKey] userInfo];
        NSHTTPURLResponse *response = userInfo[@"com.alamofire.serialization.response.error.response"];
        if (response.statusCode == 500 || response.statusCode == 502 || response.statusCode == 404) {
            NetworkRequestModel *model = [[NetworkRequestModel alloc] init];
            model.message = @"服务器异常";
            !success ?: success(model);
        } else {
            !failure ? : failure(error);
        }
    }];
}


+ (NSDictionary *)configParameters:(NSDictionary *)parameters {
    NSMutableDictionary *mDic = [NSMutableDictionary dictionary];
//    NSString *accessToken = @"1413b137d62bf3aea469a524efc2b6";
//    if (accessToken) {
//        [mDic setObject:accessToken forKey:@"accessToken"];
//    } else {
//        [mDic setObject:@"" forKey:@"accessToken"];
//    }
//    [mDic setObject:@"4.0.5" forKey:@"version"];
//    [mDic setObject:@"1" forKey:@"deviceType"];
    for (NSString *key in parameters.allKeys) {
        NSString *value = parameters[key];
        [mDic setObject:value forKey:key];
    }
    return mDic;
}

- (id)convertToModel:(NSString *)JSONString {
    NSDictionary *resultDic = [self dictionaryWithJSON:JSONString];
    NSDictionary *object = resultDic[@"data"];
    NetworkRequestModel *model = [[NetworkRequestModel alloc] init];
    if ([object isKindOfClass:[NSDictionary class]]) {
        model = [self.modelClass yy_modelWithJSON:[object yy_modelToJSONString]];
    } else if ([object isKindOfClass:[NSArray class]]) {
        model = [[self.modelClass alloc] init];
        model.responseResultList = [NSArray yy_modelArrayWithClass:self.modelClass json:[object yy_modelToJSONString]];
    } else if ([object isKindOfClass:[NSString class]] || [object isKindOfClass:[NSNumber class]]) {
        model = [[self.modelClass alloc] init];
        model.responseResultString = (NSString *)object;
    } else {
        model = [[self.modelClass alloc] init];
    }
    
    if (resultDic[@"message"]) {
        model.message = resultDic[@"message"];
    }
    if (resultDic[@"code"]) {
        model.code = resultDic[@"code"];
    }
    
//    if ([model.statusCode isEqualToString:@"90000"] || [model.msg isEqualToString:@"accessToken失效"]) {
//        NSLog(@"accessToken失效");
//    }
    
    return model;
}

- (NSDictionary *)dictionaryWithJSON:(NSString *)string {
    NSError *error = nil;
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];

    id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:&error];
    if (result != nil && error == nil) {
        return result;
    } else {
        // 解析错误
        return nil;
    }
}

@end
