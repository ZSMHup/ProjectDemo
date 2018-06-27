//
//  BookListModel.h
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/25.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import "NetworkRequestModel.h"

@class EbBookModel;
@interface BookListModel : NetworkRequestModel

@property (nonatomic, copy) NSString *bookCode; // 图书编号
@property (nonatomic, copy) NSString *bookName; // 图书名称
@property (nonatomic, copy) NSString *bookIntroduction; // 图书简介
@property (nonatomic, copy) NSString *bookScore; // 图书评分
@property (nonatomic, assign) CGFloat bookScoreFormatter; // 图书评分
@property (nonatomic, copy) NSString *scoreNum; // 评分人数
@property (nonatomic, copy) NSString *bookPressName; // 系列名称
@property (nonatomic, copy) NSString *downloadNum; // 下载次数
@property (nonatomic, copy) NSString *readNum; // 阅读人数
@property (nonatomic, copy) NSString *realReadNum;
@property (nonatomic, copy) NSString *buyNum; // 购买人数
@property (nonatomic, copy) NSString *isVip; // 是否会员借阅 VIP_NO-否 VIP_YES-是
@property (nonatomic, strong) NSArray <EbBookModel *>*ebBookResource; // 图书资源

@end
