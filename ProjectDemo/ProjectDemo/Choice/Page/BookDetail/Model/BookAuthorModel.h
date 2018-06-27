//
//  BookAuthorModel.h
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/27.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import "NetworkRequestModel.h"

@interface BookAuthorModel : NetworkRequestModel

@property (nonatomic, copy) NSString *authorCode;
@property (nonatomic, copy) NSString *authorName;
@property (nonatomic, copy) NSString *authorType;
@property (nonatomic, copy) NSString *idx;

@end
