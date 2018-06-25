//
//  HomeListModel.m
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/25.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import "HomeListModel.h"

#import "DailyListModel.h"
#import "BookListModel.h"

@implementation HomeListModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"dailyList" : [DailyListModel class],
             @"bookList" : [BookListModel class]};
}

@end
