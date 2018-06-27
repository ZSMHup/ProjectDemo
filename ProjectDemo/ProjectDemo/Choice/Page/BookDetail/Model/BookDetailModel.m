//
//  BookDetailModel.m
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/27.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import "BookDetailModel.h"
#import "EbBookModel.h"
#import "BookAuthorModel.h"
#import "BookPriceModel.h"

@implementation BookDetailModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"ebBookResource" : [EbBookModel class],
             @"bookAuthor" : [BookAuthorModel class],
             @"bookPrice" : [BookPriceModel class]
             };
}


- (CGFloat)bookScoreFormatter {
    CGFloat score = 0;
    if (self.bookScore) {
        score = [self.bookScore floatValue];
        score = score / 5.0;
    }
    return score;
}

@end
