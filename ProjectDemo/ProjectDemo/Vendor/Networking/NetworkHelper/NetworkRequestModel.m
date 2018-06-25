//
//  NetworkRequestModel.m
//  Tools
//
//  Created by 张书孟 on 2017/11/10.
//  Copyright © 2017年 张书孟. All rights reserved.
//

#import "NetworkRequestModel.h"

@implementation NetworkRequestModel
- (BOOL)success {
    NSString *code = [NSString stringWithFormat:@"%@", self.code];
    NSString *staus = [NSString stringWithFormat:@"%@", self.code];
    return [code isEqualToString:@"200"] || [staus isEqualToString:@"1"];
}

- (NSString *)responseMessage {
    return self.message;
}

@end

@implementation PageModel

@end
