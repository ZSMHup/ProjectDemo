//
//  HomeListModel.h
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/25.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import "NetworkRequestModel.h"

@class DailyListModel;
@class BookListModel;
@interface HomeListModel : NetworkRequestModel


@property (nonatomic, copy) NSString *partCode; // 栏目编号
@property (nonatomic, copy) NSString *partTitle; // 栏目标题
@property (nonatomic, copy) NSString *partStyle; // LIST_HAND:手动列表 ,LIST_AUTO:自动列表
@property (nonatomic, copy) NSString *partType;
@property (nonatomic, copy) NSString *partSource; // 展示数据地址
@property (nonatomic, copy) NSString *partSourceNum; // 展示数量
@property (nonatomic, copy) NSString *targetType; // 跳转的目标类型 BOOK_DETAIL:图书详情 ,H5:H5页面,SYSTEM_INTERFACE:系统界面 ,BOOK_LIST:图书列表页
@property (nonatomic, copy) NSString *targetDesc; // 查看全部 跳转描述
@property (nonatomic, copy) NSString *targetPage; // 查看全部 跳转URL
@property (nonatomic, copy) NSString *idx; // 排序号
@property (nonatomic, strong) NSArray <DailyListModel *>*dailyList; // 每日绘本图书列表
@property (nonatomic, strong) NSArray <BookListModel *>*bookList; // 图书列表

/***/

@end
