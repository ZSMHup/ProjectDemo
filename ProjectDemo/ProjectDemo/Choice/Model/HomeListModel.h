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

/**位置idex*/
@property (nonatomic, copy) NSString *idx;
/**大标题*/
@property (nonatomic, copy) NSString *partTitle;
/***/
@property (nonatomic, copy) NSString *partStyle;
/***/
@property (nonatomic, copy) NSString *partType;
/**更多*/
@property (nonatomic, copy) NSString *targetDesc;
/***/
@property (nonatomic, copy) NSString *partSourceNum;
/***/
@property (nonatomic, strong) NSArray <DailyListModel *>*dailyList;
/***/
@property (nonatomic, strong) NSArray <BookListModel *>*bookList;

@end
