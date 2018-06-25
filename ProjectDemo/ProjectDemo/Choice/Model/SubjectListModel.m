//
//  SubjectListModel.m
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/25.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import "SubjectListModel.h"

@implementation SubjectListModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"categoryId": @"id"};
}

@end
