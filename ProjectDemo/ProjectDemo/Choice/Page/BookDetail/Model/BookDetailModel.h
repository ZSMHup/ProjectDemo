//
//  BookDetailModel.h
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/27.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import "NetworkRequestModel.h"

@class EbBookModel;
@class BookAuthorModel;
@class BookPriceModel;

@interface BookDetailModel : NetworkRequestModel

@property (nonatomic, copy) NSString *modeIntroUrl;
@property (nonatomic, copy) NSString *isVip;
@property (nonatomic, copy) NSString *bookName;
@property (nonatomic, copy) NSString *tags;
@property (nonatomic, copy) NSString *bookScore;
@property (nonatomic, assign) CGFloat bookScoreFormatter; // 图书评分
@property (nonatomic, copy) NSString *scoreNum;
@property (nonatomic, copy) NSString *bookPressName;
@property (nonatomic, copy) NSString *bookIntroduction;
@property (nonatomic, strong) NSArray <EbBookModel *>*ebBookResource;
@property (nonatomic, strong) NSArray <BookAuthorModel *>*bookAuthor;
@property (nonatomic, strong) NSArray <BookPriceModel *>*bookPrice;

@end
