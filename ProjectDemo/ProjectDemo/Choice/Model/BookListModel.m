//
//  BookListModel.m
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/25.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import "BookListModel.h"
#import "EbBookModel.h"

@implementation BookListModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"ebBookResource" : [EbBookModel class]};
}

@end
