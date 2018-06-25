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

@property (nonatomic, copy) NSString *bookName;
@property (nonatomic, copy) NSString *bookIntroduction;
/**图书code 请求书籍详情需要*/
@property (nonatomic, copy) NSString *bookCode;
/***/
@property (nonatomic, strong) NSArray <EbBookModel *>*ebBookResource;

@end
