//
//  BookDetailEvaluateModel.m
//  ProjectDemo
//
//  Created by 张书孟 on 2018/6/28.
//  Copyright © 2018年 ZSM. All rights reserved.
//

#import "BookDetailEvaluateModel.h"

@implementation BookDetailEvaluateModel

- (CGFloat)commentScoreFormatter {
    CGFloat score = 0;
    if (self.commentScore) {
        score = [self.commentScore floatValue];
        score = score / 5.0;
    }
    return score;
}

- (NSString *)commentTimeFormatter {
    NSString *time = @"2018-8-31";
    
    if (self.commentTime) {
        NSTimeInterval interval = [self.commentTime doubleValue] / 1000.0;
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        time = [formatter stringFromDate: date];
    }
    
    return time;
}

@end
